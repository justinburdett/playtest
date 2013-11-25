require 'pdfkit'

class Template

  attr_reader :html, :css, :document
  
  def initialize (html = "default.html", css = "default.css")  
    @html = html
    @css = css
    @document = ""
    @cards_added = 0
  end

  def <<(name, details)
    additional_classes = details.delete('css')
    quantity = details.delete('quantity') || 1
    card_text = "<dl>"
    details.each do |k,v| card_text += "<dt class=\"#{k}\">#{k}</dt><dd class=\"#{k}\">#{v}</dd>"; end
    quantity.times { @document += "<div class=\"card #{additional_classes}\"><h2>#{name}</h2>#{card_text}</div>\r\n" }
    @cards_added += quantity
    puts "Added #{quantity} '#{name}' (#{@cards_added} total)"
  end
 
  def to_html(destination = "export/exported_#{@html}")
    css_data = File.read(@css)
    export = "<html>
       <head><style type=\"text/css\" media=\"all\">#{css_data}</style></head>
       <body class=\"content\">#{@document}
       </body>
       </html>"
    File.open(destination, 'w') { |file| file.write(export) }
    puts "Saved #{@cards_added} cards to #{destination} (#{File.size?(destination)})"
  end
 
  def to_pdf(destination = "export/#{@html}.pdf")
    # Generate the PDF using the HTML we've generated
    PDFKit.configure do |config|
     config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
    end
    kit = PDFKit.new("<html><body class=\"content\">#{@document}</body></html>", :page_size => 'Letter', :print_media_type => true)

    # Add the external cards.css stylesheet to our PDF
    kit.stylesheets << @css

    # Save the PDF to our machine
    kit.to_file(destination)
    puts "Saved #{@cards_added} cards to #{destination} (#{File.size?(destination)})"
  end
end
