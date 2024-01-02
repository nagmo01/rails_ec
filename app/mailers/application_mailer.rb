# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'railsecsite@gmail.com'
  layout 'mailer'
end
