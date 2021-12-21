#!/bin/sh
## 98-vlan_to_wan2.sh
## A script to add policy-based routing to send vlan2 to wan2 to the UDM-Pro
## Includes monitoring to re-add rules in the event of config changes
## Use in conjunction with 99-disable_wan_failover.sh


vlan2_to_wan_monitor() {
        (while :; do
                    ip rule show | grep 32400 &> /dev/null ||
                        (ip rule add pref 32400 from all iif br2 lookup 202)
                sleep 1
        done) &
}

vlan2_to_wan_monitor

## Uncomment below to add an additional vlan to route out wan2

vlan3_to_wan_monitor() {
        (while :; do
                    ip rule show | grep 32401 &> /dev/null ||
                        (ip rule add pref 32401 from all iif br3 lookup 202)
                sleep 1
        done) &
}

vlan3_to_wan_monitor
