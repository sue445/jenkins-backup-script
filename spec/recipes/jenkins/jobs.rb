%w(
  jobs/example_job
).each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

%w(
  jobs/example_job/config.xml
).each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end

# for. CloudBees Folder plugin
%w(
  jobs/example_folder/jobs/example_job_in_folder
).each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

%w(
  jobs/example_folder/config.xml
  jobs/example_folder/jobs/example_job_in_folder/config.xml
).each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end
