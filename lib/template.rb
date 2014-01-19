class Template

  attr_reader :document, :destination
  
  def initialize(destination)
    @document = ""
    @cards = {}
    @pages = []
    @cards_rendered = 0
    @destination = destination
  end

  def <<(details)
    name = details["name"] ||= "No Name #{unique_cards}"
    details["quantity"] ||= 1
    if (@cards.has_key?(name.to_sym)) 
      @cards[name.to_sym]["quantity"] += (details["quantity"] || 1)
    else
      @cards[name.to_sym] = details
    end
    puts "[#{@cards.keys.index(name.to_sym)}] Added #{details["quantity"]} '#{name}' (#{total_cards} total)" if ENV["verbose"]
  end
  
  def total_cards
    @cards.values.find_all {|property| property == "quantity"}.reduce(:+)
  end
  
  def unique_cards
    @cards.keys.count
  end
  
  def render
    puts "Saved #{@cards_rendered} cards to #{@destination} (#{File.size?(@destination)})" if ENV["verbose"]
  end
 
end
