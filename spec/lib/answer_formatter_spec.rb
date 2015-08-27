require 'spec_helper'

describe AnswerFormatter do
  it "formats credits of a resource for provided quantity" do
    expect(AnswerFormatter.new("glob prok", "Silver", 68).to_s).to eq "glob prok Silver is 68 Credits"
  end

  it "formats value of a provided quantity" do
    expect(AnswerFormatter.new("pish tegj glob glob", nil, 42).to_s).to eq "pish tegj glob glob is 42"
  end
end
