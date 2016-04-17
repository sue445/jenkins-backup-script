%w(
  secrets
).each do |dir|
  directory "#{node[:jenkins_home]}/#{dir}" do
    mode  "755"
    owner "jenkins"
    group "jenkins"
  end
end

%w(
  secrets/master.key
).each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end
