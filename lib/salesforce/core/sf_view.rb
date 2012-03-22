module Salesforce
  class SFView < Page

    keyword(:home_tab)    {browser.link(:title,"Home Tab")}

    #buttons
    keyword(:new_button)    {browser.button(:name,"new")}
    keyword(:edit_button)   {browser.button(:name,"edit")}
    keyword(:save_button)   {browser.button(:name,"save")}
    keyword(:delete_button) {browser.button(:name,"del")}

    #search keywords
    keyword(:chatter_options_frame)    {browser.frame(:id, 'searchScopeDialogContentId')}
    keyword(:chatter_search_term)      {browser.text_field(:id, 'phSearchInput')}
    keyword(:chatter_search_button)    {browser.button(:id, 'phSearchButton')}
    keyword(:chatter_option_all)       {chatter_options_frame.checkbox(:id, 'searchScopePage:searchForm:selectAllCheckbox')}
    keyword(:chatter_option_save)      {chatter_options_frame.button(:id, 'searchScopePage:searchForm:okButton')}

    class << self

      include Salesforce::Search

      def home(model)
        raise NoMethodError, "You must overwrite this!"
      end

      def search_params(model)
        raise NoMethodError, "You must overwrite this!"
      end

      def create(model)
        home(model)
        new_button.click
      end

      def edit(model)
        locate(model)
        edit_button.click
      end

      def exists?(model)
        search_params(model)
        search(model)
      end

      def delete(model)
        locate(model)
      end

      def locate(model)
        raise TestError, "Unable to locate record" if !exists?(model)
      end

    end

  end
end