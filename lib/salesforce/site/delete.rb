module Salesforce
  module Delete

    # Deletes the displayed record and returns true
    # Raises an exception:
    #  if we can't find a delete button OR
    #  if the system gives an error after we try the delete
    def delete_active_record
      # throw an exception unless we are on a page with a delete button
      raise(
        Watirmark::TestError,
        "Error: Delete button was not found."
      ) unless @browser.button(:name, 'del').exists?

      # click the delete button
      Watir::Wait.until {@browser.button(:name, 'del').exists?}
      delete_item(@browser, :button)
    end

    def confirm_delete
      @browser.wait
      Page.browser.button(:value, "Confirm Permanent Delete").click if Page.browser.button(:value, "Confirm Permanent Delete").exists?
      sleep 5
    end

    def check_for_delete_error
      @browser.wait
      header = Page.browser.h1(:class => 'pageType', :text => /^Deletion problems/)
      if header.exists?
        message = Page.browser.table(:class => 'list').text
        raise Watirmark::DeleteError, "Deletion Problems: " + message
      end

      error = Page.browser.row(:class => 'dataCell', :text => /cannot be deleted.$/)
      if error.exists?
        message = error.text
        raise Watirmark::DeleteError, message
      end
    end

    def delete_item(context, type)
      @browser.wait
      case type
        when :button
          context.button(:value, 'Delete').click_no_wait
        when :link
          context.link(:text, 'Del').click_no_wait
        else
          raise TestError, "Delete button not found"
      end
      close_dialog
      confirm_delete
      check_for_delete_error
    end

  end
end
