json.array!(@lineitems) do |lineitem|
  json.extract! lineitem, :line_part, :line_order, :line_name, :line_price, :line_notes
  json.url lineitem_url(lineitem, format: :json)
end
