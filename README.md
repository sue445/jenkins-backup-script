# Jenkins backup script

[![wercker status](https://app.wercker.com/status/17ca82b64d66756a966db78695ad4c8f/m/master "wercker status")](https://app.wercker.com/project/bykey/17ca82b64d66756a966db78695ad4c8f)

Archive Jenkins settings and plugins

* `$JENKINS_HOME/*.xml`
* `$JENKINS_HOME/jobs/*/*.xml`
* `$JENKINS_HOME/nodes/*`
* `$JENKINS_HOME/plugins/*.jpi`
* `$JENKINS_HOME/secrets/*`
* `$JENKINS_HOME/users/*`

# Usage
```sh
./jenkins-backup.sh /path/to/jenkins_home archive.tar.gz

# add timestamp suffix
./jenkins-backup.sh /path/to/jenkins_home backup_`date +"%Y%m%d%H%M%S"`.tar.gz
```

# run with Jenkins Job
## 1. install Exclusive Execution Plugin
https://wiki.jenkins-ci.org/display/JENKINS/Exclusive+Execution+Plugin

## 2. New Job
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131208/20131208001948.png)

## 3. Configure
### Source Code Management > Repository URL
```
https://github.com/sue445/jenkins-backup-script.git
```

* **Recommended** : specify Branch Specifier with latest release tag
* Check https://github.com/sue445/jenkins-backup-script/releases

![0.0.3](http://f.st-hatena.com/images/fotolife/s/sue445/20140331/20140331010645.png)

### Build Triggers > Build periodically
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110180825.png)

### Build Environment > Set exclusive Execution
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110194540.png)

### Build > Execute shell
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110193935.png)

ex.

```bash
./jenkins-backup.sh $JENKINS_HOME /path/to/backup_`date +"%Y%m%d%H%M%S"`.tar.gz
```

# Operability confirmed
* Debian jessie
* CentOS 7.0

## Testing
requirements [Vagrant](https://www.vagrantup.com/)

```sh
gem install bundler -v 1.10.6
bundle install

vagrant up centos70
bundle exec rake itamae:centos70
bundle exec rake spec:centos70
```

# Tips
## rotate backup files
```bash
# keep backup with latest 30 days
find /path/to/backup_* -mtime +30 -delete
```

## Restore commands
example

```bash
sudo /etc/init.d/jenkins stop
cd /path/to/backup_dir
tar xzvf backup.tar.gz
sudo cp -R jenkins-backup/* /path/to/jenkins/
sudo chown jenkins:jenkins -R /path/to/jenkins/
sudo /etc/init.d/jenkins start
```

# Changelog
[CHANGELOG.md](CHANGELOG.md)
