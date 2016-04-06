json.array!(@ws_model_runs) do |ws_model_run|
  json.extract! ws_model_run, :id, :name, :ws_model_id, :ws_model_status_id, :trace
  json.url ws_model_run_url(ws_model_run, format: :json)
end
