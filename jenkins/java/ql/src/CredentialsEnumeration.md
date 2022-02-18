This is a Stapler web method whose name indicates it provides options for a dropdown list UI element. It does not implement a permission check, but ends up calling `CredentialsProvider#lookupCredentials`.

This is likely a security vulnerability, enumerating credentials IDs to users with only Overall/Read permission.
A permission check should be added.

See the [documentation on form validation](https://www.jenkins.io/doc/developer/security/form-validation/) as well as [the specific advice in the Credentials plugin consumer guide](https://github.com/jenkinsci/credentials-plugin/blob/master/docs/consumer.adoc#providing-a-ui-form-element-to-let-a-user-select-credentials).
