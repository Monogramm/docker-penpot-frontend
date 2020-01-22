
[uri_license]: http://www.gnu.org/licenses/gpl.html
[uri_license_image]: https://img.shields.io/badge/License-GPL%20v3-blue.svg

[![License: GPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-uxbox-frontend.svg)](https://travis-ci.org/Monogramm/docker-uxbox-frontend)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-uxbox-frontend.svg)](https://hub.docker.com/r/monogramm/docker-uxbox-frontend/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-uxbox-frontend.svg)](https://hub.docker.com/r/monogramm/docker-uxbox-frontend/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-uxbox-frontend.svg)](https://microbadger.com/images/monogramm/docker-uxbox-frontend)
[![](https://images.microbadger.com/badges/image/monogramm/docker-uxbox-frontend.svg)](https://microbadger.com/images/monogramm/docker-uxbox-frontend)

# UXBOX Frontend Docker image

Docker image for UXBOX Frontend.

:construction: **This image is still in development!**

## What is UXBOX ?

UXBOX is The Open-Source prototyping tool.

> https://www.uxbox.io/

> https://github.com/uxbox/uxbox

## Supported tags

https://hub.docker.com/r/monogramm/docker-uxbox-frontend/

* Branch `master`
    * `alpine` `latest`
    * `mainline`
* Branch `develop`
    * `develop-alpine` `develop`

## How to run this image ?

### Auto configuration via environment variables

The following environment variables are also honored for configuring your UXBOX instance:

**Only available at build time!**
-	`-e UXBOX_API_URL=...` (defaults to `/api`)
-	`-e UXBOX_VIEW_URL=...` (defaults to `/view/`)
-	`-e UXBOX_DEMO=...` (not defined, setting any value will activate demo mode)
-	`-e UXBOX_DEBUG=...` (not defined, setting any value will activate debug mode)
-	`-e UXBOX_THEME=...` (defaults to `light`)

Available at runtime:
-	`-e LANG=...` (defaults to `en_US.UTF-8`)
-	`-e LC_ALL=...` (defaults to `C.UTF-8`)

# Questions / Issues
If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-uxbox-frontend) and write an issue.
