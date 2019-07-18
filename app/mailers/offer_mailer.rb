class OfferMailer < ApplicationMailer
  def notify
    @user = params[:user]
    @offer = params[:offer]

    if @offer.photos.any?
      @photo_file = @offer.photos.first.file
      attachments.inline[@photo_file.file.filename] = @photo_file.read
    end

    mail(to: @user.email, subject: 'Объявление на Yurt')
  end
end
