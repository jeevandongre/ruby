name             'ruby'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures ruby'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'


depends "database","2.3.1"
depends "mysql","5.6.1"
depends "mysql-chef_gem","0.0.5"
