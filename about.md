---
layout: body
---


```coffeescript
symfio = require "symfio"


container = symfio "fruits-example", __dirname
loader = container.get "loader"

loader.use symfio.plugins.express
loader.use symfio.plugins.mongoose

loader.use (container, callback) ->
    connection = container.get "connection"
    mongoose = container.get "mongoose"

    FruitSchema = new mongoose.Schema
        name: String

    connection.model "fruits", FruitSchema

    callback()

loader.use symfio.plugins.fixtures
loader.use symfio.plugins.crud

loader.use (container, callback) ->
    connection = container.get "connection"
    unloader = container.get "unloader"
    crud = container.get "crud"
    app = container.get "app"

    Fruit = connection.model "fruits"

    app.get "/fruits", crud.list(Fruit).sort(name: -1).make()

    unloader.register (callback) ->
        connection.db.dropDatabase ->
            callback()

    callback()

loader.load()
```

## Quick Start

Start new project:

```sh
$ mkdir my_project
$ cd my_project
$ git init
$ cat << END > .gitignore
node_modules
END
$ cat << END > package.json
{
    "name": "my_project",
    "version": "0.0.0",
    "public": false
}
END
```

Install Symfio:

```sh
$ npm install symfio --save
```

Create sample application:

```sh
$ cat << END > my_project.coffee
symfio = require "symfio"

container = symfio "my_project", __dirname
loader = container.get "loader"
loader.use symfio.plugins.assets
loader.use symfio.plugins.express
loader.load()
END
$ mkdir public
$ cat << END > public/index.jade
doctype 5
html
    head
        title Hello World!
    body
        h1 Hello World!
END
```

Start server:

```sh
$ coffee my_project
```

## Viewing Examples

Clone Symfio repo, then run example:

```sh
$ git clone git://github.com/symfio/symfio.git
$ cd symfio
$ npm install
$ ./node_modules/.bin/coffee examples/fruits
```

## Project Status

[![Build Status](http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt4,branch:master/statusIcon?guest=1)](http://teamcity.rithis.com/viewType.html?buildTypeId=bt4&guest=1) [![Dependency Status](https://gemnasium.com/symfio/symfio.png)](https://gemnasium.com/symfio/symfio)

[Code Coverage Report](http://rithis.github.com/symfio/coverage.html)

[Latest Documentation](http://rithis.github.com/symfio/docs/symfio.html)

## Running Tests

Clone Symfio repo, then run tests:

```sh
$ git clone git://github.com/symfio/symfio.git
$ cd symfio
$ npm install
$ ./node_modules/.bin/grunt test
```


Checkout to `master` branch:

```sh
$ git checkout master
```

Increment version in `package.json` and commit:

```sh
$ git add package.json
$ git commit -m "Bumped 0.0.0"
```

Add version tag to commit in which `package.json` is changed:

```sh
$ git tag 0.0.0 HEAD
```

Push commit and tag to GitHub and wait until CI build is succeed:

```sh
$ git push origin master
$ git push origin 0.0.0
```

Upload package to NPM repository:

```sh
$ npm publish
```

Checkout to gh-pages branch:

```sh
$ git checkout gh-pages
```

Increment version in `_includes/footer.html` and update website:

```sh
$ ./_update.sh
$ git add .
$ git commit -m "Updated"
$ git push
```

Return to master branch:

```sh
$ git checkout master
```
