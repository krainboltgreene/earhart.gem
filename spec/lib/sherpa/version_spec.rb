require "spec_helper"

RSpec.describe Sherpa::VERSION do
  it "should be a string" do
    expect(Sherpa::VERSION).to be_kind_of(String)
  end
end
