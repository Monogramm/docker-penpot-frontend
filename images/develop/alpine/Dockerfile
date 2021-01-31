FROM monogramm/docker-penpot-builder:develop as builder

ARG VERSION=develop
ARG PENPOT_THEME=default

ENV PENPOT_PUBLIC_URI=http://localhost:3449/ \
    PENPOT_VIEW_URL="/view/" \
    PENPOT_DEBUG=false \
    PENPOT_GOOGLE_CLIENT_ID=true \
    PENPOT_DEMO_WARNING=true \
    PENPOT_DEPLOY_DATE="" \
    PENPOT_DEPLOY_COMMIT="" \
    PENPOT_LOGIN_WITH_LDAP=false \
    TAG=${VERSION}

# Download source from github
ADD https://github.com/penpot/penpot/archive/${VERSION}.tar.gz /tmp/penpot.tar.gz
# or copy frontend from source and build release
#COPY . /home/penpot/penpot-${VERSION}/frontend

RUN set -ex; \
    mkdir -p /home/penpot; \
    cd /home/penpot; \
    tar -xzf /tmp/penpot.tar.gz --strip=1; \
    rm -f /tmp/penpot.tar.gz;

WORKDIR /home/penpot/frontend

RUN set -ex; \
    ./scripts/build.sh


# Once application has been built, prepare production image
FROM nginx:alpine

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Copy built app to www root
COPY --from=builder /home/penpot/frontend/target/dist /usr/share/nginx/html

# Frontend configurations
COPY ./config.js /usr/share/nginx/html/js/config.js

# NGINX configurations
COPY ./nginx/conf.d /etc/nginx/conf.d

# Add entrypoint
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

ARG VERSION=develop
ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
    version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/Monogramm/docker-penpot-frontend" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="PENPOT (frontend) - The Open-Source prototyping tool" \
    org.label-schema.description="The open-source solution for design and prototyping" \
    org.label-schema.url="https://www.penpot.io/" \
    org.label-schema.vendor="PENPOT" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
