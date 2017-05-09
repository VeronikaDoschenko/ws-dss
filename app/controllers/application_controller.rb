class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale
  before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  before_action :authenticate_user!
    
  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end
  
  def default_url_options(options={})
    { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  }
  end
  
  private
  
  def extract_locale_from_accept_language_header
    case request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      when 'az'
      when 'am'
      when 'by'
      when 'kz'
      when 'ru'
      when 'kg'
      when 'md'
      when 'tj'
      when 'tm'
      when 'uz'
      when 'ua'
      when 'ge'
      when 'af' 
      when 'mn'
        'ru'
      else
        'en'
    end
  end


  def authenticate_user_from_token!
    user_token = request.headers["HTTP_USER_TOKEN"].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)
    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end
end
