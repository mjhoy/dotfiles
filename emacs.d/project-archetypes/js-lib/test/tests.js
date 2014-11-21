// noop
function xtest() {}

module("sanity");

test("woiks", function () {
  var o = __object__.create({});
  equal("foo", o.bar);
});
