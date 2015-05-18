Configures postfix for use on Rightscale.
[![Release](https://img.shields.io/github/release/rightscale-services-cookbooks/rsc_postfix.svg?style=flat)][release]
[![Build Status](https://img.shields.io/travis/rightscale-services-cookbooks/rsc_postfix.svg?style=flat)][travis]

[release]: https://github.com/rightscale-services-cookbooks/rsc_postfix/releases/latest
[travis]: https://travis-ci.org/rightscale-services-cookbooks/rsc_postfix

### Recipe
* rsc_postfix::default - setup postfix with a relay host

### Attributes
* node["rsc_postfix"]["relayhost"] = the relay host host.  example: myrelayhost:2525
* node["rsc_postfix"]["smtp_sasl_user_name"] = the username or access key
* node["rsc_postfix"]["smtp_sasl_passwd"] = the password or secret


### Usage
Add the recipe anywhere in the runlist, preferably near the beginning
