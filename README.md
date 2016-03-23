# Panda Messages

Javascript-based message lookup with support for message templates.

## API Examples

#### JavaScript

```javascript
var messages = require("messages");

message("my-messages.yaml")
.then(function(Messages) {
  console.log(
    Messages.message("greeting", { name: "World" })
  );
});
```

#### CoffeeScript

```coffee
messages = require "messages"

message "my-messages.yaml"
.then ({message}) ->
  console.log message "greeting", name: "World"
```

## CLI Examples

```
$ message my-messages.yaml greeting --data 'name: World'
Hello World
```

The `--data` flag is optional.

```
$ message my-messages.yaml farewell
Goodbye!
```

## Installation

```
npm install panda-messages
```

Or, if you want to use the CLI, you may want to use the `-g` option.

```
npm install -g panda-messages
```

## API Reference

### messages _path_

The `message` module exports a single function that takes a path
and returns a promise. If the path is for a valid YAML file,
the promise resolves to an object whose properties are message helpers.

These helpers are: `lookup`, `message`, and `abort`.

### lookup _key_

Returns the message that corresponds to the `key`.

### message _key_, _data={}_

Returns the message that corresponds to the `key` and
processes it as a template, using `data`.
If you don't pass a `data` argument, it defaults to
the empty object.

### abort _key_, _data={}_

Works like `message` except that it
displays the message on standard error and then aborts
(calls `process.exit`) with a status code of 1.

## Templates

Message uses [Markup-JS](https://github.com/adammark/Markup.js/) to render template strings.
