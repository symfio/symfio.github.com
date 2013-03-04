#!/bin/sh

# LINKS
README="https://raw.github.com/symfio/symfio/master/README.md"
COVERAGE="http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt4,branch:master,status:SUCCESS/artifacts/files/coverage.html?guest=1"
DOCS="http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt4,branch:master,status:SUCCESS/artifacts/files/docs.tar.gz?guest=1"

# README
cat << END > about.md
---
layout: body
---
END

curl "$README" \
    | grep -v "^# " \
    | grep -v "Glue for Node.js modules" >> about.md

# COVERAGE
curl "$COVERAGE" > coverage.html

# DOCS
rm -rf docs
curl "$DOCS" | tar -x
