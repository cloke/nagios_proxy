Server configuration:

  - nginx
  - rbenv
  - ruby 2.1.1
  - /home/rails (the default from digi ocean)

NDO Utils - http://hyper-choi.blogspot.com/2012/07/monitoring-setting-up-nagois-ndoutils.html
  - sudo wget http://softlayer-dal.dl.sourceforge.net/project/nagios/ndoutils-2.x/ndoutils-2.0.0/ndoutils-2.0.0.tar.gz
  - sudo tar xvfz ndoutils-2.0.0.tar.gz
  - cd ndoutils-2.0.0
  - sudo ./configure --with-mysql-lib=/usr/lib64/mysql --prefix=/usr/local/ndoutils-2.0.0 --with-ndo2db-user=nagios --with-ndo2db-group=nagios
  - sudo make
  - sudo make install
  - sudo mkdir ./var
  - copy config files
  - sudo chown nagios:nagios /usr/local/nagios/etc/ndo*.cfg
  - deal with broker module... make them consistent in nagios.cfg
    broker_module=/usr/local/ndoutils-2.0.0/ndomod.o config_file=/usr/local/nagios/etc/ndomod.cfg
  - sudo cp /usr/local/ndoutils-2.0.0/daemon-init /etc/init.d/ndo2db

/usr/local/nagios/var/rw/nagios.cmd fix permissions after restart of nag

On-boarding
  - When a user installs the VM we will need to add a unique key to the config. The unique key will act as the instance_id in the db. All queries would be filtered on the instance_id. 