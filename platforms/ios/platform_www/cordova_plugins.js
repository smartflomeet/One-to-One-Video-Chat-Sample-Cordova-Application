cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "sfm-cordova-plugin.enxcordovaplugin",
      "file": "plugins/sfm-cordova-plugin/www/enxcordovaplugin.js",
      "pluginId": "sfm-cordova-plugin",
      "clobbers": [
        "EnxRtc"
      ]
    }
  ];
  module.exports.metadata = {
    "sfm-cordova-plugin": "1.0.0"
  };
});