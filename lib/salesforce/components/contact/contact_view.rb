module Salesforce
  class ContactView < SFView

    keyword(:contact_tab)    {browser.link(:title,"Contacts Tab")}

    #fields
    keyword(:salutation)    {browser.select_list(:name,"name_salutationcon2")}
    keyword(:first_name)    {browser.text_field(:name,"name_firstcon2")}
    keyword(:last_name)     {browser.text_field(:name,"name_lastcon2")}
    keyword(:account_name)  {browser.text_field(:name,"con4")}
    keyword(:title)         {browser.text_field(:name,"con5")}
    keyword(:phone)         {browser.text_field(:name,"con10")}
    keyword(:mobile)        {browser.text_field(:name,"con12")}
    keyword(:email)         {browser.text_field(:name,"con15")}

    class << self

      def home(model)
        contact_tab.click
      end

      def search_params(model)
        searchstring = (model[:first_name] + " " + model[:last_name]).strip
        model.merge!({:searchgroup => "Contact",:searchstring => searchstring})
      end

    end

  end
end
