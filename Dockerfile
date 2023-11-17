FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SDRTRUNK_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aegershman"

# title
ENV TITLE=sdrtrunk

RUN \
  mkdir -p /etc/modprobe.d && \
  echo "blacklist dvb_usb_rtl28xxu" > /etc/modprobe.d/rtl-sdr-blacklist.conf && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    unzip \
    libgtk-3-0 && \
  echo "**** install sdrtrunk ****" && \
  sed -i 's|</applications>|  <application title="sdrtrunk" type="normal">\n    <maximized>yes</maximized>\n  </application>\n</applications>|' /etc/xdg/openbox/rc.xml && \
  mkdir -p \
    /opt/sdrtrunk && \
  if [ -z ${SDRTRUNK_RELEASE+x} ]; then \
    SDRTRUNK_RELEASE=$(curl -sX GET "https://api.github.com/repos/DSheirer/sdrtrunk/releases/latest" \
    | jq -r .tag_name); \
  fi && \
  SDRTRUNK_URL="https://github.com/DSheirer/sdrtrunk/releases/download/${SDRTRUNK_RELEASE}/sdr-trunk-linux-x86_64-${SDRTRUNK_RELEASE}.zip" && \
  curl -o \
    /tmp/sdrtrunk-tarball.zip -L \
    "${SDRTRUNK_URL}" && \
  unzip -q /tmp/sdrtrunk-tarball.zip -d /opt/sdrtrunk && \
  mv /opt/sdrtrunk/sdr-trunk-* /opt/sdrtrunk/sdr-trunk && \
  mkdir -p /root/SDRTrunk && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
