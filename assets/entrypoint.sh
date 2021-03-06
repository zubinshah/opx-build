#! /bin/bash

if [ -n "${LOCAL_UID}" ]; then
    LOCAL_GID=${LOCAL_GID:-${LOCAL_UID}}

    if ! grep -q opx /etc/group; then
        groupadd -o --gid=${LOCAL_GID} opx
        useradd -o --uid=${LOCAL_UID} --gid=${LOCAL_GID} -s /bin/bash opx
        echo 'opx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
        echo '%opx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    fi

    exec gosu opx "$@"
fi

exec "$@"
