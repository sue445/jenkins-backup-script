require 'test/unit'
require 'test/unit/around'
require 'tmpdir'

class TestJenkinsBackup < Test::Unit::TestCase
  TEST_DIR     = __dir__
  SCRIPT_FILE  = "./jenkins-backup.sh"

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

  sub_test_case "When not exists pinned files" do
    setup do
      # jenkins_home1 dir contain dummy.hpi.pinned and dummy.jpi.pinned
      @jenkins_home = File.join(TEST_DIR, "jenkins_home1")
    end

    test "should create archive file" do
      dist_file = "#{@temp_dir}/archive.tar.gz"

      assert "jenkins-backup.sh should be success" do
        system("#{SCRIPT_FILE} #{@jenkins_home} #{dist_file}") == true
      end

      assert { File.exists?(dist_file) }
      assert { File.size(dist_file) > 0 }
    end
  end

  sub_test_case "When exists pinned files" do
    setup do
      # jenkins_home2 dir contain dummy.hpi.pinned and dummy.jpi.pinned
      @jenkins_home = File.join(TEST_DIR, "jenkins_home2")
    end

    test "should create archive file" do
      dist_file = "#{@temp_dir}/archive.tar.gz"

      assert "jenkins-backup.sh should be success" do
        system("#{SCRIPT_FILE} #{@jenkins_home} #{dist_file}") == true
      end

      assert { File.exists?(dist_file) }
      assert { File.size(dist_file) > 0 }
    end
  end
end
