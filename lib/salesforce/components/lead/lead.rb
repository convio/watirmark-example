module Salesforce
  class Lead < SFController

    include Salesforce::Delete

    @view = Salesforce::LeadView
    @model = Salesforce::LeadModel

    def submit
      @view.save_button.click
    end

    def delete
      super
      delete_active_record
    end

  end
end
