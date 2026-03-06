## Autologin at startup

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

## No sound after pausing

Audio stops working if you play sound, pause for 5-10s, then try
to play again. The cause is WirePlumber suspending idle ALSA nodes

Fix: disable suspension timeout in WirePlumber config

```sh
$ mkdir -p ~/.config/wireplumber/wireplumber.conf.d
$ nvim ~/.config/wireplumber/wireplumber.conf.d/51-disable-suspension.conf
```

```
monitor.alsa.rules = [
   {
      matches = [
         { node.name = "~alsa_output.*" }
      ]
      actions = {
         update-props = {
            session.suspend-timeout-seconds = 0
         }
      }
   }
]
```

## Don't suspend in close lid

Sound was lost when closing the lid, so the workaround is never suspending the computer
we just lock and turn off the screen instead

```sh
$ sudo nvim /etc/systemd/logind.conf
```

```
HandleLidSwitch=lock
HandleLidSwitchExternalPower=lock
```
