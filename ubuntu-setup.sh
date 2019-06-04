#!/bin/bash
apt update && apt install build-essential -y && apt install apache2 -y && apt install virtualenv -y && apt install libapache2-mod-wsgi python-dev -y && apt -y install nano
cd /var/www
mkdir log
a2enmod wsgi
cd /var/www
mkdir -p flask_app/flask_app
cd flask_app/flask_app
virtualenv venv --python=/usr/bin/python
# Cannot run this unless the requirements.txt file is already in the server. TODO
# source venv/bin/activate
# pip install -U -r requirements.txt
# deactivate
cat <<EOF >/var/www/flask_app/flask_app.wsgi
#!/usr/bin/python
import sys
import logging
python_home = '/var/www/flask_app/flask_app/venv'
activate_this = python_home + '/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/flask_app/")

from flask_app import app as application
application.secret_key = 'secret123'
EOF
chown -R root:www-data /var/www
chmod -R 775 /var/www
cat <<EOF >/etc/apache2/sites-enabled/flask_app.conf
<VirtualHost *:80>
		ServerName <ENTER.SERVER.DOMAIN>
		ServerAdmin admin@mywebsite.com
		WSGIDaemonProcess flask_app threads=15 python-home=/var/www/flask_app/flask_app/venv
		WSGIScriptAlias / /var/www/flask_app/flask_app.wsgi
		# Add this if you are using any type of authorization header
		WSGIPassAuthorization On

		<Directory /var/www/flask_app/flask_app/>
			Require all granted
		</Directory>
		Alias /static /var/www/flask_app/flask_app/static
		<Directory /var/www/flask_app/flask_app/static/>
			Require all granted
		</Directory>
		ErrorLog /var/www/log/error.log
		LogLevel warn
		CustomLog /var/www/log/access.log combined
</VirtualHost>
EOF
a2enmod rewrite
service apache2 restart