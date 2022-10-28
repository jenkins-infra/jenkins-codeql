# Jenkins CodeQL

This repository contains Jenkins-specific CodeQL queries.

## Usage

1. Install the [CodeQL CLI](https://github.com/github/codeql-cli-binaries/releases).
2. Run `codeql pack install test/` to install the dependencies.

### Run tests

    codeql pack test run test/

### Run queries against database

First, [generate or download a CodeQL database](https://codeql.github.com/docs/codeql-cli/creating-codeql-databases/) for the code base you want to run the queries against.

Then, run:

    codeql database codeql database analyze --format=sarifv2.1.0 --output=result.sarif <path to database> src/

This will generate the `result.sarif` file containing the query results.
