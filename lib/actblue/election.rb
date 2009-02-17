module ActBlue
  
  class Election < ActiveBlue
    
    XML_NAME   =  'election'
    ATTRIBUTES =  ['id']
    ELEMENTS =    ['election_date','office']
    
  end
  
end