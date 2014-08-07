class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true
  #append :remote_ip, :user_agent, :session

  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "New Contact message from All Aboard Alliance website.",
      :to => "allaboardalliance@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end