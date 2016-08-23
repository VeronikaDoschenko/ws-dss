class CalcWsModelRunWorker

  include Sidekiq::Worker
  
  sidekiq_options :retry => false
  
  def perform(ws_model_run_id)
    puts "First task Ok! #{ws_model_run_id}"
  end
end
