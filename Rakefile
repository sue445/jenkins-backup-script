require "rspec/core/rake_task"

task :spec => "spec:all"

HOSTS = %w(centos70 debian8)

namespace :spec do
  task :all => HOSTS

  HOSTS.each do |host|
    RSpec::Core::RakeTask.new(host.to_sym) do |t|
      puts "Running tests to #{host} ..."
      ENV["TARGET_HOST"] = host
      t.pattern = "spec/*_spec.rb"
    end
  end
end

namespace :itamae do
  task :all => HOSTS

  HOSTS.each do |host|
    desc "Running itamae to #{host}"
    task host do
      sh "bundle exec itamae ssh --host=#{host} --vagrant --node-yaml=spec/node.yml spec/recipes/bootstrap.rb"
    end
  end
end

desc "release"
task :release do
  new_version = `cat VERSION`.strip
  sh "git tag -a #{new_version} -m 'release #{new_version}'"
  sh "git push origin master"
  sh "git push origin --tags"
end
