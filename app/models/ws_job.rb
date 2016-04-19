class WsJob < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_method
  belongs_to :user

  def do_job
    a = self.ws_method.do_calc(self.input)
    self.output = a[0]
    self.error_code = a[1]
    self.for_check  = a[2]
    self.save
  end

end
