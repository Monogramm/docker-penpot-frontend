FROM monogramm/docker-uxbox-builder:latest

ENV LEIN_ROOT=TRUE \
    UXBOX_VERSION=build-refactor \
    UXBOX_CONFIG_URL="/api" \
    UXBOX_DEMO=false \
    UXBOX_DEBUG=false

# Download source from github
ADD https://github.com/uxbox/uxbox/archive/${UXBOX_VERSION}.tar.gz /tmp/uxbox.tar.gz
# or copy frontend from source and build release
#COPY . /home/uxbox/uxbox-${UXBOX_VERSION}/frontend

RUN set -ex; \
    mkdir -p /home/uxbox; \
    cd /home/uxbox; \
    tar -xzf /tmp/uxbox.tar.gz; \
    rm -f /tmp/uxbox.tar.gz; \
    mv /home/uxbox/uxbox-${UXBOX_VERSION}/frontend /home/uxbox/; \
    rm -rf /home/uxbox/uxbox-${UXBOX_VERSION}; \
    cd /home/uxbox/frontend; \
    rm -f Dockerfile; \
    rm -rf ./dist ./node_modules; \
    sed -i \
        -e 's|"uxbox.config.url" ".*"|"uxbox.config.url" "${UXBOX_CONFIG_URL}"|g' \
        scripts/figwheel.clj; \
    sed -i \
        -e 's|url ".*")|url "${UXBOX_CONFIG_URL}")|g' \
        src/uxbox/config.cljs; \
    npm install; \
    npm run prod; \
    bash -c "/home/uxbox/frontend/scripts/dist-main"; \
    bash -c "/home/uxbox/frontend/scripts/dist-view"; \
    bash -c "/home/uxbox/frontend/scripts/dist-worker"



# Once application has been built, prepare production image
FROM nginx:mainline

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Copy built app to www root
COPY --from=0 /home/uxbox/frontend/dist /usr/share/nginx/html

# NGINX configurations
COPY ./nginx/conf.d /etc/nginx/conf.d
