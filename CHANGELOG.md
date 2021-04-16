# Changelog
## Unreleased
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.10...master)

## 0.1.10
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.9...0.1.10)

* Added fix for storing nextBuildNumber
  * https://github.com/sue445/jenkins-backup-script/pull/217

## 0.1.9
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.8...0.1.9)

* Fix. Script fails when a folder exists with no jobs in it
  * https://github.com/sue445/jenkins-backup-script/issues/50
  * https://github.com/sue445/jenkins-backup-script/pull/52

## 0.1.8
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.7...0.1.8)

* Fix making directories on Windows with busybox-w32
  * https://github.com/sue445/jenkins-backup-script/pull/45

## 0.1.7
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.6...0.1.7)

* Fix: Backup script was failing when projects have folders with spaces
  * https://github.com/sue445/jenkins-backup-script/pull/44

## 0.1.6
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.5...0.1.6)

* Fix handling jobs with whitespace in name
  * https://github.com/sue445/jenkins-backup-script/pull/40

## 0.1.5
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.4...0.1.5)

* Add support for CloudBees Folder plugin
  * https://github.com/sue445/jenkins-backup-script/pull/39

## 0.1.4
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.3...0.1.4)

* Fix error when nodes dir is empty
  * https://github.com/sue445/jenkins-backup-script/issues/37
  * https://github.com/sue445/jenkins-backup-script/pull/38

## 0.1.3
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.2...0.1.3)

* added nodes to archive
  * https://github.com/sue445/jenkins-backup-script/pull/34

## 0.1.2
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.1...0.1.2)

* support relative path for `DEST_FILE` (thx @namikawa)
  * https://github.com/sue445/jenkins-backup-script/pull/31
  * https://github.com/sue445/jenkins-backup-script/pull/32

## 0.1.1
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.1.0...0.1.1)

* fix jenkins backup if some directories don't exist
  * https://github.com/sue445/jenkins-backup-script/pull/27

## 0.1.0
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.9...0.1.0)

* Support `$JENKINS_HOME/secrets` dir
  * https://github.com/sue445/jenkins-backup-script/pull/25

## 0.0.9
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.8...0.0.9)

* mod xargs placeholder (thx @kuronekomichaelg)
  * https://github.com/sue445/jenkins-backup-script/pull/20

## 0.0.8
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.7...0.0.8)

* Fix. too many arguments, cp failed source file does not exist
  * https://github.com/sue445/jenkins-backup-script/pull/18

## 0.0.7
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.6...0.0.7)

* Get all plugins, cleaner tar file (thx @maafy6)
  * https://github.com/sue445/jenkins-backup-script/pull/14

## 0.0.6
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.5...0.0.6)

* Minor shell cleanups (thx @SEJeff)
  * https://github.com/sue445/jenkins-backup-script/pull/9
* Escape bug fix and few tweaks (thx @JackLeo)
  * https://github.com/sue445/jenkins-backup-script/pull/11

## 0.0.5
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.4...0.0.5)

* backup `$JENKINS_HOME/users`
  * https://github.com/sue445/jenkins-backup-script/pull/7

## 0.0.4
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.3...0.0.4)

* copy failed when job name contains space (thx @rubenjgarcia)
  * https://github.com/sue445/jenkins-backup-script/pull/4

## 0.0.3
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.2...0.0.3)

* There are cases where the directory is not created

## 0.0.2
[full changelog](https://github.com/sue445/jenkins-backup-script/compare/0.0.1...0.0.2)

* remove archive file if exists

## 0.0.1
* first release
