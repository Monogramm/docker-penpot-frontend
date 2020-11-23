[![License: GPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-penpot-frontend.svg)](https://travis-ci.org/Monogramm/docker-penpot-frontend)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-penpot-frontend.svg)](https://hub.docker.com/r/monogramm/docker-penpot-frontend/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-penpot-frontend.svg)](https://hub.docker.com/r/monogramm/docker-penpot-frontend/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-penpot-frontend.svg)](https://microbadger.com/images/monogramm/docker-penpot-frontend)
[![](https://images.microbadger.com/badges/image/monogramm/docker-penpot-frontend.svg)](https://microbadger.com/images/monogramm/docker-penpot-frontend)

# PenPot Frontend Docker image

Docker image for PenPot Frontend.

🚧 **This image is still in development!**

## What is PENPOT ?

PenPot is The Open-Source prototyping tool.

> <https://www.penpot.app/>

> <https://github.com/penpot/penpot>

## Supported tags

<https://hub.docker.com/r/monogramm/docker-penpot-frontend/>

-   Branch `master`
    -   `alpine` `latest`
    -   `mainline`
-   Branch `develop`
    -   `develop-alpine` `develop`

## How to run this image ?

### Auto configuration via environment variables

The following environment variables are also honored for configuring your PENPOT instance:

**Only available at build time!**

-   `-e PENPOT_API_URL=...` (defaults to `/api`)
-   `-e PENPOT_VIEW_URL=...` (defaults to `/view/`)
-   `-e PENPOT_DEMO=...` (not defined, setting any value will activate demo mode)
-   `-e PENPOT_DEBUG=...` (not defined, setting any value will activate debug mode)
-   `-e PENPOT_THEME=...` (defaults to `light`)

Available at runtime:

-   `-e LANG=...` (defaults to `en_US.UTF-8`)
-   `-e LC_ALL=...` (defaults to `C.UTF-8`)

## Questions / Issues

If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-penpot-frontend) and write an issue.

[uri_license]: http://www.gnu.org/licenses/gpl.html

[uri_license_image]: https://img.shields.io/badge/License-GPL%20v3-blue.svg
