FROM alpine:latest

RUN apk add git apache2 openssh cgit py3-markdown py3-pygments

COPY sshd_config /sshd_config
COPY httpd.conf /etc/apache2/httpd.conf
COPY cgitrc /etc/cgitrc
COPY entrypoint.sh /entrypoint.sh
COPY update-mirrors.sh /update-mirrors.sh

# Create directory for cgit config
RUN mkdir -p /etc/cgit.d

# Add git user with home directory ready for SSH config and a random password.
# The password won't actually be used for anything, but needs to be set for
# the system to consider the account valid.
RUN adduser -Dh /git -s /usr/bin/git-shell git && \
    echo "git:\$(date +%s | sha256sum | base64 | head -c 64 ; echo)" | chpasswd

# Add the cronjob to update the git mirrors once per hour
RUN echo -e "0 * * * * /update-mirrors.sh\n" | crontab -u git -

RUN mkdir -p /pub/git && \
    chown -R git:git /pub/git

# Used to allow customization of cgit
VOLUME /etc/cgit.d
# Used to persist host SSH keys and configuration
VOLUME /etc/ssh
# Used to persist public SSH keys
VOLUME /git
# Used to persist git repositories
VOLUME /pub/git

EXPOSE 22
EXPOSE 80

CMD /entrypoint.sh

