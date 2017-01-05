Devise::SessionsController.class_eval do
  skip_before_action :detect_wsdss_single_sign_on!, only: [:create]
  after_action :detect_wsdss_single_sign_on!, only: [:create]

  private
  # This overrides what Spree defines, so that we can get back to Refinery.
  def after_sign_in_path_for(resource)
    session[:previous_url] || super
  end
end
