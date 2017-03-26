name 'elk5'
maintainer 'Gm Murugan'
maintainer_email 'gmmurugan@gmail.com'
license 'all_rights'
description 'Installs/Configures elk5'
long_description 'Installs/Configures elk5'
version '0.1.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/elk5/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/elk5' if respond_to?(:source_url)

depends 'apt', '6.0.1'
depends 'java', '1.47.0'
depends 'elasticsearch', '3.0.4'
depends 'chef_nginx'
depends 'simple-logstash', '0.5.1'
depends 'kibana5', '0.2.2'
