/*

  __file-name__.js

  (c) 2014 Michael Hoy <mjh@mjhoy.com>

  __file-name__ may be freely distributed under the MIT license.

*/

(function ($, root) {

  "use strict";

  var version = "0.0.1";

  var _initializing = false;

  var _hasProp = {}.hasOwnProperty;

  var _old___object__ = root.__object__;

  var __object__ = function(selector) {
    if(!_initializing) {
      this.selector = selector;
      this.init();
    }
  };

  __object__.prototype = {
    selector: undefined,

    init: function () {
      this.bar = "foo";
    }
  };

  __object__.extend = function(prop) {
    _initializing = true;
    var prototype = new __object__();
    _initializing = false;
    for (var key in prop)
      if (_hasProp.call(prop, key))
        prototype[key] = prop[key];
    function K() {
      __object__.apply(this, arguments);
    }
    K.prototype = prototype;
    K.prototype.constructor = K;

    return K;
  };

  __object__.create = function(proto) {
    return new (__object__.extend(proto))();
  };

  __object__.version = version;
  __object__.old___object__ = _old___object__;

  root.__object__ = __object__;

})(jQuery, this);
