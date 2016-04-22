#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker stop vp0
docker stop vp1
docker rm vp0
docker rm vp1
