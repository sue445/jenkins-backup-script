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

  def use_absolute_dist_file
    @dest_file = "#{@temp_dir}/archive.tar.gz"
  end

  def use_relative_dist_file
    @dest_file = "archive.tar.gz"
  end

  def use_jenkins_home_without_pinned
    # jenkins_home1 dir does not contain dummy.hpi.pinned and dummy.jpi.pinned
    @jenkins_home = File.join(TEST_DIR, "jenkins_home1")
  end

  def use_jenkins_home_with_pinned
    # jenkins_home2 dir contain dummy.hpi.pinned and dummy.jpi.pinned
    @jenkins_home = File.join(TEST_DIR, "jenkins_home2")
  end

  def expected_files_without_pinned
    %w(
      jenkins-backup/hudson.model.UpdateCenter.xml
      jenkins-backup/jobs/
      jenkins-backup/jobs/example_job/
      jenkins-backup/jobs/example_job/config.xml
      jenkins-backup/nodes/
      jenkins-backup/nodes/slave/
      jenkins-backup/nodes/slave/config.xml
      jenkins-backup/plugins/
      jenkins-backup/plugins/dummy.hpi
      jenkins-backup/plugins/dummy.jpi
      jenkins-backup/secrets/
      jenkins-backup/secrets/master.key
      jenkins-backup/users/
      jenkins-backup/users/sue445/
      jenkins-backup/users/sue445/config.xml
    )
  end

  def expected_files_with_pinned
    %w(
      jenkins-backup/hudson.model.UpdateCenter.xml
      jenkins-backup/jobs/
      jenkins-backup/jobs/example_job/
      jenkins-backup/jobs/example_job/config.xml
      jenkins-backup/nodes/
      jenkins-backup/nodes/slave/
      jenkins-backup/nodes/slave/config.xml
      jenkins-backup/plugins/
      jenkins-backup/plugins/dummy.hpi
      jenkins-backup/plugins/dummy.hpi.pinned
      jenkins-backup/plugins/dummy.jpi
      jenkins-backup/plugins/dummy.jpi.pinned
      jenkins-backup/secrets/
      jenkins-backup/secrets/master.key
      jenkins-backup/users/
      jenkins-backup/users/sue445/
      jenkins-backup/users/sue445/config.xml
    )
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

  sub_test_case "When use absolute path" do
    sub_test_case "When not exists pinned files" do
      test "should create archive file" do
        use_absolute_dist_file
        use_jenkins_home_without_pinned

        assert "jenkins-backup.sh should be success" do
          system("#{SCRIPT_FILE} #{@jenkins_home} #{@dest_file}") == true
        end

        assert { File.exists?(@dest_file) }
        assert { File.size(@dest_file) > 0 }

        actual_files = list_tar_file(@dest_file)
        expected_files_without_pinned.each do |file|
          assert("archive file should include #{file}") do
            actual_files.include?(file)
          end
        end
      end
    end

    sub_test_case "When exists pinned files" do
      test "should create archive file" do
        use_absolute_dist_file
        use_jenkins_home_with_pinned

        assert "jenkins-backup.sh should be success" do
          system("#{SCRIPT_FILE} #{@jenkins_home} #{@dest_file}") == true
        end

        assert { File.exists?(@dest_file) }
        assert { File.size(@dest_file) > 0 }

        actual_files = list_tar_file(@dest_file)
        expected_files_with_pinned.each do |file|
          assert("archive file should include #{file}") do
            actual_files.include?(file)
          end
        end
      end
    end
  end

  sub_test_case "When use relative path" do
    sub_test_case "When not exists pinned files" do
      test "should create archive file" do
        use_relative_dist_file
        use_jenkins_home_without_pinned

        assert "jenkins-backup.sh should be success" do
          system("#{SCRIPT_FILE} #{@jenkins_home} #{@dest_file}") == true
        end

        assert { File.exists?(@dest_file) }
        assert { File.size(@dest_file) > 0 }

        actual_files = list_tar_file(@dest_file)
        expected_files_without_pinned.each do |file|
          assert("archive file should include #{file}") do
            actual_files.include?(file)
          end
        end
      end
    end

    sub_test_case "When exists pinned files" do
      test "should create archive file" do
        use_relative_dist_file
        use_jenkins_home_with_pinned

        assert "jenkins-backup.sh should be success" do
          system("#{SCRIPT_FILE} #{@jenkins_home} #{@dest_file}") == true
        end

        assert { File.exists?(@dest_file) }
        assert { File.size(@dest_file) > 0 }

        actual_files = list_tar_file(@dest_file)
        expected_files_with_pinned.each do |file|
          assert("archive file should include #{file}") do
            actual_files.include?(file)
          end
        end
      end
    end
  end
end
