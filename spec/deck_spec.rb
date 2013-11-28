require 'deck'

describe "Deck" do

  let!(:card_source) { "spec/data/cards.yml" }
  let!(:alternate_card_source) { "spec/data/alternate_cards.yml" }

  describe "Constructor" do
    it "instantiates with no arguments" do
      expect(Deck.new).to be_instance_of(Deck)
    end
    it "can override the source file with an argument" do
      d = Deck.new(card_source)
      expect(d).to be_instance_of(Deck)
      expect(d.cards).to_not be_empty
    end
  end

  describe "Attributes" do
    let!(:deck) { Deck.new }
  
    it "can access the cards read-only" do
      expect(deck.cards.count).to_not be_nil
      expect { deck.cards = 5 }.to raise_error(NoMethodError)
    end
  end

  describe "Methods" do
    let!(:deck) { Deck.new }
  
    it "can load a new YAML file" do
      expect {
        deck.load(alternate_card_source)
      }.to change{deck.cards.count}
    end
  
    context "when enumerating" do
      it "prepares the details hash" do
        details = deck.first
        expect(details).to_not be_nil
        expect(details["name"]).to_not be_nil
      end
    end
  end
end
