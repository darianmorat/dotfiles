## Autologin

```sh
$ sudo groupadd -r autologin
$ sudo gpasswd -a username autologin
```

```sh
$ sudo nvim /etc/lightdm/lightdm.conf
```

```
autologin-guest=false
autologin-user=username
autologin-user-timeout=0
```

## Sound solution

After a system update, audio stops working if you play sound, pause for 5-10s, then try
to play again. The cause is WirePlumber suspending idle ALSA nodes

Fix: disable suspension timeout in WirePlumber config

```sh
$ mkdir -p ~/.config/wireplumber/wireplumber.conf.d
$ nvim ~/.config/wireplumber/wireplumber.conf.d/disable-suspend.conf
```

```
monitor.alsa.rules = [
  {
    matches = [
      { node.name = "alsa_output.pci-0000_00_1f.3-platform-sof-essx8336.HiFi__Speaker__sink" }
    ]
    actions = {
      update-props = {
        session.suspend-timeout-seconds = 0
      }
    }
  }
]
```
