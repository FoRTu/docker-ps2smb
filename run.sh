docker run --name='PS2smb' \
-p '10445:445/tcp' \
-v '/mnt/user/Otros/OPL/smb.conf':'/etc/samba/smb.conf':'rw' \
-v '/mnt/user/OPL':'/mnt/games':'rw' \
'fortu/test_ps2smb:4.13.8'
