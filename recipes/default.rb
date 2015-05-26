marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

#override attributes with inputs
raise "Missing input: rsc_postfix/relayhost" if node["rsc_postfix"]["relayhost"].nil?

node.override["postfix"]["main"]["relayhost"]=node["rsc_postfix"]["relayhost"] 
node.override['postfix']['sasl']['smtp_sasl_user_name'] = node["rsc_postfix"]["smtp_sasl_user_name"] if node["rsc_postfix"]["smtp_sasl_user_name"]
node.override['postfix']['sasl']['smtp_sasl_passwd'] = node["rsc_postfix"]["smtp_sasl_passwd"] if node["rsc_postfix"]["smtp_sasl_passwd"]

node.override['postfix']['use_alias_maps'] = true
node.override['postfix']['use_transport_maps'] = true
node.override['postfix']['use_access_maps'] = true
node.override['postfix']['mail_type'] ='master' 
node.override['postfix']['smtpd_use_tls'] = 'yes'
node.override['postfix']["main"]['smtp_sasl_auth_enable'] = 'yes'
node.override['postfix']['smtp_tls_security_level'] = 'encrypt'
node.override['postfix']['smtp_tls_note_starttls_offer'] = 'yes'

include_recipe "postfix::server"

service "postfix" do
  action :restart
end