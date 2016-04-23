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
    puts "Running Model #{mr.name}"
  end
end
