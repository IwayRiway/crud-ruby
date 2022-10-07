json.extract! product, :id, :part_id, :part_name, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
