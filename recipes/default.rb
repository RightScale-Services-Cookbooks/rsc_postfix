marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

#override attributes with inputs
node.override["postfix"]["main"]["relayhost"]=node["rsc_postfix"]["relayhost"]
node.override['postfix']['sasl']['smtp_sasl_user_name'] = node["rsc_postfix"]["smtp_sasl_user_name"]
node.override['postfix']['sasl']['smtp_sasl_passwd'] = node["rsc_postfix"]["smtp_sasl_passwd"]


include_recipe "postfix::server"

service "postfix" do
  action :restart
end