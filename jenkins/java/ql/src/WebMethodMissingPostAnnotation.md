This Stapler web method has no verb annotation. This can be problem if the method has side effects and if so, is known as a [Cross-site request forgery (CSRF)](https://owasp.org/www-community/attacks/csrf) vulnerability. See [the documentation](https://www.jenkins.io/doc/developer/security/form-validation/).

## False Positive Guidance

This check can easily identify _false positives_, i.e. safe code is marked as being unsafe. In that case, simply ignore this message after reviewing the code that it does not have _side effects_.

<!-- TODO More details what is 'anything sensitive' -->

<!-- TODO Explain relation to the 'missing permission check' -->
