require 'singleton'

class Network
  include Singleton
  attr_reader :environment

  def set_env(env)
    @environment = env
  end

  private

  def initialize
    @environment = "dev"
  end
end
