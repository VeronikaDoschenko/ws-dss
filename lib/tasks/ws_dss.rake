namespace :ws_dss do
  desc "do all ws_jobs"
  task process_ws_jobs: :environment do
    sleep 30
    WsJob.where('output is null').each do |job|
        job.do_job
    end
    
  end

end