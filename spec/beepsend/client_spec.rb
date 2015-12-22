require 'spec_helper'

describe Beepsend::Client do
  describe '#send_sms' do
    context 'success' do
      let(:token) { 'SECRETTOKENXXX' }

      before do
        Beepsend.configure { |c| c.token = token }
      end

      after do
        Beepsend.reset_configuration
      end

      it 'sends request to API endpoint' do
        headers = {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => "Token #{token}",
          'Content-Type' => 'application/json',
          'User-Agent' => 'Ruby'
        }
        stub_request(:post, "https://api.beepsend.com/2/send/").
          with(body: "{\"encoding\":\"UTF-8\",\"receive_dlr\":0,\"to\":\"000\",\"from\":\"Luke\",\"message\":\"May 4th\"}",
               headers: headers).
               to_return(status: 201, body: 'success', headers: {})

        send_message
      end
    end

    context 'fail' do
      it 'raises exception if response from server is not 201' do
        headers = {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Token ',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Ruby'
        }
        stub_request(:post, "https://api.beepsend.com/2/send/").
          with(body: "{\"encoding\":\"UTF-8\",\"receive_dlr\":0,\"to\":\"000\",\"from\":\"Luke\",\"message\":\"May 4th\"}",
               headers: headers).
               to_return(status: 401, body: "{\"errors\":[\"Request header must contain 'Token <api-token>'\"]}", headers: {})

        error_message = %q{Response code: 401. Body: {"errors":["Request header must contain 'Token <api-token>'"]}}

        expect { send_message }.to raise_error(Beepsend::ServerResponseError, error_message)
      end
    end

    def send_message
      Beepsend::Client.new.send_sms(to: '000', from: 'Luke', message: 'May 4th')
    end
  end
end
