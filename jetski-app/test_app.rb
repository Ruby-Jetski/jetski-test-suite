require "bundler/setup"
require "jetski"

require "minitest/autorun"
require "pry"
require "fileutils"


# Test on a real jetski app

class TestApp < Minitest::Test
  def setup
    system("bundle exec jetski generate model post title body:text")
    Jetski::Autoloader.call # require all models ( Post )
  end

  def teardown
    FileUtils.rm("test.db")
    FileUtils.rm_rf("app/models")
  end

  def test_that_model_was_created
    assert File.exist?("app/models/post.rb")
    assert File.exist?("test.db")
  end

  # TODO: Multiple tests running not working now
  # def test_that_creating_model_works
  #   @post = Post.create(title: "This is a post", body: "lorum ipsum gipsum")
  #   assert @post.id

  #   assert_equal Post.count, 1
  # end

  def test_that_creating_multiple_models_doesnt_override_values
    post_one_title = "This is a post"
    post_two_title = "this is a different post"
    @post_1 = Post.create(title: post_one_title, body: "lorum ipsum gipsum")
    @post_2 = Post.create(title: post_two_title, body: "more hipsum")

    assert_equal Post.first.title, post_one_title
    assert_equal Post.last.title, post_two_title
  end
end