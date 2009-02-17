module ActBlue
  
  class Page < ActiveBlue
    
    XML_NAME   =  'page'
    ATTRIBUTES =  ['name', 'partner', 'created-on']
    ELEMENTS =    ['title', 'author', 'blurb', 'visibility', 'showcandidatesummary', 'listentries']
    
    def post
      super.post('/pages', :body => to_xml)
    end
    
    def put
      super.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
    def delete
      @variables['visibility'] = "archived"
      super.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
  end
  
end