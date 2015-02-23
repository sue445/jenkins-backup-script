require 'test/unit'
require 'test/unit/around'
require 'tmpdir'

class TestJenkinsBackup < Test::Unit::TestCase
  TEST_DIR     = __dir__
  SCRIPT_FILE  = "./jenkins-backup.sh"

  # get file list in tar file
  def list_tar_file(tar_file)
    `tar tfz #{tar_file}`.split(/[\r\n]+/)
  end

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

      actual_files = list_tar_file(dist_file)
      expected_files = %w(
        jenkins-backup/hudson.model.UpdateCenter.xml
        jenkins-backup/jobs/
        jenkins-backup/jobs/example_job/
        jenkins-backup/jobs/example_job/config.xml
        jenkins-backup/plugins/
        jenkins-backup/plugins/dummy.hpi
        jenkins-backup/plugins/dummy.jpi
        jenkins-backup/users/
        jenkins-backup/users/sue445/
        jenkins-backup/users/sue445/config.xml
      )
      expected_files.each do |file|
        assert("archive file should include #{file}") do
          actual_files.include?(file)
        end
      end
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

      actual_files = list_tar_file(dist_file)
      expected_files = %w(
        jenkins-backup/hudson.model.UpdateCenter.xml
        jenkins-backup/jobs/
        jenkins-backup/jobs/example_job/
        jenkins-backup/jobs/example_job/config.xml
        jenkins-backup/plugins/
        jenkins-backup/plugins/dummy.hpi
        jenkins-backup/plugins/dummy.hpi.pinned
        jenkins-backup/plugins/dummy.jpi
        jenkins-backup/plugins/dummy.jpi.pinned
        jenkins-backup/users/
        jenkins-backup/users/sue445/
        jenkins-backup/users/sue445/config.xml
      )
      expected_files.each do |file|
        assert("archive file should include #{file}") do
          actual_files.include?(file)
        end
      end
    end
  end
end
