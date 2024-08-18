'use strict';
var VERSION = require('./package.json').neonVersion;

var path = require('path');

module.exports =
  process.platform === 'darwin'
    ? path.join(__dirname, 'neo-one-csharp-osx-v' + VERSION, 'neo-one-csharp') :
  process.platform === 'linux'
    ? path.join(__dirname, 'neo-one-csharp-linux-v' + VERSION, 'neo-one-csharp') :
  process.platform === 'win32'
    ? path.join(__dirname, 'neo-one-csharp-win-v' + VERSION, 'neo-one-csharp.exe') :
  null;
