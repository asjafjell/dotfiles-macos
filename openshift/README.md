# Setting up Openshift for plugins
1. Add the folder with plugins to your `PATH`. For this repo, this Openshift folder is added.
2. Create a script in this folder with prefix `oc-`.
3. Verify plugins are loaded using `oc plugin list`.

# Writing plugins
Please see [Openshift documentation](https://docs.openshift.com/container-platform/4.11/cli_reference/openshift_cli/extending-cli-plugins.html) for great instructions.

# Getting plugins installed