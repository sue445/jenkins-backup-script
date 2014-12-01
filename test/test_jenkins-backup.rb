require 'test/unit'
require 'test/unit/around'
require 'tmpdir'

class TestJenkinsBackup < Test::Unit::TestCase
  TEST_DIR     = __dir__
  SCRIPT_FILE  = "./jenkins-backup.sh"
  JENKINS_HOME = File.join(TEST_DIR, "jenkins_home")

  around do |test|
    Dir.mktmpdir("test-") do |temp_dir|
      @temp_dir = temp_dir

      # copy jenkins-backup.sh to temp_dir because this use ./tmp of current directory
      FileUtils.cp(File.join(TEST_DIR, "..", SCRIPT_FILE), @temp_dir)

      Dir.chdir(@temp_dir) do
        test.run
      end
    end
  end

  test "should create archive file" do
    dist_file = "#{@temp_dir}/archive.tar.gz"

    assert "jenkins-backup.sh should be success" do
      system("#{SCRIPT_FILE} #{JENKINS_HOME} #{dist_file}") == true
    end

    assert { File.exists?(dist_file) }
    assert { File.size(dist_file) > 0 }
  end
end
