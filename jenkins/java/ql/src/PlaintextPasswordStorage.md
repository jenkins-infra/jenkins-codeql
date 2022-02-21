A Jenkins component class that may store a password, token, or similar credentials in plain text when serialized. See the [documentation on storing secrets in Jenkins](https://www.jenkins.io/doc/developer/security/secrets/) how to properly store credentials.

## False Positive Guidance

This check attempts to identify fields that would result in credentials being serialized to disk based on the _field name_.

* If the object is never serialized to disk (e.g., it is not directly or transitively stored as part of configuration or build data), this check can be ignored.
* Field names can easily mislead this check. For example, `key` is interpreted as storing sensitive information, even if it's just a key/value mapping.

If either is the case, simply mark this finding as a false positive.
