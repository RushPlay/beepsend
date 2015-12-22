module Beepsend
  class Configuration
    attr_accessor :token, :endpoint, :from, :encoding, :receive_dlr

    def initialize
      @endpoint = 'https://api.beepsend.com/2/send/'
      @encoding = 'UTF-8'
      @receive_dlr = 0
    end
  end
end

