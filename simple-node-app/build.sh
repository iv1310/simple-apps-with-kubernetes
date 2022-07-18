#!/bin/bash

set -eux

# Build
npm install
# Testing
npm test
npm run lint
