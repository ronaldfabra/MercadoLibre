#!/bin/bash

DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'

xcodebuild test -scheme Meli -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES
