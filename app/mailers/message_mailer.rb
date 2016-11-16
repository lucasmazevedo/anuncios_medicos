class MessageMailer < ActionMailer::Base

   #default from: "Anúncios Médicos <contato@anunciosmedicos.com.br>"
   #default to: "Anúncios Médicos <contato@anunciosmedicos.com.br>"

  def sendmessageads(message)
    object = ActiveSupport::JSON.decode(message)
    @message = Message.new(name: object["name"], email: object["email"], content: object["content"], ads: object["ads"], reason: object["reason"])
    @ad = Ad.friendly.find(@message.ads)
    mail(from: "#{@message.name} via Anúncios Medicos <no-reply@anunciosmedicos.com.br>", reply_to: "#{@message.name} <#{@message.email}>", subject: "Mensagem de #{@message.name}", to: "#{@ad.user.profile.fullname} <#{@ad.user.email}>")
  end



  def send_report_ads(message)
    object = ActiveSupport::JSON.decode(message)
    @message = Message.new(name: object["name"], email: object["email"], content: object["content"], ads: object["ads"], reason: object["reason"])
    @ad = Ad.friendly.find(@message.ads)
    mail(from: "#{@message.name} via Anúncios Medicos <no-reply@anunciosmedicos.com.br>", reply_to: "#{@message.name} <#{@message.email}>", subject: "Denúncia de #{@message.reason} / Anúncio: #{@ad.id}", to: "Anúncios Médicos <contato@anunciosmedicos.com.br>")
  end

end