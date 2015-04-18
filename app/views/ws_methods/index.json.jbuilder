json.array!(@ws_methods) do |ws_method|
  json.extract! ws_method, :id
  json.url ws_method_url(ws_method, format: :json)
end
