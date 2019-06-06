
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

* `alpine` `latest`
* `mainline`

## How to run this image ?

### Auto configuration via environment variables

The following environment variables are also honored for configuring your UXBOX instance:

**Only available at build time!**
-	`-e UXBOX_CONFIG_URL=...` (defaults to http://127.0.0.1:6060/api)
-	`-e UXBOX_DEMO=...` (defaults to false)
-	`-e UXBOX_DEBUG=...` (defaults to false)

Available at runtime:
-	`-e LANG=...` (defaults to en_US.UTF-8)
-	`-e LC_ALL=...` (defaults to C.UTF-8)

# Questions / Issues
If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-uxbox-frontend) and write an issue.
