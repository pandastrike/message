{join} = require "path"
YAML = require "js-yaml"
{async, read, abort, curry, binary, flip, property,
reduce, apply, pipe, map, identity} = require "fairmont"
t = (k,d) -> (require "markup-js").up k, d

# TODO: these belongs in Fairmont
split = curry (d, s) -> s.split(d)
splat = (f) -> (args...) -> f args

# reduce arguments by iterative application,
deref = curry binary flip splat reduce apply,
  (pipe (split "."),            # split the ref into an array
    (map property),             # turn that into a list property extractors
    reduce pipe, identity)      # which are then composed into a single fn

_abort = abort
module.exports = async (path) ->
  messages = YAML.safeLoad yield read path
  lookup = deref messages
  message = (key, data={}) -> t (lookup key), data
  abort = (key, data={}) -> _abort message key, data
  {lookup, message, abort}
