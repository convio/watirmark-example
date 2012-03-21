module Salesforce
  class LeadView < SFView

    #buttons
    keyword(:new_button)    {browser.button(:name,"new")}
    keyword(:edit_button)   {browser.button(:name,"edit")}
    keyword(:save_button)   {browser.button(:name,"save")}
    keyword(:delete_button) {browser.button(:name,"del")}

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

      include Salesforce::Search

      def create(hash)
        lead_tab.click
        new_button.click
      end

      def edit(hash)
        locate(hash)
        edit_button.click
      end

      def exists?(hash)
        searchstring = (hash[:first_name] + " " + hash[:last_name]).strip
        hash.merge!({:searchgroup => "Leads",:searchstring => searchstring})
        search(hash)
      end

      def delete(hash)
        locate(hash)
      end

      def locate(hash)
        raise TestError, "Unable to locate record" if !exists?(hash)
      end

    end

  end
end
