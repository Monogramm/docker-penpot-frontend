#!/bin/sh
set -e

log() {
  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $@"
}


#########################################
## UXBOX Front config
#########################################


update_public_uri() {
  if [ -n "$UXBOX_PUBLIC_URI" ]; then
    log "Updating uxbox public uri: $UXBOX_PUBLIC_URI"
    sed -i \
      -e 's|\\"publicURI\\":\\".*\\"|\\"publicURI\\":\\"$UXBOX_PUBLIC_URI\\"|g' \
      $1
  fi
}


update_google_client_id() {
  if [ -n "$UXBOX_GOOGLE_CLIENT_ID" ]; then
    log "Updating Google Client Id: $UXBOX_GOOGLE_CLIENT_ID"
    sed -i \
      -e 's|\\"googleClientID\\":\\".*\\"|\\"googleClientID\\":\\"$UXBOX_GOOGLE_CLIENT_ID\\"|g' \
      $1
  fi
}


update_login_with_ldap() {
  if [ -n "$UXBOX_LOGIN_WITH_LDAP" ]; then
    log "Updating Login with LDAP: $UXBOX_LOGIN_WITH_LDAP"
    sed -i \
      -e 's|\\"loginWithLDAP\\":[^,} ]*|\\"loginWithLDAP\\":$UXBOX_LOGIN_WITH_LDAP|g' \
      $1
  fi
}


update_public_uri /usr/share/nginx/html/index.html
update_google_client_id /usr/share/nginx/html/index.html
update_login_with_ldap /usr/share/nginx/html/index.html


## Replacing existing archive with updated version
gzip -c /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.html.gz


#########################################
## NGinx config
#########################################

# Reinitialize nginx links
if [ -d /etc/nginx/conf.d/ ]; then
  rm -f /etc/nginx/conf.d/*.conf
fi

log "Checking nginx configuration..."
nginx -t

log "Start nginx server..."
nginx -g "daemon off;"