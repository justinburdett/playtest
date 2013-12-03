require 'prawn'
require "prawn/measurement_extensions" 

class Template

  attr_reader :html, :css, :document
  
  def initialize (html = "default.html", css = "default.css")  
    @html = html
    @css = css
    @document = ""
    @cards = {}
    @pages = []
  end

  def <<(details)
    name = details["name"] ||= "No Name #{unique_cards}"
    details["quantity"] ||= 1
    if (@cards.has_key?(name.to_sym)) 
      @cards[name.to_sym]["quantity"] += (details["quantity"] || 1)
    else
      @cards[name.to_sym] = details
    end
    puts "[#{@cards.keys.index(name.to_sym)}] Added #{details["quantity"]} '#{name}' (#{total_cards} total)"
  end
  
  def total_cards
    @cards.values.find_all {|property| property == "quantity"}.reduce(:+)
  end
  
  def unique_cards
    @cards.keys.count
  end
 
  def to_html(destination = "export/exported_#{@html}")
    render_cards
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
    File.open(destination, 'w') { |file| file.write(export) }
    puts "Saved #{@cards_added} cards to #{destination} (#{File.size?(destination)})"
  end
 
  def to_pdf(destination = "export/#{@html}.pdf")
    # Create the document
    pdf = Prawn::Document.new
    
    # Generate the PDF using the HTML we've generated
    render_poker_cards_to_pdf(pdf)

    # Save the PDF to our machine
    pdf.render_file destination
    puts "Saved #{@cards_added} cards to #{destination} (#{File.size?(destination)})"
  end
  
private
  def render_poker_cards_to_pdf(pdf)
    cards_drawn = 0
    pdf.define_grid(columns: 3, rows: 3, gutter: 0)
    @cards.each do |card|
      card_name = card[1].delete("name")
      
      card[1].delete("quantity").times {
        pdf.start_new_page if ((cards_drawn > 0) && (cards_drawn % 9 == 0))
        pdf.grid((cards_drawn % 9) / 3, cards_drawn % 3).bounding_box do |cell|
          # Draw Card outline
          pdf.transparent(0.2) { pdf.stroke_bounds }
          # Write the card title
          pdf.pad(10) { 
            pdf.indent(10) {
              pdf.text(card_name, size: 18, style: :bold, overflow: :shrink_to_fit) 
            }
          }
          # Write the card body
          card[1].each do |k,v| 
            pdf.indent(10) { pdf.text("#{k} #{v.inspect}") }
            pdf.move_down(5)
          end
        end
        cards_drawn += 1
      }
    end
  end

  def render_cards(card_type = "poker")
    # Reset the document property so that we can re-render if necessary
    @document = ""
    # This loop iterates through all the cards that have been added
    cards_rendered = 0
    @cards.each do |name, card_details|
      additional_classes = card_details.delete("css")
      quantity = card_details.delete("quantity")
      card_text = "<h2>#{name.to_s}</h2>"
      card_text += "<dl>"
      card_details.each do |k,v| card_text += "<dt class=\"#{k}\">#{k}</dt><dd class=\"#{k}\">#{v}</dd>"; end
      card_text += "</dl>"
      quantity.times do |i|
        # We need to create a new table every 9 cards
        @document += "<table class=\"#{card_type}\">" if (cards_rendered % 9 == 0)
        # We also need a new table row every 3 cards
        @document += "<tr>" if (cards_rendered % 3 == 0)
        # Insert the card details here
        @document += "<td class=\"card #{additional_classes}\">#{card_text}</td>"
        
        # Increment cards rendered. This may trigger HTML closing tags
        cards_rendered += 1
        @document += "</tr>" if (cards_rendered % 3 == 0)
        @document += "</table>" if (cards_rendered % 9 == 0)
      end
    end
  end
end
