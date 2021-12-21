#!/bin/sh
## 99-disable_wan_failover.sh
## A script to disable WAN Failover for dual-wan setups that use policy-based routing from 98-vlan_to_wan2.sh
## Prevents vlan-to-wan2 traffic from going out wan1 and all other traffic from going out wan2


wan1_failover_monitor() {
        (while :; do
                    ip rule show | grep "from all lookup 202" &> /dev/null &&
                        (ip rule del pref 32766; ip rule add pref 32766 from all lookup 201)
                sleep 1
        done) &
}
wan1_failover_monitor

wan2_failover_monitor() {
        (while :; do
                    ip route show table 202 | grep "default" &> /dev/null ||
                        (ip route add blackhole 0.0.0.0/0 table 202)
                sleep 1
        done) &
}
wan2_failover_monitor
