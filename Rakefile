desc "release"
task :release do
  new_version = File.read("#{__dir__}/VERSION").strip
  sh "git tag -a #{new_version} -m 'release #{new_version}'"
  sh "git push origin master"
  sh "git push origin --tags"
end
