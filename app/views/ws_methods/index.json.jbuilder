json.array!(@ws_methods) do |ws_method|
  json.extract! ws_method, :id, :name, :descr, :created_at, :updated_at
  json.url ws_method_url(ws_method, format: :json)
end
