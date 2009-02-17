module ActBlue
  
  class Source < ActiveBlue
    
    XML_NAME   =  'source'
    ATTRIBUTES =  []
    ELEMENTS =    ['firstname', 'lastname', 'addr1', 'addr2', 'city', 'state', 'zip', 'country', 'employer', 'occupation', 'empaddr1', 'empaddr2', 'empcity', 'empstate', 'empzip', 'empcountry', 'email', 'phone']
    
  end
  
end