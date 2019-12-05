#!/bin/sh

set -e

find . -name '*~' -print | xargs rm -f
ninja -C release -k0 bin/clang-6.0
