Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPCHA_PUBLIC_KEY']
  config.private_key = ENV['RECAPCHA_PRIVATE_KEY']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  # Uncomment if you want to use the newer version of the API,
  # only works for versions >= 0.3.7:
  config.api_version = 'v1'
end