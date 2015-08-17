class PersonsController < ApplicationController
  def profile
    @ws_methods = WsMethod.where("test_output is not null and code is not null")
  end
  def test_output
    @ws_method = WsMethod.find(params[:id])
  end
end
