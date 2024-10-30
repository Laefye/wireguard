#!/bin/bash

# Параметры для установщика
DIST="/"
INTERNET=ens3
WG=wg0
GATEWAY="172.13.10.1/24"

CONFIG=$DIST"etc/laefye_wireguard"
SYSTEMD=$DIST"usr/lib/systemd/system"
BIN=$DIST"usr/bin"

execute_template() {
    chmod 755 $TMPL
    command $TMPL > $TMPLOUT
    chmod 755 $TMPLOUT
}

update_config() {
    TMPL=templates/wireguard.conf.template TMPLOUT=$CONFIG/wireguard.conf execute_template
    echo $CONFIG/wireguard.conf
}

if [ "$1" == "install" ]; then
    mkdir -p $CONFIG
    mkdir -p $BIN
    mkdir -p $SYSTEMD

    WGCONFIG=$(update_config)
    TMPL=templates/laefye_wireguard.template TMPLOUT=$BIN/laefye_wireguard WGCONFIG=$WGCONFIG INTERNET=$INTERNET WG=$WG GATEWAY=$GATEWAY execute_template
    TMPL=templates/laefye_wireguard.service.template TMPLOUT=$SYSTEMD/laefye_wireguard.service BIN="$BIN/laefye_wireguard run" execute_template
fi

if [ "$1" == "uninstall" ]; then
    # Отключение службы (если включена)
    systemctl stop laefye_wireguard.service || true
    systemctl disable laefye_wireguard.service || true

    rm -r $CONFIG
    rm $BIN/laefye_wireguard
    rm $SYSTEMD/laefye_wireguard.service
fi

if [ "$1" == "update-config" ]; then
    update_config
fi
