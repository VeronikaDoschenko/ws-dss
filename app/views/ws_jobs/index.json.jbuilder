json.array!(@ws_jobs) do |ws_job|
  json.extract! ws_job, :id
  json.url ws_job_url(ws_job, format: :json)
end
