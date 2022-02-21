This Stapler web method does not perform a permission check. This can be problem if the method returns private information, or has side effects. See [the documentation](https://www.jenkins.io/doc/developer/security/form-validation/).

### False Positive Guidance

This check can easily identify _false positives_, i.e. safe code that is marked as being unsafe. In that case, simply ignore this message after confirming that the code does not return private information, or have side effects.

<!-- TODO More details what is 'anything sensitive' -->

Additionally, this check has a known bug: It identifies methods matching the Stapler web method naming scheme (e.g. `doWhatever`) even if they have no arguments and declare a `void` return type. [Since Jenkins 2.154 and LTS 2.138.4, these methods can no longer be invoked by Stapler](https://www.jenkins.io/doc/developer/handling-requests/actions/), so do not need a permission check. In this case, mark this finding as false positive.
