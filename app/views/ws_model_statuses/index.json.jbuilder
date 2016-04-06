json.array!(@ws_model_statuses) do |ws_model_status|
  json.extract! ws_model_status, :id, :name
  json.url ws_model_status_url(ws_model_status, format: :json)
end
