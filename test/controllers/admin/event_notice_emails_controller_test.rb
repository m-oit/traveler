require "test_helper"

class Admin::EventNoticeEmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_event_notice_emails_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_event_notice_emails_destroy_url
    assert_response :success
  end
end
