#!/bin/bash

export HTTP_PORT="$(snapctl get ports.http)"
export HTTPS_PORT="$(snapctl get ports.https)"
export SSL_ENABLED="$(snapctl get ssl.enabled)"
export SSL_CERT="$(snapctl get ssl.cert)"
export SSL_KEY="$(snapctl get ssl.key)"
