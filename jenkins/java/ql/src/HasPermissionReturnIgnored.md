This code calls `#hasPermission` without checking the return value. This call should either be `#checkPermission`, or have its return value used.

## Why is this a problem?

This is indicative of a bug: Code intended to ensure the user accessing some functionality has a given permission, but ignoring the return value of this method means that anyone would be able to proceed.

## Next Steps

<!-- Generic section used in all findings -->

1. Don't panic. Even if this issue is already in published plugin releases, you do not need to _immediately_ change the code in whatever way is needed to make the finding disappear. If you change the code without understanding why the finding appears, you may end up not really fixing the problem anyway.
2. Determine whether this finding is a false positive (see guidance below). This is an automated scan result, so that's always a possibility. In general, the rules err on the side of caution, so false positives are relatively common. If it is a false positive, mark it as such on the GitHub UI and you're done!
3. If you have determined that this is a true positive finding, review the documentation below how to resolve it.

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
