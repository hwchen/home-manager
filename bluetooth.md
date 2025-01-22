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

In order to get it to use the microphone, I also had to use `blueman-manager` gui to set the profile to HFP/HSP (right click on the headphone entry). https://askubuntu.com/questions/1085960/use-bluetooth-headset-with-microphone-hfp-in-ubuntu-18-04

I also used pipewire instead of pulseaudio, as set up in the the above issue. Don't know if its actually needed, as it looks like pulseaudio got a patch.

I need to switch between headphone profiles for decent sound.
- SBC for regular audio
- mSBC for HFP/HSP

But I rarely use headphones for listening on my laptop anyways. So I should probably leave it on mSBC.
