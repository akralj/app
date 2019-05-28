#
#
#

_ = require("lodash")
tap = require('tap')

f = (val) -> await val

tap.test "some async tests", (t) ->
  t.plan 2

  res = await f(13)
  if res is 13 then t.pass("await 13") else t.fail("not 13 working")
  res2 = await f(17)
  if res2 is 17 then t.pass("await 17") else t.fail("not 17 working")
