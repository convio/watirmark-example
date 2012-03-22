module Salesforce
  class SFController < Watirmark::WebPage::Controller
    include Watirmark::WebPage
    include Salesforce::Delete

    def submit
      @view.save_button.click
    end

    def delete
      super
      delete_active_record
    end

  end
end