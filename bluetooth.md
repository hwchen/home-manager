# Bluetooth

Use `bluetoothctl` https://waylonwalker.com/linux-bluetoothctl/

```
scan on
scan off
devices
paired-devices
pair <MAC address>
connect <MAC address>
disconnect <MAC address>
help
```

But also I needed to run
```
systemctl --user enable pulseaudio
systemctl --user start pulseaudio
```
to get it to connect. https://askubuntu.com/questions/1479606/bluetooth-br-connection-profile-unavailable-issue-on-upgrade-to-xubuntu-23-04
