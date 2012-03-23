module Salesforce
  class Lead < SFController

    @view = Salesforce::LeadView

    def convert
      call_view_method(:locate,@rasta)
      cl_control = ConvertLead.new(@model)
      cl_control.create
    end

  end

  class ConvertLead < SFController

    @view = Salesforce::ConvertLeadView

    def initialize(l_model)
      cl_model = ConvertLeadModel.new
      cl_model.account_name = "Create New Account: " + l_model.company
      super(cl_model)
    end

  end
end
