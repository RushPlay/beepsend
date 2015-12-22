require 'spec_helper'

describe Beepsend::Configuration do
  after do
    Beepsend.reset_configuration
  end

  it 'Uses a #configure block to configurate' do
    token = 'secret token'

    expect { set_token(token) }.to \
      change { Beepsend.configuration.token }.
      from(nil).to(token)
  end

  it 'Sets default values' do
    configuration = Beepsend.configuration

    expect(configuration.endpoint).to eq('https://api.beepsend.com/2/send/')
    expect(configuration.encoding).to eq('UTF-8')
    expect(configuration.receive_dlr).to be_zero
  end

  def set_token(token)
    Beepsend.configure do |config|
      config.token = token
    end
  end
end
