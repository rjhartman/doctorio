# Doctorio

Basic Docker image for running a [headless Factorio server](https://wiki.factorio.com/Multiplayer#Dedicated/Headless_server).

## Usage

The image contains the unarchived headless server at `/opt/factorio/`. To run the server, mount the neccessary files and run the `--start-server` command. For example:

```bash
docker run -v ~/factorio/saves:/opt/factorio/saves -v ~/factorio/config:/opt/factorio/config -p 34197:34197/udp rhartman99/doctorio:<VERSION> --start-server /opt/factorio/saves/<SAVE_FILE>.zip
```

This assumes you have a `~/factorio` directory that looks like this:

```bash
$ tree
.
├── config
│   └── config.ini
└── saves
    ├── _autosave1.zip
    ├── _autosave2.zip
    ├── _autosave3.zip
    ├── _autosave4.zip
    ├── _autosave5.zip
    └── main.zip

3 directories, 8 files
```

### Using systemd

To host this server, I use the following service file at `/etc/systemd/system/factorio.service`:

```ini
[Unit]
Description=Factorio game server
After=docker.service
Requires=docker.service

[Service]
Type=simple
Restart=always
RestartSec=1
User=rhartman
ExecStartPre=-/usr/bin/docker stop %n
ExecStartPre=-/usr/bin/docker rm %n
ExecStart=/usr/bin/docker run --name %n -v /home/rhartman/factorio/saves:/opt/factorio/saves -v /home/rhartman/factorio/config:/opt/factorio/config \
                -p 34197:34197/udp rhartman99/doctorio:1.1.109 --start-server /opt/factorio/saves/main.zip \
                --use-server-whitelist --server-whitelist /opt/factorio/config/server-whitelist.json

[Install]
WantedBy=multi-user.target
```

Make sure to replace `rhartman` with whatever user you are running. Enabling this and starting the service will ensure the server restarts on crash, and starts when the machine is booted:

```
sudo systemctl enable factorio
sudo systemctl start factorio
```

## Building

To build and tag a new version of the image, run the build target with a valid Factorio version number:
```
make build VERSION=1.1.109 
```

This would build and tag rhartman99/doctorio:1.1.109.

