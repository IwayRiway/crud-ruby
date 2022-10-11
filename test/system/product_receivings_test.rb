require "application_system_test_case"

class ProductReceivingsTest < ApplicationSystemTestCase
  setup do
    @product_receiving = product_receivings(:one)
  end

  test "visiting the index" do
    visit product_receivings_url
    assert_selector "h1", text: "Product receivings"
  end

  test "should create product receiving" do
    visit product_receivings_url
    click_on "New product receiving"

    fill_in "Document date", with: @product_receiving.document_date
    fill_in "Document number", with: @product_receiving.document_number
    fill_in "Status", with: @product_receiving.status
    click_on "Create Product receiving"

    assert_text "Product receiving was successfully created"
    click_on "Back"
  end

  test "should update Product receiving" do
    visit product_receiving_url(@product_receiving)
    click_on "Edit this product receiving", match: :first

    fill_in "Document date", with: @product_receiving.document_date
    fill_in "Document number", with: @product_receiving.document_number
    fill_in "Status", with: @product_receiving.status
    click_on "Update Product receiving"

    assert_text "Product receiving was successfully updated"
    click_on "Back"
  end

  test "should destroy Product receiving" do
    visit product_receiving_url(@product_receiving)
    click_on "Destroy this product receiving", match: :first

    assert_text "Product receiving was successfully destroyed"
  end
end
