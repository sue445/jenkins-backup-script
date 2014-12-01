require 'rake/testtask'

desc 'Run test_unit based test'
Rake::TestTask.new do |t|
  # To run test for only one file (or file path pattern)
  #  $ bundle exec rake test TEST=test/test_specified_path.rb
  t.libs << "test"
  t.test_files = Dir["test/**/test_*.rb"]
  t.verbose = true
end
