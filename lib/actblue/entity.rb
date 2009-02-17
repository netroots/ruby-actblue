module ActBlue
  
  class Entity < ActiveBlue
    
    XML_NAME  =   'entity'
    ATTRIBUTES =  ['id']
    ELEMENTS =    ['legalname', 'displayname', 'sortname', 'jurisdiction', 'govid', 'prefacewiththe', 'donate', 'kind', 'state', 'party', 'url', 'visible','candidacy']
    
  end
  
end