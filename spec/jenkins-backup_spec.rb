ARCHIVED_FILES = [
  "jenkins-backup/hudson.model.UpdateCenter.xml",
  "jenkins-backup/jobs/",
  "jenkins-backup/jobs/example_job/",
  "jenkins-backup/jobs/example_job/config.xml",
  "jenkins-backup/jobs/example_job/nextBuildNumber",
  "jenkins-backup/jobs/space contain job/",
  "jenkins-backup/jobs/space contain job/config.xml",
  "jenkins-backup/jobs/example_folder/",
  "jenkins-backup/jobs/example_folder/config.xml",
  "jenkins-backup/jobs/example_folder/jobs/example_job_in_folder/",
  "jenkins-backup/jobs/example_folder/jobs/example_job_in_folder/config.xml",
  "jenkins-backup/jobs/example_folder/jobs/space contain job in folder/",
  "jenkins-backup/jobs/example_folder/jobs/space contain job in folder/config.xml",
  "jenkins-backup/nodes/",
  "jenkins-backup/nodes/slave/",
  "jenkins-backup/nodes/slave/config.xml",
  "jenkins-backup/plugins/",
  "jenkins-backup/plugins/dummy.hpi",
  "jenkins-backup/plugins/dummy.hpi.pinned",
  "jenkins-backup/plugins/dummy.jpi",
  "jenkins-backup/plugins/dummy.jpi.pinned",
  "jenkins-backup/secrets/",
  "jenkins-backup/secrets/master.key",
  "jenkins-backup/users/",
  "jenkins-backup/users/sue445/",
  "jenkins-backup/users/sue445/config.xml",
]

describe tar_file("/tmp/relative_archive.tar.gz") do
  ARCHIVED_FILES.each do |file|
    it { should include file }
  end
end

describe tar_file("/tmp/absolute_archive.tar.gz") do
  ARCHIVED_FILES.each do |file|
    it { should include file }
  end
end
