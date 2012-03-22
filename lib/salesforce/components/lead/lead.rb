module Salesforce
  class Lead < SFController

    @view = Salesforce::LeadView
    @model = Salesforce::LeadModel

    def convert
      cl_control = ConvertLead.new(@model)
      cl_control.create
    end

    class ConvertLead < SFController

      @view = Salesforce::LeadView::ConvertLeadView
      @model = Salesforce::ConvertLeadModel

      def initialize(l_model)
        cl_model = ConvertLeadModel.new
        cl_model.account_name = "Create New Account: " + l_model.company
        super(cl_model)
      end

      #TODO: Find out why select list is not working
      #def populate_account_name; end
      #def verify_account_name; end

    end

  end
end
