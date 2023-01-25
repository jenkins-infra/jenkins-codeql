# Jenkins CodeQL

This repository contains Jenkins-specific CodeQL queries.

## Usage

1. Install the [CodeQL CLI](https://github.com/github/codeql-cli-binaries/releases).
2. Run `codeql pack install test/` to install the dependencies.

### Run tests

    codeql pack test run test/

The file `run-tests.sh` in this repository is a self-contained script that installs CodeQL, pack dependencies, and then runs the tests.
Since it downloads and extracts CodeQL CLI binaries, its use is not recommended for local development.

### Run queries against database

First, [generate or download a CodeQL database](https://codeql.github.com/docs/codeql-cli/creating-codeql-databases/) for the code base you want to run the queries against.

Then, run:

    codeql database codeql database analyze --format=sarifv2.1.0 --output=result.sarif <path to database> src/

This will generate the `result.sarif` file containing the query results.

### Suppress warnings

It is possible to suppress false-positives programatically using inline comments or `java.lang.SuppressWarnings` annotation.

To suppress all kinds of warnings at once using:
```
// lgtm
```
To suppress a specific kind of warning put the warning `id` inside square brackets:
```
// lgtm[jenkins/callable-without-role-check]
```
or
```
@SuppressWarnings("lgtm[jenkins/callable-without-role-check]")
```
To suppress multiple kinds of warnings:
```
// lgtm[jenkins/no-permission-check], lgtm[jenkins/csrf]
```
or
```
@SuppressWarnings({"jenkins/no-permission-check", "jenkins/csrf"})
```
