#!/bin/bash
#password reset for sysad usrer and read out the users list in specific grous
#Export users in sysad groups
FILE="/home/scripts/sysaiduser"
cut -d: -f1,4 /etc/passwd | grep $(getent group sysad | cut -d: -f3) | cut -d: -f1 > ${FILE}
#owriting the sysaiduser file
cat "${FILE}"
#define password for user as current date like 05/08/18Tue
PASSWORD=$(date +%D%a)
#reset password for listed users
for ID in `cat sysaiduser`
do
#unlock the listed users
sudo passwd -u ${ID}
echo -e "$PASSWORD\n$PASSWORD"| sudo passwd "${ID}"
# Force password change on first login.
sudo passwd -e ${ID}
done
