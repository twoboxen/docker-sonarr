# Docker Sonarr (previously NzbDrone)

### Tags
- twoboxen/sonarr:**latest** - Installs from Sonarr master repository

### Ports
- **TCP 8989** - Web Interface

### Volumes
- **/volumes/config** - Sonarr configuration folder
- **/volumes/blackhole** - Files to download
- **/volumes/media** - Sonarr media folder

Docker runs as uid 65534 (nobody on debian, nfsnobody on fedora). When mounting volumes from the host, ensure this uid has the correct permission on the folders.

## Running

The quickest way to get it running without integrating with a download client or media server (plex)
```
sudo docker run --restart always --name sonarr -p 8989:8989 -v /path/to/your/media/folder/:/volumes/media -v /path/to/your/download/watch/folder:/volumes/blackhole twoboxen/sonarr
```

You can link to the download client's volumes and plex using something similar:
```
sudo docker run --restart always --name sonarr --volumes-from plex --link plex:plex --volumes-from deluge --link deluge:deluge -p 8989:8989 twoboxen/sonarr
```

## Updating

To update successfully, you must configure Sonarr to use the update script in ``/sonarr-update.sh``. This is configured under Settings > (show advanced) > General > Updates > change Mechanism to Script.

After updating, the update script will stop the container. If the container was run with `--restart always`, docker will automatically restart Sonarr.
