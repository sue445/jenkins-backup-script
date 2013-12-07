# Jenkins backup script

Archive Jenkins settings and plugins

* $JENKINS_HOME/*.xml
* $JENKINS_HOME/plugins/*.jpi
* $JENKINS_HOME/jobs/*/*.xml

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
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110180225.png)

## 3. Configure
### Source Code Management > Repository URL
```
git@github.com:sue445/jenkins-backup.git
```

![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110180608.png)

### Build Triggers > Build periodically
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110180825.png)

### Build Environment > Set exclusive execution
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110194540.png)

### Build > Execute shell
![img](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20131110/20131110193935.png)

