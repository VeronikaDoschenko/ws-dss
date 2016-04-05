json.array!(@ws_models) do |ws_model|
  json.extract! ws_model, :id, :name, :descr, :url
  json.url ws_model_url(ws_model, format: :json)
end
