#!/bin/bash
#
# MIT License
# 
# Copyright (c) 2021 Mark Asselstine
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

if [ $# -eq 1 ] && [ $1 == "clean" ]; then
    docker image prune --force --filter label=stage=builder
    exit 0
fi

DOCKERFILE="${1:-Dockerfile}"
TAG="${2:-$(git ls-remote https://github.com/molior-dbs/aptly | grep HEAD | awk '{ print $1}' | cut -c -12)}"
DOCKERHUB_USER="${3:-markawr}"
DOCKERHUB_REPO="aptly"

docker build -t "${DOCKERHUB_USER=}/${DOCKERHUB_REPO=}:${TAG}" -f ${DOCKERFILE} .

# If the build was successful (0 exit code)...
if [ $? -eq 0 ]; then
    echo "Build successful!. Cleanup with 'build.sh clean'"
    echo
# The build exited with an error.
else
    echo "Build failed!"
    echo
    exit 1
fi
