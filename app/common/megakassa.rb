# Legacy code :)
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists
class Megakassa
  def self.pay_redirect(
    amount, currency, description, order_id, method_id,
    client_email, client_phone = '', language
  )
    data = {
      'shop_id' => ENV['MEGAKASSA_SHOP_ID'],
      'amount' => amount,
      'currency' => currency,
      'description' => description,
      'order_id' => order_id,
      'method_id' => method_id,
      'client_email' => client_email,
      'client_phone' => client_phone,
      'debug' => ENV['MEGAKASSA_DEBUG'],
      'agree' => 'true',
      'signature' => generate_signature(
        [ENV['MEGAKASSA_SHOP_ID'], amount, currency, description, order_id, method_id,
         client_email, ENV['MEGAKASSA_DEBUG'], ENV['MEGAKASSA_SIGNATURE']],
        true
      ),
      'language' => language
    }
    begin
      RestClient::Request.execute(method: :post, url: 'https://megakassa.ru/merchant/choose/1/',
                                  payload: data) do |response, _request, _result|
        return nil unless response.headers[:location]

        return 'https://megakassa.ru' + response.headers[:location].to_s
      end
    rescue StandardError => e
      puts e.to_s
      return nil
    end
  end
  # rubocop:enable

  def self.generate_signature(arr, with_signature)
    data = arr.join(':')
    return Digest::MD5.hexdigest(arr.last + Digest::MD5.hexdigest(data)) if with_signature

    Digest::MD5.hexdigest(data)
  end

  def self.convert_number(number)
    num = number.to_s
    num = num.split('.')
    if num[1]
      num[1] += '0' if num[1].length == 1
    else
      num << '00'
    end
    num.join('.')
  end

  def self.valid?(params)
    params['debug'] = 0 if params['debug'].empty?

    return false unless params['currency'] && ['RUB', 'USD', 'EUR'].include?(params['currency'])

    return false unless params['status'] && ['success', 'fail'].include?(params['status'])

    return false unless params['signature'] && params['signature'] =~ /[0-9a-f]{32}/

    signature = Megakassa.generate_signature(
      [
        params['uid'], params['amount'], params['amount_shop'], params['amount_client'],
        params['currency'], params['order_id'], params['payment_method_id'], params['payment_method_title'],
        params['creation_time'], params['payment_time'], params['client_email'], params['status'], params['debug'],
        ENV['MEGAKASSA_SIGNATURE']
      ],
      false
    )

    return false unless signature == params['signature']

    true
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists
