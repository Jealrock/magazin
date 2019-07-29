class OfferMailer < ApplicationMailer
  # rubocop:disable Metrics/AbcSize
  def notify
    @user = params[:user]
    @offer = params[:offer]

    if @offer.photos.any? && @offer.photos.first&.file&.file
      @photo_file = @offer.photos.first.file
      attachments.inline[@photo_file.file.filename] = @photo_file.read
    end

    mail(to: @user.email, subject: @offer.title)
  rescue StandardError => e
    #  to prevent job retrying
    p "OfferMailer Error: #{e}"
    e.backtrace.each { |line| p line }
    nil
  end
  # rubocop:enable Metrics/AbcSize
end
