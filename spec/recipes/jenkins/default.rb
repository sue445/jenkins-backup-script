# Setup jenkins configuration files

group "jenkins" do
  gid 123
end

user "jenkins" do
  uid 1234
  gid 123
  create_home false
end

include_recipe "./jobs"
include_recipe "./nodes"
include_recipe "./plugins"
include_recipe "./secrets"
include_recipe "./users"

%w(
  hudson.model.UpdateCenter.xml
).each do |file|
  remote_file "#{node[:jenkins_home]}/#{file}" do
    mode  "644"
    owner "jenkins"
    group "jenkins"
  end
end
