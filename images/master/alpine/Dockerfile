FROM monogramm/docker-uxbox-builder:latest

ARG UXBOX_THEME=light

ENV UXBOX_VERSION=master \
    UXBOX_API_URL="/api" \
    UXBOX_VIEW_URL="/view/" \
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
        -e "s|'common/dependencies/uxbox-light'|'common/dependencies/uxbox-${UXBOX_THEME}'|g" \
        resources/styles/main.scss; \
    sed -i \
        -e "s|'common/dependencies/uxbox-light'|'common/dependencies/uxbox-${UXBOX_THEME}'|g" \
        resources/styles/view.scss; \
    [ ! -f ./scripts/build-release.sh ] || ./scripts/build-release.sh; \
    [ ! -f ./scripts/build-dist.sh ] || ./scripts/build-dist.sh



# Once application has been built, prepare production image
FROM nginx:alpine

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Copy built app to www root
COPY --from=0 /home/uxbox/frontend/dist /usr/share/nginx/html

# NGINX configurations
COPY ./nginx/conf.d /etc/nginx/conf.d
