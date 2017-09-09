class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_pic.subject
  #
  def sendmail_pic(pic)
    @pic = pic

    mail to: "sista05@y4.dion.ne.jp",
    subject: '【giltystagram】写真が投稿されました'
  end
  
  def sendmail_contacts(contacts)
    @contacts = contacts
    mail(to: @contacts.email, subject: 'お問い合わせありがとうございましたー')

  end
end
