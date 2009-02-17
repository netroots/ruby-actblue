module ActBlue
  
  class CreditCard < ActiveBlue
    
    XML_NAME   =  'creditcard'
    ATTRIBUTES =  []
    ELEMENTS =    ['name', 'billing-addr1', 'billing-addr2', 'billing-city', 'billing-state', 'billing-postalcode', 'account', 'expires', 'verifier']
    
  end
  
end