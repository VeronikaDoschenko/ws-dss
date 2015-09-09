class PersonsController < ApplicationController
  def profile
    @ws_methods = WsMethod.ask_working
  end
  def test_output
    @ws_method = WsMethod.find(params[:id])
  end
end
