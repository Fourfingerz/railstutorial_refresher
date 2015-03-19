host = 'hartlfakeapp.herokuapp.com'
ActionMailer::Base.default_url_options = { host: host }

  ActionMailer::Base.smtp_settings = {
    :addresses      => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_USERNAME'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }