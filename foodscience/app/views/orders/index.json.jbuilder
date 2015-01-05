json.array!(@orders) do |order|
  json.extract! order, :order_rest, :order_organizer, :order_type, :order_cost, :order_time_at, :order_status
  json.url order_url(order, format: :json)
end
