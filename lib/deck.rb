require 'yaml'

class Deck
  include Enumerable
  attr_reader :cards

  def initialize (card_source = "cards.yml")
    # Load the cards from our cards file
    load(card_source)
  end
  
  def load(source_file)
    begin
      @cards = YAML.load_file(source_file)
      puts "Loaded #{@cards.count} records from #{File.realpath(source_file)}"
    rescue Exception => e
      puts "Cannot access #{source_file}"
    end
  end
  
  def each(&block)
    @cards.each do |name, details|
      details["name"] = name
      yield(details)
    end
  end

end

