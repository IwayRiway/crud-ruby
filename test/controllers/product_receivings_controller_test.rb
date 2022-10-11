require "test_helper"

class ProductReceivingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_receiving = product_receivings(:one)
  end

  test "should get index" do
    get product_receivings_url
    assert_response :success
  end

  test "should get new" do
    get new_product_receiving_url
    assert_response :success
  end

  test "should create product_receiving" do
    assert_difference("ProductReceiving.count") do
      post product_receivings_url, params: { product_receiving: { document_date: @product_receiving.document_date, document_number: @product_receiving.document_number, status: @product_receiving.status } }
    end

    assert_redirected_to product_receiving_url(ProductReceiving.last)
  end

  test "should show product_receiving" do
    get product_receiving_url(@product_receiving)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_receiving_url(@product_receiving)
    assert_response :success
  end

  test "should update product_receiving" do
    patch product_receiving_url(@product_receiving), params: { product_receiving: { document_date: @product_receiving.document_date, document_number: @product_receiving.document_number, status: @product_receiving.status } }
    assert_redirected_to product_receiving_url(@product_receiving)
  end

  test "should destroy product_receiving" do
    assert_difference("ProductReceiving.count", -1) do
      delete product_receiving_url(@product_receiving)
    end

    assert_redirected_to product_receivings_url
  end
end
