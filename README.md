Configures postfix for use on Rightscale.

[![Release](https://img.shields.io/github/release/rightscale-services-cookbooks/rsc_postfix.svg?style=flat)][release]
[![Build Status](https://img.shields.io/travis/rightscale-services-cookbooks/rsc_postfix.svg?style=flat)][travis]

[release]: https://github.com/rightscale-services-cookbooks/rsc_postfix/releases/latest
[travis]: https://travis-ci.org/rightscale-services-cookbooks/rsc_postfix

We have tested using this cookbook using AWS SES and SendGrid as the relay host.  You 
may be able to use others.  TLS is enabled by default.

### Recipe
* rsc_postfix::default - setup postfix with a relay host
* rsc_postfix::setup_local_delivery - setup postfix to send from localhost, no relay host

### Attributes
* node["rsc_postfix"]["relayhost"] = the relay host and port.  example: myrelayhost:587
* node["rsc_postfix"]["smtp_sasl_user_name"] = optional, the username or access key
* node["rsc_postfix"]["smtp_sasl_passwd"] = optional, the password or secret


### Usage
Add the recipe anywhere in the runlist, preferably near the beginning


