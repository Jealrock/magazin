class Payments::Notification < Payment
  validates :price, absence: true

  def process
    return unless pending?

    payable_entity.notify
  end

  def redirect_path
    "/orders/#{payable_entity.id}?notified=#{success?}"
  end
end
