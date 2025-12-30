require "jetski"

require "minitest/autorun"
require "pry"
require "fileutils"


# Test generation of new jetski apps

class TestJetski < Minitest::Test
  def setup
    FileUtils.rm_rf("test-app")
    system("bundle exec jetski new test-app")
  end

  def teardown
    FileUtils.rm_rf("test-app")
  end

  def test_that_creating_an_app_works
    assert File.exist?("test-app/app")
  end

  def test_that_creating_a_model_works
    system("cd test-app && bundle exec jetski generate model post title body:text")
    assert File.exist?("test-app/app/models/post.rb")
    assert File.exist?("test-app/test.db")
  end
end