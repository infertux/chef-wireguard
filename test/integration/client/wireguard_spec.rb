control 'wireguard-1' do
  title 'wireguard is configured properly'
  impact 1.0

  describe file('/etc/wireguard/wg0.conf') do
    it { should be_file }
    its('content') { should_not include 'ListenPort' }
    its('content') { should include 'PrivateKey = 6BpqO2LShKXW+8LvjcINlNcoHA28QX9qN7/bHwL+80c=' }
  end
end

control 'wireguard-2' do
  title 'wireguard is running'
  impact 1.0

  describe port(51820) do
    it { should_not be_listening }
  end

  describe command('wg') do
    its('exit_status') { should eq 0 }
    its('stderr') { should be_empty }
    its('stdout') { should match /^interface: wg0\n  public key:/ }
  end
end
