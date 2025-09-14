#!/bin/bash

cp en_FI /usr/share/i18n/locales
localedef -i en_FI -c -f UTF-8 en_FI --replace -v

