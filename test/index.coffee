{join} = require "path"
assert = require "assert"
Amen = require "amen"
messages = require "../src/index"
{shell, async} = require "fairmont"

path = join __dirname, "messages.yaml"

Amen.describe "message", (context) ->

  context.test "read", (context) ->

    {message} = yield messages path

    context.test "read a message", ->
      assert.equal (message "test-message"), "this is a test"

    context.test "read a nested key", ->
      assert.equal (message "test.message"), "this is also a test"

    context.test "read a templated message", ->
      assert.equal (message "template", what: "a templated test"),
        "this is a templated test"

  context.test "CLI", (context) ->

    # convenience functions to make it easier to call the CLI
    sh = async (command) ->
      {stdout} = yield shell command
      stdout.trim()

    context.test "read a message", ->
      assert.equal "this is a test",
        yield sh "message #{path} test-message"

    context.test "read a nested key", ->
      assert.equal "this is also a test",
        yield sh "message #{path} test.message"

    context.test "read a templated message", ->
      assert.equal "this is booyah",
        yield sh "message #{path} template --data 'what: booyah'"
