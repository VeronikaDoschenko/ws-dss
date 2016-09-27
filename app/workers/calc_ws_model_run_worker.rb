class CalcWsModelRunWorker

  include Sidekiq::Worker
  
  sidekiq_options :retry => false
  
  def perform(ws_model_run_id)
    puts "Start ModelRun #{ws_model_run_id}"
    mr = WsModelRun.find(ws_model_run_id)
    puts "Running Model #{mr.name} ...."
    mr.ws_model_status_id = 3
    mr.trace = "Starting trace...."
    mr.save
    begin
      if mr.ws_model.ws_method.nil?
          raise "Method not set"
      end
      input = {}
      mr.ws_param_values.each do |pv|
        input[pv.ws_param.name] = JSON.parse("[#{pv.old_value}]")[0] unless pv.old_value.blank?
      end
      a = mr.ws_model.ws_method.do_calc(input.to_json)
      output = JSON.parse(a[0])
      is_save = false
      mr.ws_model.ws_param_models.each do |pm|
        if pm.ws_param and output[pm.ws_param.name]
          pv = mr.ws_param_values.find_by_ws_param_id(pm.ws_param.id)
          pv = mr.ws_param_values.new(ws_param: pm.ws_param) if pv.nil?
          pv.new_value = output[pv.ws_param.name] 
          pv.save
          is_save = true
        end 
      end
      if output['trace']
        if output['trace'].kind_of?(Array)
          mr.trace = output['trace'].join("\n")
        else
          mr.trace = output['trace']
        end
      end
      unless is_save
          raise "Method not return result" 
      end
      if a[1] != 0
        mr.ws_model_status_id = 5
      else
        mr.ws_model_status_id = 4
      end
      mr.save
    rescue Exception => msg
      mr.ws_model_status_id = 6
      mr.trace += "\n#{msg.to_s}"
      mr.trace += "\n#{msg.inspect}"
      mr.trace += "\n#{msg.backtrace}"
      mr.save
    end
  end
end
