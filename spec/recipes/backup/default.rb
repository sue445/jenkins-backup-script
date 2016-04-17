remote_file "/tmp/jenkins-backup.sh" do
  source "../../../jenkins-backup.sh"
  mode  "755"
  owner "jenkins"
  group "jenkins"
end

# Run backup script
execute "./jenkins-backup.sh #{node[:jenkins_home]} relative_archive.tar.gz" do
  cwd "/tmp"
end

execute "./jenkins-backup.sh #{node[:jenkins_home]} /tmp/absolute_archive.tar.gz" do
  cwd "/tmp"
end
