#!/usr/bin/env node
var fs = require('fs');

// osx
process.platform = 'darwin';
delete require.cache[require.resolve('./')];
fs.statSync(require('./'));

// linux
process.platform = 'linux';
delete require.cache[require.resolve('./')];
fs.statSync(require('./'));

// windows
process.platform = 'win32';
delete require.cache[require.resolve('./')];
fs.statSync(require('./'));
