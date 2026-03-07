#!/bin/bash

set -euo pipefail

rm -rf ./overrides_modified
cp -r  ./overrides_upstream ./overrides_modified

find ./overrides_modified -type f -iname '*.y*ml' | xargs sed -i 's/%%%REPLACE_API_ADDR%%%/1.1.1.1/g'
find ./overrides_modified -type f -iname '*.y*ml' | xargs sed -i 's/%%%REPLACE_API_PORT%%%/1234/g'

for component in $(basename --multiple overrides_modified/*); do

    mkdir -p "./components/$component"

    # https://mikefarah.gitbook.io/yq/operators/reduce#merge-all-yaml-files-together
    yq eval-all '. as $item ireduce ({}; . * $item )' ./overrides_modified/"$component"/* ./overrides_global.yaml > ./components/"$component"/values_upstream.yaml
done
