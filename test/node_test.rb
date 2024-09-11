require "minitest/autorun"

require_relative "../lib/node"
require_relative "test_helper"

describe Node do
  it "sums digits" do
    node1 = Node.new(1)
    assert_equal(node1.role, "follower")
  end
end
