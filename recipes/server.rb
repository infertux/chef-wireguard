include_recipe "#{cookbook_name}::_common"

configure_keys recipe_name

server = node[cookbook_name]['server']

template "/etc/wireguard/#{node[cookbook_name]['interface']}.conf" do
  source 'server.conf.erb'
  owner 'root'
  group 'root'
  mode '0400'
  sensitive true
  variables(
    address: server['address'],
    port: server['port'],
    peers: server['peers'],
    private_key: server['private_key'],
  )
  notifies :restart, "systemd_unit[wg-quick@#{node[cookbook_name]['interface']}.service]"
end
