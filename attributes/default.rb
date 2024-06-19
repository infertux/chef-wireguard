default['wireguard']['interface'] = 'wg0'

default['wireguard']['server']['port'] = 51820
default['wireguard']['server']['address'] = %w() # e.g. %w(10.0.0.1/24) or %w(10.0.0.1/24 fc00::1/112) with IPv6 unique local address (ULA)
default['wireguard']['server']['public_key'] = ''
default['wireguard']['server']['private_key'] = ''
default['wireguard']['server']['peers'] = {
  # '10.0.0.2/32': 'public_key',
}

default['wireguard']['client']['public_key'] = ''
default['wireguard']['client']['private_key'] = ''
default['wireguard']['client']['endpoint'] = '' # e.g. '1.1.1.1:51820'
default['wireguard']['client']['address'] = %w() # e.g. %w(10.0.0.2/32)
