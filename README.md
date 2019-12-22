# cgit Dockerized

This is a simple dockerized version of cgit, which includes support for SSH and HTTP access. SSH access is restricted to key-based authentication only, and root logins aren't permitted.

## Volumes

- /etc/cgit.d
  - This directory should only contain a single file: `cgitrc`, which should contain any customization for the cgit instance according to the [cgitrc spec](https://git.zx2c4.com/cgit/tree/cgitrc.5.txt).
- /etc/ssh
  - This directory should be owned by `root`, and is used to persist the host SSH keys, along with the SSH configuration changes.
- /git/.ssh
  - This directory should have 700 permissions and any files within it should have 600 permissions. The idea is to use it for adding an `authorized_keys` file
- /pub/git
  - This is where the git repositories will be stored. Please note that all folders and files here should be owned by the `git` user, UID 1000.

