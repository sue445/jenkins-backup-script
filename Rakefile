require 'rake/testtask'

desc 'Run test_unit based test'
Rake::TestTask.new do |t|
  # To run test for only one file (or file path pattern)
  #  $ bundle exec rake test TEST=test/test_specified_path.rb
  t.libs << "test"
  t.test_files = Dir["test/**/test_*.rb"]
  t.verbose = true
end

def system!(command)
  result = system(command)
  raise "FAILED: #{command}" unless result
end

desc "release"
task :release do
  new_version = `cat VERSION`.strip
  system! "git tag -a #{new_version} -m 'release #{new_version}'"
  system! "git push origin master"
  system! "git push origin --tags"
end
