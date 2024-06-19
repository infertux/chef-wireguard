package 'wireguard'

systemd_unit "wg-quick@#{node[cookbook_name]['interface']}.service" do
  action %i(enable)
end
