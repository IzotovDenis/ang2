class UserMailer < ActionMailer::Base
  default from: "'Планета-Авто' <order@planeta-avtodv.ru>"

  def reset_password(user, password)
    @password = password
    @user = user
    mail to: @user.email, :reply_to => "order@planeta-avtodv.ru", subject: "Новый пароль"
  end

  def change_role(user)
  	@user = user
  	mail to: @user.email, :reply_to => "info@planeta-avtodv.ru", subject: "Доступ на сайт"
  end

end
