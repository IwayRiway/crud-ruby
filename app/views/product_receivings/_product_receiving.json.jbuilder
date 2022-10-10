json.extract! product_receiving, :id, :document_number, :document_date, :status, :created_at, :updated_at
json.url product_receiving_url(product_receiving, format: :json)
