json.array!(@discounts) do |discount|
  json.extract! discount, :name, :percent
  json.url discount_url(discount, format: :json)
end