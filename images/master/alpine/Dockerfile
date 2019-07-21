FROM monogramm/docker-uxbox-builder:latest

ARG VERSION=master

ENV UXBOX_API_URL="/api" \
    UXBOX_VIEW_URL="/view/"

# Download source from github
ADD https://github.com/uxbox/uxbox/archive/${VERSION}.tar.gz /tmp/uxbox.tar.gz
# or copy frontend from source and build release
#COPY . /home/uxbox/uxbox-${VERSION}/frontend

RUN set -ex; \
    mkdir -p /home/uxbox; \
    cd /home/uxbox; \
    tar -xzf /tmp/uxbox.tar.gz; \
    rm -f /tmp/uxbox.tar.gz; \
    mv /home/uxbox/uxbox-${VERSION}/frontend /home/uxbox/; \
    rm -rf /home/uxbox/uxbox-${VERSION}; \
    cd /home/uxbox/frontend; \
    rm -f Dockerfile; \
    rm -rf ./dist ./node_modules; \
    ./scripts/build-production.sh



# Once application has been built, prepare production image
FROM nginx:alpine

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
    version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/Monogramm/docker-uxbox-backend" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="UXBOX (frontend) - The Open-Source prototyping tool" \
    org.label-schema.description="The open-source solution for design and prototyping" \
    org.label-schema.url="https://www.uxbox.io/" \
    org.label-schema.vendor="UXBOX" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Copy built app to www root
COPY --from=0 /home/uxbox/frontend/dist /usr/share/nginx/html

# NGINX configurations
COPY ./nginx/conf.d /etc/nginx/conf.d
