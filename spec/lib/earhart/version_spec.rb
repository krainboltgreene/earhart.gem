require "spec_helper"

RSpec.describe Earhart::VERSION do
  it "should be a string" do
    expect(Earhart::VERSION).to be_kind_of(String)
  end
end
