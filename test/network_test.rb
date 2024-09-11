require "minitest/autorun"

require_relative "test_helper"

describe Network do
  it "creates a single instance" do
    net1 = Network.instance
    net2 = Network.instance
    assert_equal(net1, net2)
  end

  it "reports test environment" do
    assert_equal(Network.instance.environment, "test")
  end
end
