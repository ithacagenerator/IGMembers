json.array!(@members) do |member|
  json.extract! member, :id, :lname, :fname, :address, :city, :state, :zip, :email, :phone
  json.url member_url(member, format: :json)
end
