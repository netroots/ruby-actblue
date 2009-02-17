module ActBlue
  
  class Page < ActiveBlue
    
    XML_NAME   =  'page'
    ATTRIBUTES =  ['name', 'partner', 'created-on']
    ELEMENTS =    ['title', 'author', 'blurb', 'visibility', 'showcandidatesummary', 'listentries']
    
    def self.get(params)
      hash = ActiveBlue.get('/pages', :query => params)
      result = []
      if hash["pages"]
        hash["pages"].each do |h|
          result << Page.new(h)
        end
      elsif hash["page"]
        result << Page.new(hash["page"])
      end
      result
    end
    
    def post
      super.post('/pages', :body => to_xml)
    end
    
    def put
      super.put('/pages', :body => to_xml)
    end
    
  end
  
end