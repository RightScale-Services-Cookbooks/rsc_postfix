require 'spec_helper'

describe 'rsc_postfix::default' do
  
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('postfix::server')
  end

  let(:chef_run) { ChefSpec::Runner.new do |node|
      node.default["rsc_postfix"]["relayhost"] = "localhost:2525"
      node.default["rsc_postfix"]["smtp_sasl_user_name"] = "username"
      node.default["rsc_postfix"]["smtp_sasl_passwd"] = "password"
    end.converge(described_recipe) }
  
  let(:chef_run_centos) { ChefSpec::Runner.new(platform: 'centos', version: '6.5') do |node|
      node.default["rsc_postfix"]["relayhost"] = "localhost:2525"
      node.default["rsc_postfix"]["smtp_sasl_user_name"] = "username"
      node.default["rsc_postfix"]["smtp_sasl_passwd"] = "password"
    end.converge(described_recipe) }

  it 'should have override attributes' do
    expect(chef_run.node["postfix"]["main"]["relayhost"]).to eq "localhost:2525"
    expect(chef_run.node['postfix']['sasl']['smtp_sasl_user_name']).to eq "username"
    expect(chef_run.node['postfix']['sasl']['smtp_sasl_passwd']).to eq "password"

    expect(chef_run.node['postfix']['use_alias_maps']).to eq true
    expect(chef_run.node['postfix']['use_transport_maps'] ).to eq true
    expect(chef_run.node['postfix']['use_access_maps']).to eq true
    expect(chef_run.node['postfix']['mail_type']).to eq "master"
    expect(chef_run.node['postfix']["main"]['smtp_sasl_auth_enable']).to eq "yes"
    expect(chef_run.node['postfix']['smtp_tls_security_level']).to eq "encrypt"
    expect(chef_run.node['postfix']['smtp_tls_note_starttls_offer']).to eq "yes"
    expect(chef_run.node['postfix']['cafile']).to eq "/etc/ssl/certs/ca-certificates.crt"
  end

  it 'should have override attributes for centos' do
    expect(chef_run_centos.node['postfix']['cafile']).to eq "/etc/pki/tls/cert.pem"
  end
  
  
  it "restart service" do
    expect(chef_run).to restart_service("postfix")
  end
  
    
  it 'include postfix recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('postfix::server')
    chef_run
  end
end