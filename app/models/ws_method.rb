class TrueClass
	def impl( other )
	  other 
	end
	def equviv( other )
	  other
	end
	def pirs( other )
	  false 
	end
	def sheph( other )
	  not other
	end
end

class FalseClass
	def impl( other )
	  true
	end
	def equviv( other )
	  not other 
	end
	def pirs( other )
	  not other 
	end
	def sheph( other )
	  true
	end
end

class WsMethod < ActiveRecord::Base
  nilify_blanks
  
  has_many :descriptions, as: :rec, dependent: :destroy
  has_many :ws_jobs, dependent: :restrict_with_exception

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
  
  def do_calc (m_input)
    error_code = 0
    for_check = 0
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
    return [s, error_code, for_check]
  end
end
