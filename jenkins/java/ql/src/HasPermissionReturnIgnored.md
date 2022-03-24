This code calls `#hasPermission` without checking the return value. This call should either be `#checkPermission`, or have its return value used.

## Why is this a problem?

This is indicative of a bug: Code intended to ensure the user accessing some functionality has a given permission, but ignoring the return value of this method means that anyone would be able to proceed.

## Next Steps

<!-- Generic section used in all findings -->

1. Don't panic, even if this issue is present in previous plugin releases. Do not change your code without understanding why the finding appears. You may end up not fixing the problem, only hiding it instead.
2. Determine whether this finding is a false positive (see guidance below). This is an automated scan result, so that's always a possibility. In general, the rules err on the side of caution, so false positives are pretty common. If it is a false positive, mark it as such on the GitHub UI and you're done!
3. If this is a true positive finding, use the documentation below to resolve it.

If this finding is in a plugin hosted by the Jenkins project, you can also always [contact the Jenkins Security Team via Jira or email](https://www.jenkins.io/security/#reporting-vulnerabilities) to ask for help in resolving this finding.

## Is this a false positive?

At a minimum, this line of code would need to be removed if there's no need for a permission check. It's probably more likely that a permission check was intended but not correctly done.

## How can I fix the code?

If your current code looks like this:

    Jenkins.get().hasPermission(Jenkins.ADMINISTER)

Change it to this:

    Jenkins.get().checkPermission(Jenkins.ADMINISTER)

Alternatively, to get a non-default behavior (throwing an exception), depending on the context of this code, you could do something like this:

In form validation (typically in methods called `#doCheckFieldname`):

    if (!Jenkins.get().hasPermission(Jenkins.ADMINISTER)) {
        return FormValidation.ok();
    }

In methods providing values for selection menus (typically methods called `#doFillFieldname`):

    if (!Jenkins.get().hasPermission(Jenkins.ADMINISTER)) {
        return new ListBoxModel();
    }
