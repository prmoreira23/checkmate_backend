require 'test_helper'

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get downloads_show_url
    assert_response :success
  end

  test "should get contract_pdf" do
    get downloads_contract_pdf_url
    assert_response :success
  end

  test "should get send_contract_pdf" do
    get downloads_send_contract_pdf_url
    assert_response :success
  end

end
