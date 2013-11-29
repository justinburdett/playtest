require 'template'

describe "Template" do

  let!(:default_html) { "spec/data/default.html" }
  let!(:default_css) { "spec/data/default.css" }

  describe "Constructor" do
    it "instantiates with no arguments" do
      expect(Template.new).to be_instance_of(Template)
    end
    it "can override the html source" do
      expect(Template.new(default_html)).to be_instance_of(Template)
    end
    it "can override the css source" do
      expect(Template.new(nil, default_css)).to be_instance_of(Template)
    end
  end

  describe "Attributes" do
    let!(:template) { Template.new(default_html, default_css) }
    
    it "allows public access to html and css source filenames" do
      expect(template.html).to eq(default_html)
      expect(template.css).to eq(default_css)
    end
    
    it "allows public access to the document content" do
      expect(template).to respond_to(:document)
    end
    
    context "while tracking card additions" do
      it "tracks both unique and total cards" do
        expect {
          template << {"name" => "foo"}
          template << {"name" => "bar", "quantity" => 2}
        }.to (change{template.total_cards}.by(3) && change{template.unique_cards}.by(2))
      end
    
      it "gracefully handles redundant additions" do
        expect {
          template << {"name" => "foo"}
          template << {"name" => "foo"}
        }.to (change{template.total_cards}.by(2) && change{template.unique_cards}.by(1))
      end
    end
  end

  describe "Methods" do
    let!(:template) { Template.new(default_html, default_css) }
    
    context "when inserting new records via the << method" do
    
      it "inserts them into the cards store, tracked by unique_cards" do
        expect(template).to respond_to(:<<)
        expect {
          template << {"name" => "foo", "quantity" => 1}
        }.to change{template.unique_cards}.by(1)
      end
    
      context "when it is not provided values" do
        it "defaults the :name property" do
          expect {
            template << {"quantity" => 1}
          }.to change{template.unique_cards}.by(1)
        end
        it "defaults the :quantity property" do
          expect {
            template << {"name" => "nothing more"}
          }.to change{template.unique_cards}.by(1)
        end
      end
      
    end
    
    context "when outputting" do
      describe "html format" do
        it "has a to_html method" do
          expect(template).to respond_to(:to_html)
        end
        it "dumps the results to an html file" do
          pending("Stub out filesystem operations")
        end
      end
      
      describe "pdf format" do
        it "has a to_pdf method" do
          expect(template).to respond_to(:to_pdf)
        end
        it "dumps the results to a PDF file" do
          pending("Check PDFKit API docs for test case details")
        end
      end
    end
  end
  
end
