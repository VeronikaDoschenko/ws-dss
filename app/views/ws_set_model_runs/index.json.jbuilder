json.array!(@ws_set_model_runs) do |ws_set_model_run|
  json.extract! ws_set_model_run, :id, :name, :descr
  json.url ws_set_model_run_url(ws_set_model_run, format: :json)
end
