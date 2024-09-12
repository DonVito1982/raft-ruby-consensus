require "minitest/autorun"
require 'pathname'

require_relative "../lib/node"
require_relative "test_helper"

describe Node do
  after do
    `rm -rf files/test`
    Network.instance.purge_nodes
  end

  it "creates a leader node on an empty network" do
    node1 = Node.new(1)
    assert_equal(node1.role, "leader")
  end

  it "creates a follower on a populated network" do
    node1 = Node.new(1)
    node2 = Node.new(2)
    assert_equal(node2.role, "follower")
  end

  it "has a raft-state file" do
    refute(Pathname.new("files/test").exist?)
    node2 = Node.new(2)
    file = "files/test/n_2_state.json"
    assert(Pathname.new(file).exist?)
  end

  it "acknowledges other nodes in the network" do
    node1 = Node.new(1)
    node2 = Node.new(2)
    assert_equal(node1.peers, [2])
    assert_equal(node2.peers, [1])
  end
end
