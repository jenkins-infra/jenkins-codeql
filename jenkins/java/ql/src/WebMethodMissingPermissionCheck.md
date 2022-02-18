A Stapler web method does not perform a permission check. This can be problem if the method returns private information, or has side effects. See [the documentation](https://www.jenkins.io/doc/developer/security/form-validation/).

## False Positive Guidance

This check can easily identify _false positives_, i.e. safe code is marked as being unsafe. In that case, simply ignore this message after reviewing the code that it does not do anything sensitive.

<!-- TODO More details what is 'anything sensitive' -->