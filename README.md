# docker-git-webserver

Simple docker container that clones a Git repository and serves it with an Nginx webserver, optionally with basic auth.

## Configuration

The following environment variables can be passed to the container (see `run.sh` how to do that):

- `GIT_REPO` (Required)
    - Must point to an existing Git repo, which will be served
- `GIT_DEPLOY_KEY` (Required for private git repo)
    - Valid OpenSSH key in PEM format and converted to base64 
        - This key will be base64 decoded, and then copied to `~/.ssh/id_rsa`, and removed after cloning of the repo
- `NGINX_HTPASSWD_BASE64`
    - The content of a *htpasswd(1)* file converted to base64.

### Prepare an SSH deploy key (Optional)

Generate a new ssh key (do not enter a passphrase), example to create a key in `/tmp/new-key`:

```
$ ssh-keygen -t rsa -f /tmp/new-key
```

To load this key as env var, convert to to base64 (so we don't have to worry about newlines):

```
$ cat /tmp/new-key | base64 -w0            # Linux
$ cat /tmp/new-key | base64 | tr -d '\n'   # OSX
```

Pass the output of this command to the `GIT_DEPLOY_KEY` variable, using the `-e` option of `docker run`. See `run.sh` for an example.

Add `/tmp/new-key.pub` as a deployment key to your repository.

### Create a basic auth config (Optional)

With the following command, one can create a file named passwords.bin, with a password for a user named *admin*:

```
$ htpasswd -c passwords.bin admin
```

To load this file as env var, convert it to base64:
```
$ cat passwords.bin | base64 -w0           # Linux
$ cat passwords.bin | base64  | tr -d '\n' # OSX
```

Pass the output of this command to the `NGINX_HTPASSWD_BASE64` variable, using the `-e` option of `docker run`. See `run.sh` for an example.


<!-- vim: set ts=4: sw=4: -->
