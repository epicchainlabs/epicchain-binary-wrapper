# C# Compiler for the EpicChain Virtual Machine

> **EpicChain** offers a powerful binary wrapper for [epicchain-binary-wrapper](https://github.com/epicchainlabs/epicchain-binary-wrapperr/tree/master/), the C# compiler specifically designed for the EpicChain Virtual Machine. With EpicChain, you can leverage advanced C# programming capabilities within the EpicChain ecosystem. Our package ensures that binaries are accessible across various operating systems, including OS X, Linux, and Windows, making it versatile for developers working on different platforms.

## Installation

To begin using EpicChain, you need to install the CLI tool globally using npm. This allows you to compile C# code for the EpicChain Virtual Machine directly from your command line interface:

```sh
$ npm install --global epicchain
```

Once installed, you can invoke the compiler with the following command:

```sh
$ epicchain sc.dll
```

This command will compile the specified `sc.dll` file using the EpicChain compiler, processing it for compatibility with the EpicChain Virtual Machine.

## API Usage

For those who prefer to integrate EpicChain into their applications programmatically, you can install the package as a dependency in your project. This allows you to leverage EpicChain within your own codebase, facilitating automation and custom workflows.

To install the EpicChain package locally, use the following command:

```sh
$ npm install --save epicchain
```

After installation, you can use the API to invoke the EpicChain compiler through Node.js. Here's a basic example demonstrating how to execute the compiler from a Node.js script:

```js
const { execFile } = require('child_process');
const epicchain = require('epicchain');

// Replace 'sc.dll' with the path to your C# assembly file
execFile(epicchain, ['sc.dll'], (err, stdout) => {
  if (err) {
    console.error(`Error executing EpicChain compiler: ${err}`);
    return;
  }
  console.log(`Compiler Output:\n${stdout}`);
});
```

In this example, `execFile` is used to run the EpicChain compiler with the specified DLL file. The `stdout` output from the compiler is then logged to the console, allowing you to see the results of the compilation process.

## License

EpicChain is licensed under the [MIT License](https://opensource.org/licenses/MIT), which permits extensive usage and modification while ensuring that the software remains open and accessible to the community.
