include_recipe "#{cookbook_name}::_common"

configure_keys recipe_name

client = node[cookbook_name]['client']
server = node[cookbook_name]['server']

template "/etc/wireguard/#{node[cookbook_name]['interface']}.conf" do
  source 'client.conf.erb'
  owner 'root'
  group 'root'
  mode '0400'
  sensitive true
  variables(
    endpoint: client['endpoint'],
    address: client['address'],
    private_key: client['private_key'],
    public_key: server['public_key'],
    allowed_ips: server['address'],
  )
  notifies :restart, "systemd_unit[wg-quick@#{node[cookbook_name]['interface']}.service]"
end
