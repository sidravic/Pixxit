ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain =>  "gmail.com",
    :user_name => "testserv3r",
    :password => "mail_123",
    :authentication => :plain
}

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.default_content_type = "text/html"