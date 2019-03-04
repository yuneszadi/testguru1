class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <mail@testsguru.com>}
  layout 'mailer'
end
