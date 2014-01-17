require 'template'

describe "Template" do

  let!(:destination) { "spec/data/export" }
  let!(:template) { Template.new(destination) }

  describe "Constructor" do
    it "cannot instantiate with no arguments" do
      expect { Template.new }.to raise_error(ArgumentError)
    end

    it "instantiates with a destination path" do
      expect(Template.new(destination)).to be_instance_of(Template)
    end
  end

  describe "Attributes" do
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
    
    context "when rendering" do
      it "has a render method" do
        expect(template).to respond_to(:render)
      end
    end
  end
  
end
