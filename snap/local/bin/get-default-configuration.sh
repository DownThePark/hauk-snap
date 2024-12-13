#!/bin/bash

export DEFAULT_LISTEN_ADDRESS="0.0.0.0"
export DEFAULT_LISTEN_HTTP="80"
export DEFAULT_LISTEN_HTTPS="443"
export DEFAULT_SSL_ENABLED="false"
export DEFAULT_SSL_CERT="$(dirname $SNAP_DATA)/current/ssl/cert.pem"
export DEFAULT_SSL_KEY="$(dirname $SNAP_DATA)/current/ssl/key.pem"
