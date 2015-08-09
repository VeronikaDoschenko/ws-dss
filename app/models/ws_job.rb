class WsJob < ActiveRecord::Base
  belongs_to :ws_method
  belongs_to :user

  def do_job
    error_code = 0
    for_check = 0
    exec_val = <<-WS_EOS
      begin
        ws_input_data = <<-WS_DATA
          #{self.input}
        WS_DATA
        $stdin  = StringIO.new(ws_input_data)
        $stdout = StringIO.new
        #{self.ws_method.code}
        $stdout.string
      rescue Exception => msg
        error_code = 1
        $stdout.string + "\n" + msg.to_s 
      ensure
        $stdin  = STDIN
        $stdout = STDOUT
      end
    WS_EOS
    s = eval(exec_val)
    self.output = s
    self.error_code = error_code
    self.for_check  = for_check
    self.save
  end

end
