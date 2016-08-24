class CalcWsJobWorker

  include Sidekiq::Worker
  
  sidekiq_options :retry => false
  
  def perform(ws_job_id)
    puts "Start WsJob #{ws_job_id}"
    wj = WsJob.find(ws_job_id)
    wj.do_job
  end
end
