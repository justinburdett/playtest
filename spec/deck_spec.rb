require 'deck'

describe "default" do
  it "creates a deck object" do
    expect(Deck.new.type).to eq(Deck)
  end
end