Configures postfix for use on Rightscale.

### Recipe
* rsc_postfix::default

### Attributes
* node["rsc_postfix"]["relayhost"] = the relay host host.  example: myrelayhost:2525
* node["rsc_postfix"]["smtp_sasl_user_name"] = the username or access key
* node["rsc_postfix"]["smtp_sasl_passwd"] = the password or secret


### Usage
Add the recipe anywhere in the runlist, preferably near the beginning
