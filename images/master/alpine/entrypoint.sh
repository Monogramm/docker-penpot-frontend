#!/bin/sh
set -e

log() {
  echo "[$(date +%Y-%m-%dT%H:%M:%S%:z)] $@"
}


#########################################
## PENPOT Front config
#########################################


update_public_uri() {
  if [ -n "$PENPOT_PUBLIC_URI" ]; then
    log "Updating penpot public uri: $PENPOT_PUBLIC_URI"
    sed -i \
      -e 's|\\"publicURI\\":\\".*\\"|\\"publicURI\\":\\"$PENPOT_PUBLIC_URI\\"|g' \
      $1
  fi
}


update_google_client_id() {
  if [ -n "$PENPOT_GOOGLE_CLIENT_ID" ]; then
    log "Updating Google Client Id: $PENPOT_GOOGLE_CLIENT_ID"
    sed -i \
      -e 's|\\"googleClientID\\":\\".*\\"|\\"googleClientID\\":\\"$PENPOT_GOOGLE_CLIENT_ID\\"|g' \
      $1
  fi
}


update_login_with_ldap() {
  if [ -n "$PENPOT_LOGIN_WITH_LDAP" ]; then
    log "Updating Login with LDAP: $PENPOT_LOGIN_WITH_LDAP"
    sed -i \
      -e 's|\\"loginWithLDAP\\":[^,} ]*|\\"loginWithLDAP\\":$PENPOT_LOGIN_WITH_LDAP|g' \
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