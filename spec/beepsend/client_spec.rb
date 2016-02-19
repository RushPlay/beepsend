require 'spec_helper'

describe Beepsend::Client do
  describe '#send_sms' do
    let(:token) { 'SECRETTOKENXXX' }
    let(:request_body) { "{\"encoding\":\"UTF-8\",\"receive_dlr\":0,\"to\":\"000\",\"from\":\"Luke\",\"message\":\"May 4th\"}" }
    let(:response_body) { "[{\"id\":[\"096658200145588963128001380965891942\"],\"from\":\"Luke\",\"to\":\"000\"}]" }

    before do
      Beepsend.configure { |c| c.token = token }
    end

    after do
      Beepsend.reset_configuration
    end

    before do
      headers = {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => "Token #{token}",
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'
      }
      stub_request(:post, "https://api.beepsend.com/2/send/").
        with(body: request_body,
             headers: headers).
             to_return(status: 201, body: response_body, headers: {})
    end

    it 'returns response body' do
      expect(send_message).to eq(response_body)
    end

    def send_message
      Beepsend::Client.new.send_sms(to: '000', from: 'Luke', message: 'May 4th')
    end
  end
end
