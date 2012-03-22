module Salesforce
  class Lead < SFController

    @view = Salesforce::LeadView
    @model = Salesforce::LeadModel

  end
end
