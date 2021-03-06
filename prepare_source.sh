#! /bin/sh
set -e
cd `dirname "$0"`

rm -rf Sources/jq
rm -rf Sources/Cjq

mkdir -p Sources/jq
pushd Sources/jq > /dev/null

ln -s ../../jq/src/main.c .
find ../../jq/src -name '*.h' -not -name 'jq.h' -not -name 'jv.h' -exec ln -s {} . \;

mkdir -p src
pushd src > /dev/null

VERSION=$(../../../jq/scripts/version)
cat <<EOF > version.h
// This file is generated by prepare_source.sh
// DO NOT MANUALLY EDIT

#define JQ_VERSION "${VERSION}"
EOF

popd > /dev/null
popd > /dev/null

mkdir -p Sources/Cjq
pushd Sources/Cjq > /dev/null

find ../../jq/src -name '*.c' -not -name 'main.c' -exec ln -s {} . \;
find ../../jq/src -name '*.h' -not -name 'jq.h' -not -name 'jv.h' -exec ln -s {} . \;

mkdir -p include
pushd include > /dev/null

ln -s ../../../jq/src/jq.h .
ln -s ../../../jq/src/jv.h .

popd > /dev/null

mkdir -p src
pushd src > /dev/null

cat ../../../jq/src/builtin.jq \
  | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/^/"/' -e 's/$/\\n"/' \
  > builtin.inc
