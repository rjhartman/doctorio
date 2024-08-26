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

## Building

To build and tag a new version of the image, run the build target with a valid Factorio version number:
```
make build VERSION=1.1.109 
```

This would build and tag rhartman99/doctorio:1.1.109.

