json.array!(@ws_models) do |ws_model|
  json.extract! ws_model, :id, :name, :descr, :model_url, :ws_method_id, :user_id,
                          :ws_param_models
  json.url ws_model_url(ws_model, format: :json)
end
