require File.dirname(__FILE__) + '/spec_helper'

describe ActBlue::Contribution do
  
  before(:each) do
    # Nothing for now
  end
  
  describe "#initialize" do
    it "should create an object" do
      contrib = Contribution.new(:refcode => "test")
      contrib.should be_an_instance_of Contribution
      contrib['refcode'].should eql "test"
    end
    
    it "should automatically marshall certain types" do
      contrib = Contribution.new(:source => {:firstname => "kyle", :lastname => "shank"})
      contrib['source'].class.name.should eql 'ActBlue::Source'
      contrib['source']['firstname'].should eql "kyle"
    end
  end
  
  describe "#to_xml" do
    it "should describe the contribution in xml" do
      contribution = ActBlue::Contribution.new('order-number' => '123', 'refcode' => 'test')
      contribution.to_xml.should eql "<contribution order-number='123'><refcode>test</refcode></contribution>"
    end
    
    it "should describe the contribution in xml and correctly marshall child elements" do
      contribution = ActBlue::Contribution.new('order-number' => '123', 'refcode' => 'test', 'source' => Source.new(:firstname=>'kyle', :lastname=>'shank'))
      contribution.to_xml.should eql "<contribution order-number='123'><refcode>test</refcode><source><firstname>kyle</firstname><lastname>shank</lastname></source></contribution>"
    end
    
    it "should describe the contribution in xml and deal with a child collection of lineitems" do
      @lineitems = []
      @lineitems << LineItem.new(:amount => "12.50", :entity => Entity.new(:id => "171"))
      @lineitems << LineItem.new(:amount => "17.50", :entity => Entity.new(:id => "173"))
      
      contribution = ActBlue::Contribution.new('order-number' => '123', 'refcode' => 'test', 'lineitems' => @lineitems)
      contribution.to_xml.should eql "<contribution order-number='123'><refcode>test</refcode><lineitems><lineitem><amount>12.50</amount><entity id='171'/></lineitem><lineitem><amount>17.50</amount><entity id='173'/></lineitem></lineitems></contribution>"
    end
  end
  
  describe "#get" do
    it "should find and marshall a contribution" do
      ActBlue::ActiveBlue.should_receive(:get).and_return({"contribution" => {"refcode" => "test"}})
      
      contributions = ActBlue::Contribution.get(:refcode => "test")
      contributions.first["refcode"].should eql "test"
    end
    
    it "should find and marshall 2 contributions" do
      ActBlue::ActiveBlue.should_receive(:get).and_return({"contributions" => { "contribution" => [{"submitter" => "one", "refcode" => "test"},{"submitter" => "two", "refcode" => "test"}]}})
      
      contributions = ActBlue::Contribution.get(:refcode => "test")
      contributions.size.should eql 2
      contributions[0]["submitter"].should eql "one"
      contributions[1]["submitter"].should eql "two"
    end
    
    it "should find and marshal 1 contributions with nested lineitem" do
      ActBlue::ActiveBlue.should_receive(:get).and_return({"contributions" => { "contribution" => [{"submitter" => "one", "refcode" => "test", "lineitems" => {"lineitem" => {"amount" => "10.50", "entity" => {:id => "123"}}} }]}})
      contributions = ActBlue::Contribution.get(:refcode => "test")
      contributions.size.should eql 1
      c = contributions.first
      c['lineitems'].size.should eql 1
      c['lineitems'][0]['amount'].should eql "10.50"
      c['lineitems'][0]['entity']['id'].should eql "123"
    end
    
    it "should find and marshal 1 contributions with nested lineitems" do
      ActBlue::ActiveBlue.should_receive(:get).and_return({"contributions" => { "contribution" => [{"submitter" => "one", "refcode" => "test", "lineitems" => {"lineitem" => [{"amount" => "10.50", "entity" => {:id => "123"}}, {"amount" => "11.50", "entity" => {:id => "113"}}]} }]}})
      contributions = ActBlue::Contribution.get(:refcode => "test")
      contributions.size.should eql 1
      c = contributions.first
      c['lineitems'].size.should eql 2
      c['lineitems'][0]['amount'].should eql "10.50"
      c['lineitems'][0]['entity']['id'].should eql "123"
      c['lineitems'][1]['amount'].should eql "11.50"
      c['lineitems'][1]['entity']['id'].should eql "113"
    end
  end
  
end