module Salesforce
  class LeadView < SFView

    keyword(:lead_tab)    {browser.link(:title,"Leads Tab")}

    #fields
    keyword(:salutation)    {browser.select_list(:name,"name_salutationlea2")}
    keyword(:first_name)    {browser.text_field(:name,"name_firstlea2")}
    keyword(:last_name)     {browser.text_field(:name,"name_lastlea2")}
    keyword(:company)       {browser.text_field(:name,"lea3")}
    keyword(:title)         {browser.text_field(:name,"lea4")}
    keyword(:lead_status)   {browser.select_list(:name,"lea13")}
    keyword(:phone)         {browser.text_field(:name,"lea8")}
    keyword(:email)         {browser.text_field(:name,"lea11")}
    keyword(:rating)        {browser.select_list(:name,"lea14")}

    class << self

      def home(model)
        lead_tab.click
      end

      def search_params(model)
        searchstring = (model[:first_name] + " " + model[:last_name]).strip
        model.merge!({:searchgroup => "Leads",:searchstring => searchstring})
      end

    end

  end

  class ConvertLeadView < SFView

    keyword(:convert_button)     {browser.button(:name,"convert")}

    #fields
    keyword(:record_owner)       {browser.text_field(:name,"owner_id")}
    keyword(:send_email)         {browser.checkbox(:pname,"sem")}
    keyword(:account_name)       {browser.select_list(:name,"accid")}
    keyword(:opp_name)           {browser.text_field(:name,"noopptt")}
    keyword(:dont_create_opp)    {browser.checkbox(:name,"nooppti")}
    keyword(:converted_status)   {browser.select_list(:name,"cstatus")}

    class << self

      def create(model)
        convert_button.click
      end

    end

  end
end

