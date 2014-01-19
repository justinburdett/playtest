puts $LOAD_PATH
require 'pdf_template'

describe "PdfTemplate" do

  let!(:destination) { "spec/data/export.pdf" }
  let!(:template) { PdfTemplate.new(destination) }
  
  describe "Constructor" do
    it "instantiates with an export filename" do
      expect(PdfTemplate.new(destination)).to be_instance_of(PdfTemplate)
    end
  end

  describe "Methods" do
    context "when outputting" do
      describe "pdf format" do
        it "dumps the results to a PDF file" do
          pending("Check PDFKit API docs for test case details")
        end
      end
    end
  end
  
end
