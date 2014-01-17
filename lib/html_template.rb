require_relative 'template'
class HtmlTemplate < Template

  attr_reader :css
  
  def initialize (destination, css)  
    @css = css
    super(destination)
  end

  def render
    poker_cards
    css_data = File.read(@css)
    export = "<html>
       <head><style type=\"text/css\" media=\"all\">#{css_data}</style>
             <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"></head>
       <body class=\"content\">
         <table class=\"poker\">
         #{@document}
         </table>
       </body>
       </html>"
    File.open(@destination, 'w') { |file| file.write(export) }
    super
  end
 
private
  def poker_cards
    # Reset the document property so that we can re-render if necessary
    @document = ""
    # This loop iterates through all the cards that have been added
    @cards_rendered = 0
    @cards.each do |name, card_details|
      additional_classes = card_details.delete("css")
      quantity = card_details["quantity"]
      card_text = "<h2>#{name.to_s}</h2>"
      card_text += "<dl>"
      card_details.each do |k,v| card_text += "<dt class=\"#{k}\">#{k}</dt><dd class=\"#{k}\">#{v}</dd>"; end
      card_text += "</dl>"
      quantity.to_i.times do |i|
        # We need to create a new table every 9 cards
        @document += "<table class=\"poker\">" if (@cards_rendered % 9 == 0)
        # We also need a new table row every 3 cards
        @document += "<tr>" if (@cards_rendered % 3 == 0)
        # Insert the card details here
        @document += "<td class=\"card #{additional_classes}\">#{card_text}</td>"
        
        # Increment cards rendered. This may trigger HTML closing tags
        @cards_rendered += 1
        @document += "</tr>" if (@cards_rendered % 3 == 0)
        @document += "</table>" if (@cards_rendered % 9 == 0)
      end
    end
  end
end
