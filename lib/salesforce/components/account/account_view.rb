module Salesforce
  class AccountView < SFView

    keyword(:account_tab)    {browser.link(:title,"Accounts Tab")}

    #fields
    keyword(:account_name) {browser.text_field(:name,"acc2")}
    keyword(:phone)        {browser.text_field(:name,"acc10")}
    keyword(:fax)          {browser.text_field(:name,"acc11")}
    keyword(:website)      {browser.text_field(:name,"acc12")}

    class << self

      def home(model)
        account_tab.click
      end

      def search_params(model)
        searchstring = (model[:account_name]).strip
        model.merge!({:searchgroup => "Accounts",:searchstring => searchstring})
      end

    end

  end
end
