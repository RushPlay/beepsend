require 'beepsend/version'
require 'uri'
require 'net/http'
require 'json'

require 'beepsend/configuration'
require 'beepsend/client'

module Beepsend
  class ServerResponseError < RuntimeError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = nil
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
