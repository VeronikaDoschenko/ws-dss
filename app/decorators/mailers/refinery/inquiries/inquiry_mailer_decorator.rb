Refinery::Inquiries::InquiryMailer.class_eval do
  def from_mail
    ENV["MAIL_USERNAME"]
  end
end