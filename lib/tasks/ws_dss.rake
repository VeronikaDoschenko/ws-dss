namespace :ws_dss do
  desc "do all ws_jobs"
  task process_ws_jobs: :environment do
    WsJob.where('output is null').each do |job|
        puts "do_job ........................................"
        job.do_job
    end
  end
  
  desc "proccess one model run based on method"  
  task :process_ws_model_run, [:ws_model_run_id] => :environment do |t, args|
    mr = WsModelRun.find(args[:ws_model_run_id])
    p t
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
      mr.ws_param_values.each do |pv|
        if output[pv.ws_param.name]
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
