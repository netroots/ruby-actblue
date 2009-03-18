module ActBlue 
  
  class Contribution < ActiveBlue
    
    XML_NAME = 'contribution'
    ATTRIBUTES = ['order-number', 'created-on']
    ELEMENTS = ['page', 'refcode', 'source', 'timestamp', 'submitter', 'recurring', 'recurringtimes', 'referrer', 'successuri', 'lineitems']

    def self.get(params)
      hash = ActiveBlue.get('/contributions', :query => params)
      unless hash
        return nil
      end
      return hash["contributions"] if ((params["view"] == "summary") || (params[:view] == "summary"))
      result = []
      if hash["contributions"] && hash["contributions"]["contribution"]
        if hash["contributions"]["contribution"].is_a?(Hash)
          result << Contribution.new(hash["contributions"]["contribution"])
        else
          hash["contributions"]["contribution"].each do |h|
            result << Contribution.new(h)
        end
      elsif hash["contribution"]
        result << Contribution.new(hash["contribution"])
      end
      result
    end

  end
  
end