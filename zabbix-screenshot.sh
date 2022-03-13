#!/bin/bash

datetime=$(date +%s); path="/tmp/${datetime}_html.png"
/usr/local/bin/wkhtmltoimage --width 1000 --height 1000 --quality 50 --cookie-jar "/tmp/zc_${datetime}" --post "name" "$NAME" --post "password" "$PASS" --post "enter" "Sign+in" -q "http://$ZBXIP/zabbix/index.php?login=1" "/tmp/log_html.png"
/usr/local/bin/wkhtmltoimage --width 1000 --height 1000 --quality 50 --cookie-jar "/tmp/zc_${datetime}" -q "http://$ZBXIP/zabbix/zabbix.php?action=problem.view&filter_show=3&filter_application=&filter_name=&filter_inventory%5B0%5D%5Bfield%5D=type&filter_inventory%5B0%5D%5Bvalue%5D=&filter_evaltype=0&filter_tags%5B0%5D%5Btag%5D=&filter_tags%5B0%5D%5Boperator%5D=0&filter_tags%5B0%5D%5Bvalue%5D=&filter_show_tags=3&filter_tag_name_format=0&filter_tag_priority=&filter_show_opdata=0&filter_set=1" ${path}
curl -sS -F file=@${path} -F "initial_comment=Zabbix-Dashboard" -F channels=GHX93A848 -H "Authorization: Bearer xoxb-161asdasdasdas-r6Iz6Nl6zxcxzxczxc" https://slack.com/api/files.upload
rm -f /tmp/zc_${datetime}; rm -f /tmp/*html.png
