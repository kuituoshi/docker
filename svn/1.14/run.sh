#!/bin/sh

#initialize manage environments
: ${SVN_USERNAME:=svnadmin}
: ${SVN_PASSWORD:=svnadmin}
: ${SVN_HOME:=/var/lib/svn}


if [ "`ls -A ${SVN_HOME}`" = "" ];then
     chown www-data:www-data ${SVN_HOME}
     su-exec www-data svnadmin create ${SVN_HOME}/example-project
fi

if [ ! -e ${SVN_HOME}/authz -a ! -e ${SVN_HOME}/passwd ];then
     htpasswd -bc ${SVN_HOME}/passwd ${SVN_USERNAME} ${SVN_PASSWORD}

     cat >${SVN_HOME}/authz <<EOF
[groups]
admin=${SVN_USERNAME}

[/]
@admin = rw
EOF

fi

su-exec www-data /usr/bin/svnserve -d -r ${SVN_HOME}

/usr/local/bin/httpd-foreground
