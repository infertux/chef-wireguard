# Wireguard Chef cookbook

## Example usage

Let's assume a server listening on a static public address [2001:1:2:3::cafe] on UDP port 51820
and with a Wireguard private address [fc00::42:1].

Let's assume a client assigned with a dynamic public IP address
and with a Wireguard private address [fc00::42:2].

### Server

Add `wireguard::server` to the run list with the following attributes:

```ruby
default['wireguard']['server'] = {
  address: %w(fc00::42:1/112),
  port: 51820,
  public_key: 'SERVER_PUB_KEY',
  private_key: 'SERVER_PRIV_KEY',
  peers: { 'fc00::42:2/128': 'CLIENT_PUB_KEY' },
}
```

### Client

Add `wireguard::client` to the run list with the following attributes:

```ruby
default['wireguard']['client'] = {
  public_key: 'CLIENT_PUB_KEY',
  private_key: 'CLIENT_PRIV_KEY',
  endpoint: '[2001:1:2:3::cafe]:51820',
  address: %w(fc00::42:2/128),
}

default['wireguard']['server'] = {
  address: %w(fc00::42:1/128),
  public_key: 'SERVER_PUB_KEY',
}
```

Once server and client are both converged, you can inspect the Wireguard connection with the `wg` command and ping machines using the [fc00::42:x] addresses.

Bandwidth test using `socat`:
  - server: `dd if=/dev/zero bs=1M count=100 | socat - tcp6-listen:1234,reuseport`
  - client: `socat - tcp6:[fc00::42:1]:1234`

## License

AGPLv3+
