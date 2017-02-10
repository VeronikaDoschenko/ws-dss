class WsMethod < ActiveRecord::Base
  nilify_blanks
  
  has_many :descriptions, as: :rec, dependent: :destroy
  has_many :ws_jobs, dependent: :restrict_with_exception
  has_many :ws_models
  royce_roles %w[ public ] + User.available_roles.collect{|s| s.name} - %w[ admin ]
  
  def descr
    d = self.descriptions.where(:locale => I18n.locale).first
    return d ? d.descr : ""
  end

  def descr=(x)
    d = self.descriptions.where(:locale => I18n.locale).first
    if d      
      d.update(:descr => x)
    else
      self.descriptions.new(:locale => I18n.locale, :descr => x)
    end
    return x
  end

  scope :ask_working,-> do 
    where("test_output is not null").order("lower(name)")
  end

  def do_calc (m_input)
    error_code = 0
    for_check = 0
    output_data = nil
	if m_input and self.code   
		exec_val = <<-WS_EOS
		  begin
			ws_input_data = <<-WS_DATA
			  #{m_input}
			WS_DATA
			$stdin  = StringIO.new(ws_input_data)
			$stdout = StringIO.new
			#{self.code}
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
	else
		s = {trace: ( self.code ? "no input" : "no code" ) }.to_json
	end
    return [s, error_code, for_check, output_data]
  end
end
