class PersonsController < ApplicationController
  def profile
    @ws_methods = WsMethod.all
  end
  def test
    id = params[:method_id]
    if id
      ws_method = WsMethod.find(id)
      s = eval("begin $input_data = '#{ws_method.test_input}'; $stdout = StringIO.new; #{ws_method.code}; $stdout.string; ensure $stdout = STDOUT end")
      puts "s=#{s}"
      render text: s
    else
      render text: "failure"
    end
  end
end
