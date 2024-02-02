# docker-sdrtrunk

Work in progress. Runs sdrtrunk in vnc.

```yml
services:
  sdrtrunk:
    image: aegershman/docker-sdrtrunk:latest
    container_name: sdrtrunk
    restart: unless-stopped
    privileged: true
    environment:
      - PUID=0
      - PGID=0
      - TZ=America/Chicago
    devices:
      - /dev/bus/usb:/dev/bus/usb
    volumes:
      - /appdata/sdrtrunk/config:/config
      - /appdata/sdrtrunk/root:/root
    ports:
      3000:3000
```
