module ActBlue
  
  class Page < ActiveBlue
    
    XML_NAME   =  'page'
    ATTRIBUTES =  ['name', 'partner', 'created-on']
    ELEMENTS =    ['title', 'author', 'blurb', 'visibility', 'showcandidatesummary', 'listentries']
    
    def post
      ActiveBlue.post('/pages', :body => to_xml)
    end
    
    def put
      ActiveBlue.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
    def delete
      @variables['visibility'] = "archived"
      ActiveBlue.put("/pages/#{@variables['name']}", :body => to_xml) if @variables['name']
    end
    
  end
  
end