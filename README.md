# vercomp

[![GitHub tag](https://img.shields.io/github/tag/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/tags)

[![Contributors](https://img.shields.io/github/contributors/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/graphs/contributors)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/eendroroy/vercomp/master.svg)](https://github.com/eendroroy/vercomp)
[![license](https://img.shields.io/github/license/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/pulls)
[![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/eendroroy/vercomp.svg)](https://github.com/eendroroy/vercomp/pulls?q=is%3Apr+is%3Aclosed)

## Installing by compiling source code

**Prerequisit**

`Ubuntu`:

```bash
# add postgres repo
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# install postgres
apt-get -y update
apt-get -y install postgresql postgresql-contrib libpq-dev postgresql-server-dev-all

# install build requirements
apt-get -y install make build-essential
```

`RHEL`:

```bash
yum -y install openssl-devel

# add postgres repo
rpm -Uvh https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

# install postgres
yum -y install postgresql10-server postgresql10-libs postgresql10-devel postgresql10-contrib

# initialize databasse
/usr/pgsql-10/bin/postgresql-10-setup initdb
```

To build it, just do this:

```bash
make
make install
```

If you encounter an error such as:

```
make: pg_config: Command not found
```

Be sure that you have pg_config installed and in your path. If you used 
a package management system such as RPM to install PostgreSQL, be sure 
that the -devel package is also installed. If necessary tell the build 
process where to find it. Edit Makefile, and change PG_CONFIG variable:

```bash
PG_CONFIG=/path/to/pg_config
```

followed by the

```bash
make
make install
```

`pg_config` is usually under `/usr/pgsql-10/bin/pg_config` on 
RHEL/CentOS/Fedora. Replace 10 with your major PostgreSQL version.

Alternatively the following will work too:

```bash
PATH="/usr/pgsql-10/bin:$PATH" make
sudo PATH="/usr/pgsql-10/bin:$PATH" make install
PATH="/usr/pgsql-10/bin:$PATH" make installcheck
```

## Using the module

To enable this module, add '`$libdir/vercomp`' to 
shared_preload_libraries in postgresql.conf, then restart the server.

## Testing

Using vagrant:

```bash
vagrant up
vagrant provision --provision-with install
```

## More information

For more details, please read the manual of the original module:

[https://www.postgresql.org/docs/current/static/passwordcheck.html](https://www.postgresql.org/docs/current/static/passwordcheck.html)

## Contributing

Bug reports and pull requests are welcome on GitHub at [vercomp](https://github.com/eendroroy/vercomp) repository.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Author

* **indrajit** - *Owner* - [eendroroy](https://github.com/eendroroy)

## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
