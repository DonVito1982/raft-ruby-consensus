require 'pathname'
require 'json'

class Node
  def initialize(identifier)
    @identifier = identifier
    nodes = Network.instance.nodes
    @peer_nodes = nodes - [@identifier]
    create_node unless nodes.include?(@identifier)
  end

  def role
    raft_state = File.read(state_file_path)
    JSON.parse(raft_state)["role"]
  end

  def create_node
    Network.instance.add_node(@identifier)
    create_state_file
  end

  def state_file_path
    Pathname.new "files/#{env_folder}/n_#{@identifier}_state.json"
  end

  def env_folder
    Network.instance.environment
  end

  def create_state_file
    role = @peer_nodes.empty? ? "leader" : "follower"
    Network.instance.add_node(@identifier)
    create_file_dir unless state_file_path.dirname.exist?

    File.open(state_file_path, "w") do |file|
      initial_state = { role: role }
      file.write(initial_state.to_json)
    end
  end

  def create_file_dir
    `mkdir -p files/#{env_folder}`
  end
end
