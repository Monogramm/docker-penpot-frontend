FROM monogramm/docker-uxbox-builder:develop as builder

ARG VERSION=master
ARG UXBOX_THEME=default

ENV UXBOX_PUBLIC_URI=http://localhost:3449/ \
    UXBOX_DEBUG=false \
    UXBOX_GOOGLE_CLIENT_ID=true \
    UXBOX_DEMO_WARNING=true \
    UXBOX_DEPLOY_DATE="" \
    UXBOX_DEPLOY_COMMIT="" \
    UXBOX_LOGIN_WITH_LDAP=false \
    TAG=${VERSION}

# Download source from github
ADD https://github.com/uxbox/uxbox/archive/${VERSION}.tar.gz /tmp/uxbox.tar.gz
# or copy frontend from source and build release
#COPY . /home/uxbox/uxbox-${VERSION}/frontend

RUN set -ex; \
    mkdir -p /home/uxbox; \
    cd /home/uxbox; \
    tar -xzf /tmp/uxbox.tar.gz --strip=1; \
    rm -f /tmp/uxbox.tar.gz;

WORKDIR /home/uxbox/frontend

RUN ./scripts/build-app.sh


# Once application has been built, prepare production image
FROM nginx:mainline

ENV LANG=en_US.UTF-8 \
    LC_ALL=C.UTF-8

# Copy built app to www root
COPY --from=builder /home/uxbox/frontend/target/dist /usr/share/nginx/html

# NGINX configurations
COPY ./nginx/conf.d /etc/nginx/conf.d

# Add entrypoint
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
    version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/Monogramm/docker-uxbox-frontend" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="UXBOX (frontend) - The Open-Source prototyping tool" \
    org.label-schema.description="The open-source solution for design and prototyping" \
    org.label-schema.url="https://www.uxbox.io/" \
    org.label-schema.vendor="UXBOX" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"


ENTRYPOINT ["sh", "/entrypoint.sh"]
