module ActBlue
  
  class Office < ActiveBlue
    
    XML_NAME   =  'office'
    ATTRIBUTES =  ['id']
    ELEMENTS =    ['name','description','race_type','district','seat_count','state']
    
  end
  
end