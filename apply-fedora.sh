#!/bin/bash

# prerequisite: sudo dnf install glibc-locale-source

localedef --no-archive --inputfile en_FI --charmap=UTF-8 en_FI.UTF-8