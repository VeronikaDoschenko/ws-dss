Refinery::Inquiries::InquiriesController.class_eval do
  skip_before_filter :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  
end