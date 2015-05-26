marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end


include_recipe "postfix::server"

service "postfix" do
  action [:enable,:start]
end