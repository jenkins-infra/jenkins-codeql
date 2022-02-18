A `Callable` implements `#checkRoles(RoleChecker)` without calling `RoleChecker#check` on the provided argument.

This may allow malicious agent processes to execute code on the Jenkins controller, compromising security, on Jenkins before 2.319 and LTS 2.303.3.

See the [method Javadoc](https://javadoc.jenkins.io/component/remoting/org/jenkinsci/remoting/RoleSensitive.html) and [developer guide for remoting callabes](https://www.jenkins.io/doc/developer/security/remoting-callables/)
