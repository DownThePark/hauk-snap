#!/bin/bash

export LISTEN_ADDRESS="$(snapctl get listen.address)"
export LISTEN_HTTP="$(snapctl get listen.http)"
export LISTEN_HTTPS="$(snapctl get listen.https)"
export SSL_ENABLED="$(snapctl get ssl.enabled)"
export SSL_CERT="$(snapctl get ssl.cert)"
export SSL_KEY="$(snapctl get ssl.key)"
