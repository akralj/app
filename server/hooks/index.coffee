# Add any common hooks you want to share across services in here.
# see http://docs.feathersjs.com/hooks/readme.html for more details on hooks.
#

_ = require("lodash")


normalizeId = (obj) ->
  if obj._id
    obj.id = obj._id
    delete obj._id
  obj


module.exports =
  # change id to _id for noSql db
  changeId2_id: (hook) ->
    if hook?.data?.id
      hook.data._id = hook.data.id
      delete hook.data.id
    return hook

  # change _id -> id
  change_id2id: (hook) ->
    # 1. when pagination is enabled
    if _.isArray hook?.result?.data
      hook.result.data = hook.result.data.map (item) -> normalizeId(item)
    # 2. no pagination
    else if _.isArray hook?.result
      hook.result = hook.result.map (item) -> normalizeId(item)
    # 3. get request
    else if hook?.result?._id
      hook.result = normalizeId(hook.result)
    return hook


  normalizeParams: (hook) ->
    query = hook.params.query
    if hook.params.provider is "rest"
      numberFields = ["duration"]
      Object.keys(query).forEach (key) ->
        # parse booleans
        if query[key] is 'true'  then query[key] = true
        if query[key] is 'false' then query[key] = false
        # parse numbers
        if key in numberFields then query[key] = parseInt(query[key])

    return hook
