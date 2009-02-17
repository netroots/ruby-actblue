module ActBlue
  
  class LineItem < ActiveBlue
    
    XML_NAME = 'lineitem'
    ATTRIBUTES = ['id','effective-at','visibility']
    ELEMENTS = ['amount', 'fee', 'entity']
    
  end
  
end