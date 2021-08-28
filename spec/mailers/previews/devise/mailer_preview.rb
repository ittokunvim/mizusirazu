# Preview all emails at http://localhost:5000/rails/mailers/devise/mailer
class Devise::MailerPreview < ActionMailer::Preview

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, 'fake token')
  end

  def email_changed
    Devise::Mailer.email_changed(User.first)
  end

  def password_change
    Devise::Mailer.password_change(User.first)
  end

end
