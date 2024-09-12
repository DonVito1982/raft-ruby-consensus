require 'singleton'

class Network
  include Singleton
  attr_reader :environment, :nodes

  def set_env(env)
    @environment = env
  end

  def add_node(identifier)
    @nodes << identifier
  end

  def purge_nodes
    @nodes = []
  end

  private

  def initialize
    @environment = "dev"
    @nodes = []
  end
end
