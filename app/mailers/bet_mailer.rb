class BetMailer < ApplicationMailer

  layout 'mailer'
  default from: 'testkgnew@gmail.com'
  def welcome_email(bet)
    email = bet.invitation
	@bet = bet
	@url = 'wwww'
	mail(to: email, subject: 'Welcome to Challenge Service')
  end

end
