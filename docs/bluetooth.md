To enable battery status of bluetooth headphones connected to Linux
Just edit the file /etc/bluetooth/main.conf and and adding the following line to the [General] section

```
Experimental = true
```

Then restart the bluetooth service:
``` bash
sudo systemctl restart bluetooth
```
