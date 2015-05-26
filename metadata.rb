name             "rsc_postfix"
maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs and configures postfix"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

supports "centos"
supports "redhat"
supports "ubuntu"

depends "postfix", '3.6.2'
depends "marker"

recipe "rsc_postfix::default", "Configure postfix to use a relayhost"

recipe "rsc_postfix::setup_local_delivery",
  "Configures postfix to deliver local mail by accepting SMTP connections" +
  " on localhost."

attribute "rsc_postfix/smtp_sasl_user_name",
  :display_name => "SMTP Username",
  :description =>
  "The SMTP username or access key",
  :required => "optional",
  :recipes => ["rsc_postfix::default"]

attribute "rsc_postfix/smtp_sasl_passwd",
  :display_name => "SMTP passwd",
  :description =>
  "the SMTP password or secret",
  :required => "optional",
  :recipes => ["rsc_postfix::default"]

attribute "rsc_postfix/relayhost",
  :display_name => "SMTP Relay Host",
  :description =>
  "The SMTP Relay Host.  Default port is 25. Include the port number"+
  "if you want to use a different port.  For example:  myhost:2525",
  :required => "optional",
  :recipes => ["rsc_postfix::default"]
