require 'prawn'
require_relative 'template'
class PdfTemplate < Template

  def initialize(destination)
    super(destination)
  end

  def render
    # Create the document
    pdf = ::Prawn::Document.new
    
    # Generate the PDF using the HTML we've generated
    poker_cards(pdf)

    # Save the PDF to our machine
    pdf.render_file @destination
    super
  end
  
private
  def poker_cards(pdf)
    @cards_rendered = 0
    pdf.define_grid(columns: 3, rows: 3, gutter: 0)
    @cards.each do |card|
      card_name = card[1].delete("name")
      
      card[1].delete("quantity").times {
        pdf.start_new_page if ((@cards_rendered > 0) && (@cards_rendered % 9 == 0))
        pdf.grid((@cards_rendered % 9) / 3, @cards_rendered % 3).bounding_box do |cell|
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
        @cards_rendered += 1
      }
    end
  end
end
