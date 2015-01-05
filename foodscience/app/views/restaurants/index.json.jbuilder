json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :rest_name, :rest_cuisine, :rest_desc, :rest_firstaddr, :rest_secondaddr, :rest_city, :rest_state, :rest_zip, :rest_phone, :rest_fax, :rest_url, :rest_delivers, :rest_fee, :rest_menufile
  json.url restaurant_url(restaurant, format: :json)
end
