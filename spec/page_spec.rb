require File.dirname(__FILE__) + '/spec_helper'

describe ActBlue::Page do
  
  before(:each) do
    # Nothing for now
  end
  
  describe "#initialize" do
    it "should create an object" do
      page = Page.new(:title => "test")
      page.should be_an_instance_of Page
      page['title'].should eql "test"
    end
    
    it "should automatically marshall certain types directly" do
       page = Page.new(:title => "test title", "listentries" => {"listentry" => {:blurb => "body one"}})
       page['listentries'].size.should eql 1
       page['listentries'].each do |l|
         l.class.name.should eql 'ActBlue::ListEntry'
       end
       page['listentries'][0]['blurb'].should eql "body one"
     end
    
    it "should automatically marshall certain types with collections" do
      page = Page.new(:title => "test title", "listentries" => {"listentry" => [{:blurb => "body one"}, {:blurb => "body two"}]})
      page['listentries'].size.should eql 2
      page['listentries'].each do |l|
        l.class.name.should eql 'ActBlue::ListEntry'
      end
      page['listentries'][0]['blurb'].should eql "body one"
      page['listentries'][1]['blurb'].should eql "body two"
    end
  end
  
  describe "#to_xml" do
    it "should describe the contribution in xml" do
      page = ActBlue::Page.new('name' => 'a', 'title' => 'b')
      page.to_xml.should eql "<page name='a'><title>b</title></page>"
    end
    
    it "should describe the contribution in xml and correctly marshall child elements" do
      @listentries = []
      @listentries << ListEntry.new(:blurb => "kyle")
      page = ActBlue::Page.new('name' => 'a', 'title' => 'b', 'listentries' => @listentries)
      page.to_xml.should eql "<page name='a'><title>b</title><listentries><listentry><blurb>kyle</blurb></listentry></listentries></page>"
    end
  end
  
end