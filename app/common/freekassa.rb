class Freekassa
  class << self
    def generate_signature(arr, with_signature)
      return Digest::MD5.hexdigest(arr.join('')) if with_signature

      Digest::MD5.hexdigest(arr.join(':'))
    end

    def valid?
      signature = Freekassa.generate_signature(
        [ENV['FREEKASSA_SHOP_ID'], params['AMOUNT'], ENV['FREEKASSA_SIGNATURE'], params['MERCHANT_ORDER_ID']], false
      )

      return false unless signature == params['signature']

      true
    end
  end
end
