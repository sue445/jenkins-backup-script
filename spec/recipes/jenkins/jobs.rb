[
  "jobs/example_job",
  "jobs/space contain job",
].each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

[
  "jobs/example_job/config.xml",
  "jobs/example_job/nextBuildNumber",
  "jobs/space contain job/config.xml",
].each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end

# for. CloudBees Folder plugin
[
  "jobs/example_folder/jobs/example_job_in_folder",
  "jobs/example_folder/jobs/space contain job in folder",
].each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

[
  "jobs/example_folder/config.xml",
  "jobs/example_folder/jobs/example_job_in_folder/config.xml",
  "jobs/example_folder/jobs/space contain job in folder/config.xml",
].each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end
