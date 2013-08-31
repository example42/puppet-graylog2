require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'graylog2' do

  let(:title) { 'graylog2' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

  describe 'Test standard installation' do
    it { should contain_puppi__netinstall('netinstall_graylog2').with_destination_dir('/opt') }
    it { should contain_service('graylog2-server').with_ensure('running') }
    it { should contain_service('graylog2-server').with_enable('true') }
    it { should contain_file('graylog2.conf').with_ensure('present') }
  end

  describe 'Test standard installation with monitoring and firewalling' do
    let(:params) { {:monitor => true , :firewall => true, :port => '42', :protocol => 'tcp' } }
    it { should contain_puppi__netinstall('netinstall_graylog2').with_destination_dir('/opt') }
    it { should contain_service('graylog2-server').with_ensure('running') }
    it { should contain_service('graylog2-server').with_enable('true') }
    it { should contain_file('graylog2.conf').with_ensure('present') }
    it { should contain_monitor__process('graylog2_process').with_enable('true') }
    it { should contain_firewall('graylog2_tcp_42').with_enable('true') }
  end

  describe 'Test noops mode' do
    let(:params) { {:noops => true, :monitor => true , :firewall => true, :port => '42', :protocol => 'tcp'} }
    it { should contain_puppi__netinstall('netinstall_graylog2').with_destination_dir('/opt') }
    it { should contain_service('graylog2-server').with_noop('true') }
    it { should contain_file('graylog2.conf').with_noop('true') }
    it { should contain_monitor__process('graylog2_process').with_noop('true') }
    it { should contain_monitor__process('graylog2_process').with_noop('true') }
    it { should contain_monitor__port('graylog2_tcp_42').with_noop('true') }
    it { should contain_firewall('graylog2_tcp_42').with_noop('true') }
  end

  describe 'Test customizations - template' do
    let(:params) { {:template => "graylog2/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
    it 'should generate a valid template' do
      content = catalogue.resource('file', 'graylog2.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'graylog2.conf').send(:parameters)[:content]
      content.should match "value_a"
    end
  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet:///modules/graylog2/spec"} }
    it { should contain_file('graylog2.conf').with_source('puppet:///modules/graylog2/spec') }
  end

  describe 'Test customizations - source_dir' do
    let(:params) { {:source_dir => "puppet:///modules/graylog2/dir/spec" , :source_dir_purge => true } }
    it { should contain_file('graylog2.dir').with_source('puppet:///modules/graylog2/dir/spec') }
    it { should contain_file('graylog2.dir').with_purge('true') }
    it { should contain_file('graylog2.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "graylog2::spec" } }
    it { should contain_file('graylog2.conf').with_content(/rspec.example42.com/) }
  end

  describe 'Test service autorestart' do
    let(:params) { {:service_autorestart => "no" } }
    it 'should not automatically restart the service, when service_autorestart => false' do
      content = catalogue.resource('file', 'graylog2.conf').send(:parameters)[:notify]
      content.should be_nil
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }
    it { should contain_puppi__ze('graylog2').with_helper('myhelper') }
  end

  describe 'Test Monitoring Tools Integration' do
    let(:params) { {:monitor => true, :monitor_tool => "puppi" } }
    it { should contain_monitor__process('graylog2_process').with_tool('puppi') }
  end

  describe 'Test Firewall Tools Integration' do
    let(:params) { {:firewall => true, :firewall_tool => "iptables" , :protocol => "tcp" , :port => "42" } }
    it { should contain_firewall('graylog2_tcp_42').with_tool('iptables') }
  end

  describe 'Test OldGen Module Set Integration' do
    let(:params) { {:monitor => "yes" , :monitor_tool => "puppi" , :firewall => "yes" , :firewall_tool => "iptables" , :puppi => "yes" , :port => "42" , :protocol => 'tcp' } }
    it { should contain_monitor__process('graylog2_process').with_tool('puppi') }
    it { should contain_firewall('graylog2_tcp_42').with_tool('iptables') }
    it { should contain_puppi__ze('graylog2').with_ensure('present') }
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :port => '42' } }
    it 'should honour top scope global vars' do should contain_monitor__process('graylog2_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :graylog2_monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :port => '42' } }
    it 'should honour module specific vars' do should contain_monitor__process('graylog2_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :graylog2_monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu'  } }
    let(:params) { { :port => '42' } }
    it 'should honour top scope module specific over global vars' do should contain_monitor__process('graylog2_process').with_enable('true') end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :monitor => true , :firewall => true, :port => '42' } }
    it 'should honour passed params over global vars' do should contain_monitor__process('graylog2_process').with_enable('true') end
  end

end

