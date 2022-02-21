== Ignoring return value of `#hasPermission` calls

This code calls `#hasPermission` without checking the return value. This call should either be `#checkPermission`, or have its return value used.

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
