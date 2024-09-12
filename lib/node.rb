require 'pathname'
require 'json'

class Node
  def initialize(identifier)
    @identifier = identifier
    nodes = Network.instance.nodes
    create_node unless nodes.include?(@identifier)
  end

  def role
    raft_state = File.read(state_file_path)
    JSON.parse(raft_state)["role"]
  end

  def peers
    raft_state = File.read(state_file_path)
    JSON.parse(raft_state)["peers"]
  end

  def receive(content)
    action = content[:body][:action]
    action_params = content[:body].merge({ sender: content[:sender] }).except(:action)
    send(action, **action_params)
  end

  def creation(sender:)
    raft_state = JSON.parse(File.read(state_file_path))
    raft_state["peers"] << sender
    File.open(state_file_path, "w") do |file|
      file.write(raft_state.to_json)
    end
  end

  private
  def create_node
    peer_nodes = Network.instance.nodes - [@identifier]
    role = peer_nodes.empty? ? "leader" : "follower"
    Network.instance.add_node(@identifier)
    create_state_file(role: role, peer_nodes: peer_nodes)
    peers.each do |peer_id|
      content = { body: { action: "creation" }, receiver: peer_id }
      send_message(content)
    end
  end

  def send_message(content)
    Network.instance.process_message(content.merge({ sender: @identifier }))
  end

  def state_file_path
    Pathname.new "files/#{env_folder}/n_#{@identifier}_state.json"
  end

  def env_folder
    Network.instance.environment
  end

  def create_state_file(role:, peer_nodes:)
    create_file_dir unless state_file_path.dirname.exist?

    File.open(state_file_path, "w") do |file|
      initial_state = { role: role, peers: peer_nodes }
      file.write(initial_state.to_json)
    end
  end

  def create_file_dir
    `mkdir -p files/#{env_folder}`
  end
end
