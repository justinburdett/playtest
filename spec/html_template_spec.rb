require 'html_template'

describe "HtmlTemplate" do

  let!(:destination) { "spec/data/default.html" }
  let!(:default_css) { "spec/data/default.css" }

  describe "Constructor" do
    it "instantiates with a specified output file" do
      expect(HtmlTemplate.new(destination)).to be_instance_of(HtmlTemplate)
    end
    it "can override the css source" do
      expect(HtmlTemplate.new(destination, default_css)).to be_instance_of(HtmlTemplate)
    end
  end

  describe "Attributes" do
    let!(:template) { HtmlTemplate.new(destination, default_css) }
    
    it "allows public access to html and css source filenames" do
      expect(template.destination).to eq(destination)
      expect(template.css).to eq(default_css)
    end
  end

  describe "Methods" do
    context "when rendering html format" do
      describe "html format" do
        it "dumps the results to an html file" do
          pending("Stub out filesystem operations")
        end
      end
    end
  end
end
