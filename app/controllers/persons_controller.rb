class PersonsController < ApplicationController
  def profile
    @ws_methods = WsMethod.where("test_output is not null and code is not null")
  end
  def test
    id = params[:method_id]
    if id
      ws_method = WsMethod.find(id)
      error_code = 0
      for_check = 0
      exec_val = <<-WS_EOS
        begin
          ws_input_data = <<-WS_DATA
            #{ws_method.test_input}
          WS_DATA
          $stdin  = StringIO.new(ws_input_data)
          $stdout = StringIO.new
          #{ws_method.code}
          $stdout.string
        rescue Exception => msg   
          $stdout.string + "\n" + msg.to_s 
        ensure
          $stdin  = STDIN
          $stdout = STDOUT
        end
      WS_EOS
      s = eval(exec_val)  
      if s.gsub(/\s/,'') == ws_method.test_output.gsub(/\s/,'')
        s += "\nРезультаты тестового запуска совпали с ожидаемыми! #{error_code} #{for_check}"
      else
        s += "\nРезультаты тестового запуска не совпали с ожидаемыми! #{error_code} #{for_check}"
      end
      render plain: s
    else
      render plain: "failure"
    end
  end
end
