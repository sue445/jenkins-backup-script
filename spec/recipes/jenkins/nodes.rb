%w(
  nodes/slave
).each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

%w(
  nodes/slave/config.xml
).each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end
