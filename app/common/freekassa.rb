class Freekassa
  class << self
    def format_price(value)
      value.to_i == value.to_f ? value.to_i : value.to_f
    end

    def generate_signature(arr)
      Digest::MD5.hexdigest(arr.join(':'))
    end

    def valid?(params)
      signature = Freekassa.generate_signature(
        [ENV['FREEKASSA_SHOP_ID'], params['AMOUNT'], ENV['FREEKASSA_SIGNATURE'], params['MERCHANT_ORDER_ID']]
      )

      return false unless signature == params['SIGN']

      true
    end
  end
end
