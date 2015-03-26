# Puppet RDS

##Overview

The RDS module manages the Amazon Relational Database Service (RDS) resources.

##Description

This is a simple module to manaage RDS instances in AWS. It's planned to eventually get merged into Puppetlabs-AWS, but for now I kept it as a seperate module.

The PR for it is here: https://github.com/puppetlabs/puppetlabs-aws/pull/69

##Setup

###Requirements

* Puppet 3.4 or greater
* Ruby 1.9
* Amazon AWS Ruby SDK (available as a gem)
* Retries gem

###Installing the aws module

1. Install the retries gem and the Amazon AWS Ruby SDK gem.

    * If you're using open source Puppet, the SDK gem should be installed into the same Ruby used by Puppet. Install the gems with these commands:

      `gem install aws-sdk-core`

      `gem install retries`

  * If you're running Puppet Enterprise, install both the gems with this command:

      `/opt/puppet/bin/gem install aws-sdk-core retries`

  This allows the gems to be used by the Puppet Enterprise Ruby.

  * If you're running [Puppet Server](https://github.com/puppetlabs/puppet-server), you need to make both gems available to JRuby with:

      `/opt/puppet/bin/puppetserver gem install aws-sdk-core retries`

  Once the gems are installed, restart Puppet Server.

2. Set these environment variables for your AWS access credentials:

  ~~~
  export AWS_ACCESS_KEY_ID=your_access_key_id
  export AWS_SECRET_ACCESS_KEY=your_secret_access_key
  ~~~

  Alternatively, you can place the credentials in a file at
`~/.aws/credentials` based on the following template:

  ~~~
 [default]
  aws_access_key_id = your_access_key_id
  aws_secret_access_key = your_secret_access_key
  ~~~

3. Finally, install the module with:

~~~
puppet module install petems-rds
~~~

#### A note on regions

By default the module looks through all regions in AWS when
determining if something is available. This can be a little slow. If you
know what you're doing you can speed things up by targeting a single
region using an environment variable.

~~~
export AWS_REGION=eu-west-1
~~~


##Getting Started with RDS

The aws module allows you to manage RDS instances using the Puppet DSL. To stand up a Postgres instance with AWS, use the `rds_instance` type:

~~~
rds_instance { 'aws-postgres':
  ensure              => 'present',
  allocated_storage   => '5',
  db_instance_class   => 'db.m3.medium',
  db_name             => 'postgresql',
  engine              => 'postgres',
  license_model       => 'postgresql-license',
  db_security_groups  => 'rds-postgres-db_securitygroup',
  master_username     => 'root',
  master_user_password=> 'pullZstringz345',
  multi_az            => 'false',
  region              => 'us-west-2',
  skip_final_snapshot => 'true',
  storage_type        => 'gp2',
}
~~~

**Set up a DB security group:**

~~~
rds_db_securitygroup { 'rds-postgres-db_securitygroup':
  ensure                        => 'present',
  region                        => 'us-west-2',
  db_security_group_description => 'An RDS Security group to allow Postgres',
}
~~~

Unfortunatly the AWS API doesn't handle adding EC2 instances to DB Security groups. Check out the [examples](examples/) for a basic example of how to get it working.

##Limitations

This module requires Ruby 1.9 or later and is only tested on Puppet
versions 3.4 and later.

Eventually this module will be merged into Puppetlabs-AWS and this module will be deprecated.