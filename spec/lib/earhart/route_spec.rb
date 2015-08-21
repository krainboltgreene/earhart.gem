require "spec_helper"

RSpec.describe Earhart::Route do
  let(:pattern) do
    "foo"
  end

  let(:receiver) do
    Object
  end

  let(:route) do
    described_class.new(pattern, receiver)
  end

  describe "#to_s" do
    let(:to_s) do
      route.to_s
    end

    it "outputs correctly" do
      expect(to_s).to eq("Earhart::Route{foo -> Object}")
    end
  end

  describe "#match" do
    let(:query) do
      "foo"
    end

    let(:match) do
      route.match(query)
    end

    it "matches" do
      expect(match).to be(true)
    end
  end
end
