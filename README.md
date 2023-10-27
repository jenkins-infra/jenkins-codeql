# Jenkins CodeQL

This repository contains Jenkins-specific CodeQL queries.

## Usage

These CodeQL queries can be used in different ways.

### Use in a regular CodeQL workflow

Use the Jenkins CodeQL queries as part of the regular CodeQL code scanning workflow.
This is the more flexible approach in terms of your ability to configure the build, and additionally only requires one workflow to be set up to use the generic code scanning rules provided by GitHub in addition to the Jenkins-specific rules.

Please note the following limitations of this approach:

- The findings will be part of the "CodeQL" tool.
- Suppressing findings through annotations in source code is unsupported.

#### Setting up

These instructions assume use of the [standard CodeQL workflow template](https://github.com/actions/starter-workflows/blob/main/code-scanning/codeql.yml) as of [`b1df8a5`](https://github.com/actions/starter-workflows/blob/b1df8a546ed4d0f27d46aaf2f8ac1118bc522638/code-scanning/codeql.yml)

Update your use of `github/codeql-action/init@v2` to specify a `with.config` ([related GitHub documentation](https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/customizing-your-advanced-setup-for-code-scanning#specifying-codeql-query-packs)).

##### Add Jenkins-specific queries in addition to CodeQL

```yaml
with:
  config: |
    packs:
    - jenkins-infra/jenkins-codeql
```

##### Only run Jenkins-specific queries (like Jenkins Security Scan)

```yaml
with:
  config: |
    disable-default-queries: true
    packs:
    - jenkins-infra/jenkins-codeql
```

### Jenkins Security Scan GitHub Workflow

See the [Jenkins Security Scan documentation on jenkins.io](https://www.jenkins.io/redirect/jenkins-security-scan/).

### Basic use

1. Install the [CodeQL CLI](https://github.com/github/codeql-cli-binaries/releases).
2. Run `codeql pack install test/` to install the dependencies.

### Run tests

    codeql pack install test/
    codeql test run test/

The file `run-tests.sh` in this repository is a self-contained script that installs CodeQL, pack dependencies, and then runs the tests.
Since it downloads and extracts CodeQL CLI binaries, its use is not recommended for local development.

### Run queries against database

First, [generate or download a CodeQL database](https://codeql.github.com/docs/codeql-cli/creating-codeql-databases/) for the code base you want to run the queries against.

Then, run:

    codeql database codeql database analyze --format=sarifv2.1.0 --output=result.sarif <path to database> src/

This will generate the `result.sarif` file containing the query results.

## Development

### Update CodeQL

To update to a newer CodeQL release:

1. Determine which release to update to. See [the list of CodeQL releases](https://github.com/github/codeql-cli-binaries/releases) and [the corresponding releases of `java-all`](https://github.com/github/codeql/blob/main/java/ql/src/CHANGELOG.md).
2. Edit all `qlpack.yml` files and increase the version of `codeql/java-all` to the corresponding version in .
3. Run `codeql pack upgrade <dir>` on each of the directories containing a `qlpack.yml` file.
4. Edit `run-tests.sh` to download the correct CodeQL release and run it to confirm everything works as expected.

NOTE: https://github.com/jenkins-infra/jenkins-security-scan needs a corresponding change.
