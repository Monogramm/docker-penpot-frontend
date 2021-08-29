[![License: GPL v3][uri_license_image]][uri_license]
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Monogramm/docker-penpot-frontend/Docker%20Image%20CI)](https://github.com/Monogramm/docker-penpot-frontend/actions)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-penpot-frontend.svg)](https://hub.docker.com/r/monogramm/docker-penpot-frontend/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-penpot-frontend.svg)](https://hub.docker.com/r/monogramm/docker-penpot-frontend/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-penpot-frontend.svg)](https://microbadger.com/images/monogramm/docker-penpot-frontend)
[![](https://images.microbadger.com/badges/image/monogramm/docker-penpot-frontend.svg)](https://microbadger.com/images/monogramm/docker-penpot-frontend)

# Penpot Frontend Docker image

Docker image for Penpot Frontend.

🚧 **This image is still in beta!**

## What is Penpot

Penpot is The Open-Source prototyping tool.

> <https://www.penpot.app/>

> <https://github.com/penpot/penpot>

## Supported tags

<https://hub.docker.com/r/monogramm/docker-penpot-frontend/>

<!-- >Docker Tags -->

-   main-debian  (`images/main/mainline/Dockerfile`)
-   main-alpine main  (`images/main/alpine/Dockerfile`)
-   develop-debian  (`images/develop/mainline/Dockerfile`)
-   develop-alpine develop  (`images/develop/alpine/Dockerfile`)
-   1.7.4-alpha-debian 1.7-debian debian  (`images/1.7/mainline/Dockerfile`)
-   1.7.4-alpha-alpine 1.7-alpine alpine 1.7.4-alpha 1.7 latest  (`images/1.7/alpine/Dockerfile`)
-   1.6.5-alpha-debian 1.6-debian  (`images/1.6/mainline/Dockerfile`)
-   1.6.5-alpha-alpine 1.6-alpine 1.6.5-alpha 1.6  (`images/1.6/alpine/Dockerfile`)

<!-- <Docker Tags -->

## How to run this image

You can use the example `docker-compose.yml` at the root of the project to start a local Penpot instance.
Feel free to update the content of `.env` to your needs.

### Auto configuration via environment variables

The following environment variables are also honored for configuring your PENPOT instance:

**Only available at build time!**

-   `-e PENPOT_THEME=...` (defaults to `default`)

Available at runtime:

```yml
      # Frontend config
      - PENPOT_PUBLIC_URI=https://penpot.example.com:8080/
      - PENPOT_DEMO_WARNING=false
      - PENPOT_ALLOW_DEMO_USERS=false
      - PENPOT_GOOGLE_CLIENT_ID=
      - PENPOT_GITLAB_CLIENT_ID=
      - PENPOT_GITHUB_CLIENT_ID=
      - PENPOT_LOGIN_WITH_LDAP=true
      # Nginx config
      - PENPOT_PUBLIC_DOMAIN=penpot.example.com
      - PENPOT_BACKEND_URI=http://penpot-backend:6060
      - PENPOT_EXPORTER_URI=http://penpot-exporter:6061
```

## Questions / Issues

If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-penpot-frontend) and write an issue.

[uri_license]: http://www.gnu.org/licenses/gpl.html

[uri_license_image]: https://img.shields.io/badge/License-GPL%20v3-blue.svg
