# Default

require 'spec_helper'

postfix_name = 'postfix'
main_file = '/etc/postfix/main.cf'
master_file = '/etc/postfix/master.cf'
sasl_file ='/etc/postfix/sasl_passwd'
server_packages = %w{postfix}


describe "{Postfix server packages are installed" do
  server_packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end

describe service(postfix_name) do
  it { should be_enabled }
  it { should be_running }
end

describe port(25) do
  it { should be_listening }
end

describe file(main_file) do
  it { should be_file }
end
describe file(master_file) do
  it { should be_file }
end

describe file(sasl_file) do
  it { should be_file }
end

describe "verify the attributes set in #{main_file}" do
  {
    alias_maps: "hash:/etc/aliases",
    transport_maps: "hash:/etc/postfix/transport",
    access_maps: "hash:/etc/postfix/access",
    smtpd_use_tls: 'yes',
    smtp_sasl_auth_enable: 'yes',

  }.each do |attribute, value|
    describe command("grep -E \"^#{attribute}\\s+\" #{main_file}") do
      its(:stdout) { should match /#{value}/ }
    end
  end
end
describe "verify sasl password settings in #{sasl_file}" do
  describe command("tail -1 #{sasl_file}") do
    its(:stdout) { should match "myrelayhost user:password" }
  end
end