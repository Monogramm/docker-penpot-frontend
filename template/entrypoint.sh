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
    log "Updating Public URI: $PENPOT_PUBLIC_URI"
    sed -i \
      -e "s|^(//)?var appPublicURI = \".*\";|var appPublicURI = \"$PENPOT_PUBLIC_URI\";|g" \
      "$1"
  else
    log "Disabling Public URI"
    sed -i \
      -e 's|^var appPublicURI = ".*";|//var appPublicURI = "";|g' \
      "$1"
  fi
}


update_demo_warning() {
  if [ -n "$PENPOT_DEMO_WARNING" ]; then
    log "Updating Demo Warning: $PENPOT_DEMO_WARNING"
    sed -i \
      -e "s|^var appDemoWarning = .*;|var appDemoWarning = true;|g" \
      "$1"
  else
    log "Disabling Demo Warning"
    sed -i \
      -e 's|^var appDemoWarning = .*;|//var appDemoWarning = false;|g' \
      "$1"
  fi
}


update_allow_demo_users() {
  if [ -n "$PENPOT_ALLOW_DEMO_USERS" ]; then
    log "Updating Allow Demo Users: $PENPOT_ALLOW_DEMO_USERS"
    sed -i \
      -e "s|^var appAllowDemoUsers = .*;|var appAllowDemoUsers = true;|g" \
      "$1"
  else
    log "Disabling Allow Demo Users"
    sed -i \
      -e 's|^var appAllowDemoUsers = .*;|//var appAllowDemoUsers = false;|g' \
      "$1"
  fi
}


update_google_client_id() {
  if [ -n "$PENPOT_GOOGLE_CLIENT_ID" ]; then
    log "Updating Google Client Id: $PENPOT_GOOGLE_CLIENT_ID"
    sed -i \
      -e "s|^(//)?var appGoogleClientID = \".*\";|var appGoogleClientID = \"$PENPOT_GOOGLE_CLIENT_ID\";|g" \
      "$1"
  else
    log "Disabling Google Client Id"
    sed -i \
      -e 's|^var appGoogleClientID = ".*";|//var appGoogleClientID = "";|g' \
      "$1"
  fi
}


update_gitlab_client_id() {
  if [ -n "$PENPOT_GITLAB_CLIENT_ID" ]; then
    log "Updating GitLab Client Id: $PENPOT_GITLAB_CLIENT_ID"
    sed -i \
      -e "s|^(//)?var appGitlabClientID = \".*\";|var appGitlabClientID = \"$PENPOT_GITLAB_CLIENT_ID\";|g" \
      "$1"
  else
    log "Disabling GitLab Client Id"
    sed -i \
      -e 's|^var appGitlabClientID = ".*";|//var appGitlabClientID = "";|g' \
      "$1"
  fi
}


update_github_client_id() {
  if [ -n "$PENPOT_GITHUB_CLIENT_ID" ]; then
    log "Updating GitHub Client Id: $PENPOT_GITHUB_CLIENT_ID"
    sed -i \
      -e "s|^(//)?var appGithubClientID = \".*\";|var appGithubClientID = \"$PENPOT_GITHUB_CLIENT_ID\";|g" \
      "$1"
  else
    log "Disabling GitHub Client Id"
    sed -i \
      -e 's|^var appGithubClientID = ".*";|//var appGithubClientID = "";|g' \
      "$1"
  fi
}


update_login_with_ldap() {
  if [ -n "$PENPOT_LOGIN_WITH_LDAP" ]; then
    log "Updating Login with LDAP: $PENPOT_LOGIN_WITH_LDAP"
    sed -i \
      -e "s|^var appLoginWithLDAP = .*;|var appLoginWithLDAP = true;|g" \
      "$1"
  else
    log "Disabling Login with LDAP"
    sed -i \
      -e 's|^var appLoginWithLDAP = .*;|//var appLoginWithLDAP = false;|g' \
      "$1"
  fi
}

update_public_uri /usr/share/nginx/html/js/config.js
update_demo_warning /usr/share/nginx/html/js/config.js
update_allow_demo_users /usr/share/nginx/html/js/config.js
update_google_client_id /usr/share/nginx/html/js/config.js
update_gitlab_client_id /usr/share/nginx/html/js/config.js
update_github_client_id /usr/share/nginx/html/js/config.js
update_login_with_ldap /usr/share/nginx/html/js/config.js


## Replacing existing archive with updated version
gzip -c /usr/share/nginx/html/js/config.js > /usr/share/nginx/html/js/config.js.gz


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
