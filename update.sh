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

# Only debian for now
variants=(
	mainline
	alpine
)

min_version='1.0'
dockerLatest='1.0'


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
travisEnv=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

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
			if [ "$version" = "$dockerLatest" ]; then
				if [ "$variant" = 'apache' ]; then
					export DOCKER_TAGS="$latest-$variant $version-$variant $variant $latest $version latest "
				else
					export DOCKER_TAGS="$latest-$variant $version-$variant $variant "
				fi
			else
				if [ "$variant" = 'apache' ]; then
					export DOCKER_TAGS="$latest-$variant $version-$variant $latest $version "
				else
					export DOCKER_TAGS="$latest-$variant $version-$variant "
				fi
			fi
			echo "${DOCKER_TAGS} " > "$dir/.dockertags"

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

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
