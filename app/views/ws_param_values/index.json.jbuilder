json.array!(@ws_param_values) do |ws_param_value|
  json.extract! ws_param_value, :id, :ws_param_id, :ws_model_run_id, :old_value, :new_value,
                                :formula
  json.url ws_param_value_url(ws_param_value, format: :json)
end
