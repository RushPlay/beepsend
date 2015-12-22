module Beepsend
  class Client
    def send_sms(to:, from: configuration.from, message:)
      response = http.request request(to, from, message)
      handle_response response
    end

    private

    def request(to, from, message)
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Authorization'] = "Token #{configuration.token}"
      request['Content-Type'] = 'application/json'
      request.body = default_options.merge(to: to, from: from, message: message).to_json
      request
    end

    def handle_response(response)
      unless response.code =~ /\A2\d\d\Z/ # all 2xx codes
        raise ServerResponseError, "Response code: #{response.code}. Body: #{response.body}"
      end
    end

    def configuration
      @configuration ||= Beepsend.configuration
    end

    def uri
      @uri ||= URI.parse(configuration.endpoint)
    end

    def http
      @http ||= Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = use_ssl?
      @http
    end

    def use_ssl?
      'https' == uri.scheme
    end

    def default_options
      {
        encoding: configuration.encoding,
        receive_dlr: configuration.receive_dlr
      }
    end
  end
end
