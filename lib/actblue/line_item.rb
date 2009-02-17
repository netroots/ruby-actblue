module ActBlue
  
  class LineItem < ActiveBlue
    
    XML_NAME = 'lineitem'
    ATTRIBUTES = ['id','effective-at', 'status', 'visibility']
    ELEMENTS = ['amount', 'fee', 'entity', 'aq-fee', 'premium-fee', 'processing-fee', 'jurisdiction']
    
  end
  
end