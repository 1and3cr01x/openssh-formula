require 'serverspec'
set :backend, :exec

def service_name()
  return case os[:family]
    when 'redhat' then 'sshd'
    when 'debian', 'ubuntu' then 'ssh'
  end
end

describe 'openssl/config.sls' do

  describe service(service_name()) do
    it { should be_running }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_mode 600 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe file('/etc/ssh/ssh_config') do
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

end
