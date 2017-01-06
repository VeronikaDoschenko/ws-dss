Refinery::Inquiries.configure do |config|
  # Configure whether to show privacy link
  config.show_contact_privacy_link = false

  # Configure whether to show phone number field
  # config.show_phone_number_field = true

  # Configure whether to show form field placeholders
  # config.show_placeholders = true

  # Configure whether inquiries marked as spam should also send a notification mail
  # config.send_notifications_for_inquiries_marked_as_spam = false

  # Configure name in 'from' email address
  config.from_name = "noreply"

  # Configure the URLs to use for the inquiry functionality.
  # config.post_path           = "/contact"
  # config.page_path_new       = "/contact"
  # config.page_path_thank_you = "/contact/thank_you"

  # Toggle the spam filter
  config.filter_spam = false
  config.recaptcha_site_key = ENV['RECAPCHA_PUBLIC_KEY']

end
