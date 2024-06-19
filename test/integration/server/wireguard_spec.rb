control 'wireguard-1' do
  title 'wireguard is configured properly'
  impact 1.0

  describe file('/etc/wireguard/wg0.conf') do
    it { should be_file }
    its('content') { should include 'ListenPort = 51820' }
    its('content') { should include 'PrivateKey = cKTRrWKWBAbvdgSx7brEAKl+fS9ZADcrzdgVrNRbfWw=' }
  end
end

control 'wireguard-2' do
  title 'wireguard is running'
  impact 1.0

  describe port(51820) do
    it { should be_listening }
    its('protocols') { should cmp %w(udp udp6) }
    its('addresses') { should cmp %w(0.0.0.0 ::) }
  end

  describe command('wg') do
    its('exit_status') { should eq 0 }
    its('stderr') { should be_empty }
    its('stdout') { should match /^interface: wg0\n  public key:/ }
  end
end
