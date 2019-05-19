#!/bin/bash
#
# Copyright 2018 Istio Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

set -o errexit

if [ -z "$1" ]; then
    echo Missing version parameter
    echo Usage: build_push_update_images.sh \<version\> \<opt. repository\>
    exit 1
fi
VERSION=$1

REPO=istio
if [ -n "$2" ]; then
	REPO=$2
fi

#Build docker images
src/build-services.sh "${VERSION}" "${REPO}"

#get all the new image names and tags
for v in ${VERSION} "latest"
do
  IMAGES+=$(docker images -f reference=$REPO/examples-bookinfo*:"$v" --format "{{.Repository}}:$v")
  IMAGES+=" "
done

#push images
for IMAGE in ${IMAGES}; 
do 
  echo "Pushing: ${IMAGE}" 
  docker push "${IMAGE}"; 
done

#Update image references in the yaml files
find . -name "*bookinfo*.yaml" -exec sed -E -i.bak "s/($REPO|istio)(\/examples-bookinfo-.*):[[:digit:]]*(\.[[:digit:]]*(\.[[:digit:]]*)?)?/$REPO\\2:$VERSION/g" {} +
