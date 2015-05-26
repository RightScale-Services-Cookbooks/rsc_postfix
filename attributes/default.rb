override['postfix']['use_alias_maps'] = true
override['postfix']['use_transport_maps'] = true
override['postfix']['use_access_maps'] = true
override['postfix']['mail_type'] ='master' 
override['postfix']['smtpd_use_tls'] = 'yes'
override['postfix']["main"]['smtp_sasl_auth_enable'] = 'yes'
override['postfix']['smtp_tls_security_level'] = 'encrypt'
override['postfix']['smtp_tls_note_starttls_offer'] = 'yes'

# correctly set the ca file for the platform
case node['platform_family']
when 'debian'
  override['postfix']['cafile'] = '/etc/ssl/certs/ca-certificates.crt'
when 'rhel'
  override['postfix']['cafile'] = '/etc/pki/tls/cert.pem'
end

