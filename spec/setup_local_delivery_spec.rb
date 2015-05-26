require 'spec_helper'

describe 'rsc_postfix::setup_local_delivery' do
  
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('postfix::server')
  end

  let(:chef_run) { ChefSpec::Runner.new do |node|
    end.converge(described_recipe) }

  it 'should have override attributes' do

    expect(chef_run.node['postfix']['inet_interfaces']).to eq "all"
    expect(chef_run.node['postfix']['mail_type']).to eq "master"

  end
  
  it "start service" do
    expect(chef_run).to start_service("postfix")
  end
  
  it "enable service" do
    expect(chef_run).to enable_service("postfix")
  end
    
  it 'include postfix recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('postfix::server')
    chef_run
  end
end