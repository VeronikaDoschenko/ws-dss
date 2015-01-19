class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  def headers_for(action, opts)
    super.merge!({template_path: '/users/mailer'}) # this moves the Devise template path from /views/devise/mailer to /views/mailer/devise
  end
end