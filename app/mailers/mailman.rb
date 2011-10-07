class Mailman < ActionMailer::Base


  def activation(user)
    @user = user
    mail(:to => user.email,
         :from => "The Night Sky",
         :subject => "Activate your account."
    )
  end
end
