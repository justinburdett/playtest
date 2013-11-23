require 'yaml'

class Deck
  include Enumerable
  attr_reader :cards

  def initialize (card_source = "cards.yml")
    @card_source = card_source
   
    # Load the cards from our cards file
    @cards = YAML.load_file(@card_source)
  end
  
  def each(&block)
    @cards.each do |name, details|
      yield(name, details)
    end
  end

end

