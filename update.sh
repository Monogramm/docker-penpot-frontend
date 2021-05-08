#!/bin/bash
set -eo pipefail

declare -A compose=(
	[mainline]='debian'
	[alpine]='alpine'
)

declare -A base=(
	[mainline]='debian'
	[alpine]='alpine'
)

declare -A dockerVariant=(
	[mainline]='debian'
	[alpine]='alpine'
)

# Only debian for now
variants=(
	mainline
	alpine
)

min_version='1.5'
dockerLatest='1.5'
dockerDefaultVariant='alpine'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-penpot-frontend"
# Retrieve automatically the latest versions (when release available)
latests=(
	main
	develop
	$( curl -fsSL 'https://api.github.com/repos/penpot/penpot/tags' |tac|tac| \
	grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+(-alpha|-beta)?' | \
	sort -urV )
)

# Remove existing images
echo "reset docker images"
rm -rf ./images/
mkdir ./images/

echo "update docker images"
readmeTags=
githubEnv=
travisEnv=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		if [ ! -d "images/$version" ]; then
			# Add GitHub Actions env var
			githubEnv="'$version', $githubEnv"
		fi

		for variant in "${variants[@]}"; do
			# Create the version directory with a Dockerfile.
			dir="images/$version/$variant"
			if [ -d "$dir" ]; then
				continue
			fi

			echo "updating $latest [$version-$variant]"
			mkdir -p "$dir"

			# Copy files.
			template="Dockerfile.${base[$variant]}.template"
			cp "template/$template" "$dir/Dockerfile"

			cp -r "template/hooks/" "$dir/"
			cp -r "template/test/" "$dir/"
			cp "template/.dockerignore" "$dir/.dockerignore"
			cp "template/.env" "$dir/.env"
			cp "template/entrypoint.sh" "$dir/entrypoint.sh"
			cp "template/docker-compose_${compose[$variant]}.yml" "$dir/docker-compose.test.yml"
			cp -rf 'template/nginx' "$dir/nginx"
			cp "template/config.js" "$dir/config.js"

			# Replace the variables.
			sed -ri -e '
				s/%%VARIANT%%/'"$variant"'/g;
				s/%%VERSION%%/'"$latest"'/g;
			' "$dir/Dockerfile"

			sed -ri -e '
				s|DOCKER_TAG=.*|DOCKER_TAG='"$version"'|g;
				s|DOCKER_REPO=.*|DOCKER_REPO='"$dockerRepo"'|g;
			' "$dir/hooks/run"

			# Create a list of "alias" tags for DockerHub post_push
			tagVariant=${dockerVariant[$variant]}
			if [ "$version" = "$dockerLatest" ]; then
				if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
					export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $tagVariant $latest $version latest "
				else
					export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $tagVariant "
				fi
			elif [ "$version" = "$latest" ]; then
				if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
					export DOCKER_TAGS="$latest-$tagVariant $latest "
				else
					export DOCKER_TAGS="$latest-$tagVariant "
				fi
			else
				if [ "$tagVariant" = "$dockerDefaultVariant" ]; then
					export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant $latest $version "
				else
					export DOCKER_TAGS="$latest-$tagVariant $version-$tagVariant "
				fi
			fi
			echo "${DOCKER_TAGS} " > "$dir/.dockertags"

			# Add README tags
			readmeTags="$readmeTags\n-   ${DOCKER_TAGS} (\`$dir/Dockerfile\`)"

			# Add Travis-CI env var
			travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

			if [[ $1 == 'build' ]]; then
				tag="$version-$variant"
				echo "Build Dockerfile for ${tag}"
				docker build -t "${dockerRepo}:${tag}" "$dir"
			fi
		done

	fi

done

# update README.md
sed '/^<!-- >Docker Tags -->/,/^<!-- <Docker Tags -->/{/^<!-- >Docker Tags -->/!{/^<!-- <Docker Tags -->/!d}}' README.md > README.md.tmp
sed -e "s|<!-- >Docker Tags -->|<!-- >Docker Tags -->\n$readmeTags\n|g" README.md.tmp > README.md
rm README.md.tmp

# update .github workflows
sed -i -e "s|version: \[.*\]|version: [${githubEnv}]|g" .github/workflows/hooks.yml

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
