# Jenkins CodeQL

This repository contains Jenkins-specific CodeQL queries.

## Usage

### Use in a regular CodeQL workflow

You can use the Jenkins CodeQL queries as part of the regular CodeQL code scanning workflow.
This is the more flexible approach in terms of your ability to configure the build, and additionally only requires one workflow to be set up to use the generic code scanning rules provided by GitHub in addition to the Jenkins-specific rules.
Please note the findings will be reported part of the "CodeQL" code scanning tool on the GitHub UI.

Additionally, code-level suppressions documented as part of finding descriptions do not work by default.
See [`advanced-security/dismiss-alerts`](https://github.com/advanced-security/dismiss-alerts/) for a GitHub-provided way to support code-level suppression.
The instructions below do not add suppression support, see `advanced-security/dismiss-alerts` for the necessary configuration changes.

#### Setting up

These instructions assume use of the [standard CodeQL workflow template](https://github.com/actions/starter-workflows/blob/main/code-scanning/codeql.yml) as of [`42326d0`](https://github.com/actions/starter-workflows/blob/42326d080464485184a7a63431593b327a1c2e3b/code-scanning/codeql.yml)

Update your use of `github/codeql-action/init@v3` to specify a `with.config` ([related GitHub documentation](https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/customizing-your-advanced-setup-for-code-scanning#specifying-codeql-query-packs)).

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

### Basic local/standalone use

1. Install the [CodeQL CLI](https://github.com/github/codeql-cli-binaries/releases).
2. Run `codeql pack install test/` to install the dependencies.

#### Run Jenkins queries against a CodeQL database

[Generate or download a CodeQL database](https://codeql.github.com/docs/codeql-cli/creating-codeql-databases/) for the code base you want to run the queries against.

Then, run:

    codeql database codeql database analyze --format=sarifv2.1.0 --output=result.sarif <path to database> src/

This will generate the `result.sarif` file containing the query results.

## Development

### Run tests

    codeql pack install test/
    codeql test run test/

The file `run-tests.sh` in this repository is a self-contained script that installs CodeQL, pack dependencies, and then runs the tests.
Since it downloads and extracts CodeQL CLI binaries, its use is not recommended for local development.

### Update CodeQL

To update to a newer CodeQL release:

1. Determine which release to update to. See [the list of CodeQL releases](https://github.com/github/codeql-cli-binaries/releases) and [the corresponding releases of `java-all`](https://github.com/github/codeql/blob/main/java/ql/src/CHANGELOG.md).
2. Edit all `qlpack.yml` files in this repository and increase the version of `codeql/java-all` to the corresponding version in `github/codeql` (`java/ql/src/qlpack.yml` at the tagged top-level version in [tags](https://github.com/github/codeql/tags).
3. Run `codeql pack upgrade <dir>` on each of the directories containing a `qlpack.yml` file.
4. Edit `run-tests.sh` to download the correct CodeQL release and run it to confirm everything works as expected.

NOTE: https://github.com/jenkins-infra/jenkins-security-scan needs a corresponding change.

### Release as CodeQL Pack

To release this as QL packs [here](https://github.com/orgs/jenkins-infra/packages):

1. Update the versions from `x.y.z-dev` to `x.y.z` in `qlpack.yml` files and `git commit` this ([example](https://github.com/jenkins-infra/jenkins-codeql/commit/1948ae5d3f4e8fdd6c3744d543ba2575a738a8a1)).
2. Define the environment variable `GITHUB_TOKEN` or prepare to pass the argument `--github-auth-stdin` to the next command.
   Either way, you need a token with `write:packages` permission.
3. Run `codeql pack publish --groups=-test` to upload everything but the tests as packs.
4. Update the versions from `x.y.z` to `x.y.(z+1)-dev` in `qlpack.yml` files and `git commit` this ([example](https://github.com/jenkins-infra/jenkins-codeql/commit/d96d4f54cf0a7be75e89144aca88cde76ac61d50)).
