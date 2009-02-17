require 'rubygems'
require 'net/https'
require 'cgi'
require 'httparty'
require 'rexml/document'

class REXMLUtilityNode
  def undasherize_keys(params)
    params
  end
end

module HTTParty
  class Request
    def parse_response(body)
      return nil if body.nil? or body.empty? or body.strip.empty?
      case format
        when :xml
          HTTParty::Parsers::XML.parse(body)
        when :json
          HTTParty::Parsers::JSON.decode(body)
        when :yaml
          YAML::load(body)
        else
          body
        end
    end
  end
end

module ActBlue
  
  ACTBLUE_VERSION = "2007-10-1"
  ACTBLUE_URL = "https://secure.actblue.com"
  
  class ActiveBlue
    include HTTParty
    format :xml
    base_uri "#{ACTBLUE_URL}/#{ACTBLUE_VERSION}"
    basic_auth ENV['ACTBLUE_USER'], ENV['ACTBLUE_PASS'] if (ENV['ACTBLUE_USER'] && ENV['ACTBLUE_PASS'])
    headers 'Accept' => 'application/xml'
    
    attr_accessor :variables
  
    ACT_TYPES = {
      'source' => 'Source', 
      'page' => 'Page', 
      'lineitem' => 'LineItem', 
      'lineitems' => lambda {|hash| if (hash.is_a?(Array) && hash.first.class.name == "ActBlue::LineItem") then return hash end; collection = []; if hash['lineitem'].is_a?(Hash) then collection << LineItem.new(hash['lineitem']); else hash['lineitem'].each {|l| collection << LineItem.new(l); }; end; return collection; },
      'entity' => 'Entity', 
      'instrument' => 'Instrument', 
      'election' => 'Election',
      'expires' => 'Expires',
      'listentry' => 'ListEntry',
      'listentries' => lambda {|hash| if (hash.is_a?(Array) && hash.first.class.name == "ActBlue::ListEntry") then return hash end; collection = []; if hash['listentry'].is_a?(Hash) then collection << ListEntry.new(hash['listentry']); else hash['listentry'].each {|l| collection << ListEntry.new(l); }; end; return collection; },
      'creditcard' => 'CreditCard',
      'check' => 'Check',
      'candidacy' => 'Candidacy',
      'office' => 'Office'
    }
  
    def initialize(params = {})      
      @variables = {}
      params.each do |key, value|  
        if value
          if ACT_TYPES[key.to_s] && ACT_TYPES[key.to_s].is_a?(Proc)
            collection = []
            collection = ACT_TYPES[key.to_s].call(value) if !value.empty?
            @variables[key.to_s] = collection
          elsif ACT_TYPES[key.to_s] && value.is_a?(Hash)
            @variables[key.to_s] = Object.const_get(ACT_TYPES[key.to_s]).new(value)
          else  
            @variables[key.to_s] = value
          end
        end
      end
    end
  
    def [](key)
      @variables[key]
    end
  
    def []=(key, val)
      @variables[key] = val
    end
    
    def to_xml
      doc = REXML::Document.new
      doc.add_element(to_xml_element)
      output = ""
      doc.write(output)
      output
    end
    
    def to_xml_element
      element = REXML::Element.new(self.class::XML_NAME)
      self.class::ATTRIBUTES.each do |a|
        element.add_attribute(a, @variables[a]) if @variables[a]
      end
      self.class::ELEMENTS.each do |e|
        if @variables[e]
          if ACT_TYPES[e] && ACT_TYPES[e].is_a?(Proc)
            parentElement = REXML::Element.new(e)
            @variables[e].each do |c|
              if c.methods.include? "to_xml_element"
                parentElement.add_element(c.to_xml_element)
              end
            end
            element.add_element(parentElement)
          else
            if @variables[e].methods.include? "to_xml_element"
              element.add_element(@variables[e].to_xml_element)
            else
              newElement = REXML::Element.new(e)
              newElement.text = @variables[e]
              element.add_element(newElement)
            end
          end
        end
      end
      element
    end
    
  end
  
end

Dir["#{File.dirname(__FILE__)}/actblue/*.rb"].each { |source_file| require source_file }