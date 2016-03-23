{resolve, join} = require "path"
{async} = require "fairmont"
YAML = require "js-yaml"
messages = require "./index"

args = process.argv[2..]

pargs = []
while args.length > 0
  arg = args.shift()
  switch arg
    when "--data" then yaml = args.shift()
    else pargs.push arg

[path, key] = pargs
data = {}

do async ->

  internal = yield messages join __dirname, "..", "messages.yaml"

  if !(path? && key?)
    internal.abort "help.usage"

  try
    {message} = yield messages resolve path
  catch error
    internal.abort "errors.bad-path", {path}

  if yaml?
    try
      data = YAML.safeLoad yaml
    catch
      internal.abort "errors.bad-yaml", {yaml}

  try
    console.log message key, data
  catch
    internal.abort "errors.bad-key"
