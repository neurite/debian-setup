### Samba Steps

1. `sudo apt-get install samba` and make sure the following installed:
    * `libcups2`: Common Unix printing system replacing lpd
    * `samba-common`
    * Notable events during the installation
        * Created `/etc/samba/smb.conf`
        * Added user group `sambashare`
        * Started daemons `nmbd` and `smbd`
    * At this point, should be able to see the server remotely at `smb://[Samba host ip or host name]`
2. Use the standard user group `users` for Samba access
    * `sudo usermod -a -G users <usr>` to add <usr> to the `users` group
    * `id <usr>` to verify
    * `sudo smbpasswd -a <usr>` to add the user to the Samba database
    * At this point, should be able to connect to the server remotely at `smb://[Samba host ip or host name]`
3. Create a Samba share folder
    * `sudo mkdir /samba/share`
    * `sudo chown <usr>:users /samba/share`
    * `sudo chmod ug+rwx,o-rwx /samba/share`
4. `sudo vim /etc/samba/smb.conf`
    * Set `security = user` to require a Unix account on the Samba server
    * At the end, add the following section
    ```
    [samba]
    comment = Samba shared folder for all users
    path = /samba/share
    valid users = @users
    force group = users
    create mask = 0660
    directory mask = 0771
    writable = yes
    ```
    * Note `[samba]` specifies the share name
5. `sudo /etc/init.d/samba restart`
6. Can connect using `smb://[HostName]/[SambaShareName]`

To learn more, check out the book [Using Samba](https://www.samba.org/samba/docs/using_samba/toc.html).
