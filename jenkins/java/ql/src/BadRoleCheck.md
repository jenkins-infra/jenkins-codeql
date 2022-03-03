This `Callable` implements `#checkRoles(RoleChecker)` without calling `RoleChecker#check` on the provided argument.

## Why is this a problem?

This code may allow malicious agent processes to execute code on the Jenkins controller, compromising security, on Jenkins before 2.319 and LTS 2.303.3.

## Next Steps

<!-- Generic section used in all findings -->

1. Don't panic. Even if this issue is already in published plugin releases, you do not need to _immediately_ change the code in whatever way is needed to make the finding disappear. If you change the code without understanding why the finding appears, you may end up not really fixing the problem anyway.
2. Determine whether this finding is a false positive (see guidance below). This is an automated scan result, so that's always a possibility. In general, the rules err on the side of caution, so false positives are relatively common. If it is a false positive, mark it as such on the GitHub UI and you're done!
3. If you have determined that this is a true positive finding, review the documentation below how to resolve it.

If this finding is in a plugin hosted by the Jenkins project, you can also always [contact the Jenkins Security Team via Jira or email](https://www.jenkins.io/security/#reporting-vulnerabilities) to ask for help in resolving this finding.

## Is this a false positive?

While some Callables are intended to be sent in the agent-to-controller direction, [a security hardening in Jenkins 2.319 and LTS 2.303.3](https://www.jenkins.io/doc/book/security/controller-isolation/required-role-check/) rejects any Callables sent in the agent-to-controller direction if there's an empty role check. As a result, your users would probably already have reported a regression when using recent versions of Jenkins.

It is possible that you're using the `Callable` interface for code that is only ever invoked locally rather than through a remoting channel _and_ your implementation has fields that cannot be serialized. In that case, this finding would not be a real concern, but it's still recommended that you switch to `NotReallyRoleSensitiveCallable` to make your intention clear.

## How can I fix the code?

If the `Callable` is always invoked locally, it should extend `NotReallyRoleSensitiveCallable` and stop overriding `#checkRoles`.

If the `Callable` is potentially sent from the controller to agents, it should extend `MasterToSlaveCallable` and stop overriding `#checkRoles`.

In very rare cases, the `Callable` needs to be sent from an agent to the controller. More work is needed to ensure this is done safely. See the [developer guide for remoting callabes](https://www.jenkins.io/doc/developer/security/remoting-callables/) for more information.
