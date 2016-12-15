#!/bin/bash
echo -e "BASE ${LDAP_BASE}\nURI ${LDAP_SERVER}" > /etc/nslcd.conf

for item in passwd shadow group; do
    sed -i "s/^${item}:.*/${item}: files ldap/g" /etc/nsswitch.conf
done

/usr/sbin/nslcd
/usr/sbin/rsyslogd
/usr/sbin/sshd

tail -F /var/log/auth.log
