namespace :ws_dss do
  desc "do all ws_jobs"
  task process_ws_jobs: :environment do
    WsJob.where('output is null').each do |job|
        puts "do_job ........................................"
        job.do_job
    end
  end
end
