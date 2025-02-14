#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

if [[ "${DISTRO}" == "alpine" ]]; then
    apk add --no-cache \
        runuser \
        xhost
elif [ "${DISTRO}" == "opensuse" ]; then
    zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/' packman
    zypper -n --gpg-auto-import-keys dup --from packman --allow-vendor-change
    zypper install -ny xhost
fi

COMMIT_ID="003984d8bc46847b87acbe8a877d43b586b9b793"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')

mkdir -p $STARTUPDIR/recorder
wget -qO- https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_recorder_service/${COMMIT_ID}/kasm_recorder_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz | tar -xvz -C $STARTUPDIR/recorder/
echo "${BRANCH}:${COMMIT_ID}" > $STARTUPDIR/recorder/kasm_recorder_service.version
