json.array!(@ws_params) do |ws_param|
  if can? :read, ws_param
    json.extract! ws_param, :id, :name, :descr, :is_int, :dim, :min_val, :max_val
    json.url ws_param_url(ws_param, format: :json)
  end
end
