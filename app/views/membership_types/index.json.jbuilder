json.array!(@membership_types) do |membership_type|
  json.extract! membership_type, :name, :monthlycost
  json.url membership_type_url(membership_type, format: :json)
end