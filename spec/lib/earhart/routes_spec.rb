require "spec_helper"

RSpec.describe Earhart::Routes do
  let(:routes) do
    described_class.new(routes)
  end

  describe "#add" do
    let(:add) do
      routes.add(pattern, receiver)
    end


  end

  describe "#find" do
    let(:find) do
      routes.find(query)
    end


  end

  describe "#to_s" do
    let(:to_s) do
      routes.to_s
    end


  end
end
