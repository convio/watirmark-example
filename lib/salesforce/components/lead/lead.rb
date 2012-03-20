module Salesforce
  class Lead < SFController

    @view = Salesforce::LeadView

    def submit
      @view.save_button.click
    end
  end
end
