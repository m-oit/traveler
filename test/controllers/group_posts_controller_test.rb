require "test_helper"

class GroupPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get group_posts_new_url
    assert_response :success
  end

  test "should get create" do
    get group_posts_create_url
    assert_response :success
  end

  test "should get index" do
    get group_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get group_posts_show_url
    assert_response :success
  end
end
