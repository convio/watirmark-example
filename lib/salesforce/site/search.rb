module Salesforce
  module Search

    #TODO: Clean up and condenee

    # Searches for record specified by searchstring and searchgroup.
    # Searches first in recent items, then using search "popup".
    # Returns true/false indicating whether record was found.
    #--
    # What is the intention of the argument to this search?
    # Only one secion of code sets it to FALSE, all others default to TRUE?
    # FALSE is in "/common_ground/lib/common_ground/fixtures/SalesForceObjects.rb"
    def search(rasta, select_item_if_found = true)
      fail Watirmark::TestError, 'search needs :searchgroup value' unless rasta[:searchgroup]
      fail Watirmark::TestError, 'search needs :searchstring value' unless rasta[:searchstring]
      # Check the recent item list first
      # WHY DOESN'T THIS TAKE THE "select_item_if_found" FLAG???
      if rasta[:searchstring].size > 77 #anything over size 77 gets truncated
        rasta[:searchstring] = rasta[:searchstring][0,77]
      end
      return true if look_in_recent_items(rasta[:searchgroup], rasta[:searchstring])
      # Check the search widget
      return true if look_in_search_popup(select_item_if_found, rasta)
      puts("SF::SEARCH - DID NOT FIND ANYTHING")
      false
    end

    # Locates a row within a Salesforce object list. Uses the searchstring to
    # determine which row to select and selects column 1 (the "action" column)
    # unless otherwise specified.
    def search_list(header, searchstring, colnum = 1)
      show_more_link = Page.browser.link(:text, /Show \d+ more /)
      while show_more_link.exists? && show_more_link.enabled?
        show_more_link.click
        show_more_link = Page.browser.link(:text, /Show \d+ more /)
      end
      if Page.browser.h3(:text, header).exists?
        element = Page.browser.h3(:text, header)
      else
        element = Page.browser.h2(:text, header)
      end
      element = element.parent until element.class_name == 'pbHeader'
      element.nextsibling.row(:has_cell, searchstring)[colnum]
    end

    private
    # Given the search group and search string, look in the recent items section of the sidebar
    # if we found what we were looking for, then click it and return true, else return false.
    # This ends up on the view page for the record.
    def look_in_recent_items(searchgrp, searchstr)

      # When we search the "recent items" area we use a regular expession built from the
      # the "searchgrp" and the "searchstr" arguments. The reqular expression is built with:

      # 1) The "searchgrp" argument is manipulated so that we have the original value and a
      # "singular" version of that value. This means we want to look for a match for either
      # "Accounts" (the original) or "Account" a singular version we create. From what I
      # have seen, the "recent items" list has only singular, but I am not going to change
      # the "look for both" putsic yet.

      # Here we use a smart way to turn the "searchgrp" string into a singular form of the
      # string. This works for both "Accounts" and "Batches" As mentioned before, we then look
      # for a match using both strings.
      searchgroup_orig = searchgrp
      searchgroup_singular = searchgrp.gsub(/s$/,"")

      # 2) Here we assume a searchstring string may have REGULAR EXPRESSION
      # characters ( .|()[]{}+\^$*?) and we need to escape them. Only
      # time I saw this was escaping a "blank char" in multi-word string.
      searchstring = Regexp.escape(searchstr)
      #puts("SF::SEARCH - escaped the search string - result is \"#{searchstring}\" string")

      # 3) The final addition to the recent items regular expression is to
      # look for search string alone, or a search string with some date
      # appeneded to the string.
      #    - "searchgroup: searchstring" or
      #    - "searchgroup: searchstring\s+##/##/####"
      #puts("SF::SEARCH - searching recent with \"(#{searchgroup_orig} OR #{searchgroup_singular}): #{searchstring}($|\s+\d{2}\/\d{2}\/\d{4})\" pattern string")

      # locate the sidebar
      sidebar_div = Page.browser.div(:class, 'sidebarModule recentItemModule')

      # search the sidebar
      sidebar_image = sidebar_div.image(:alt, /(#{searchgroup_orig}|#{searchgroup_singular}): #{searchstring}($|\s+\d{2}\/\d{2}\/\d{4})/)

      # did we find it?
      if sidebar_div.exists? && sidebar_image.exists?
        begin
          sidebar_link = sidebar_image.nextsibling
          if sidebar_link.exists?
            sidebar_link.click
            return true
          end
        rescue WIN32OLERuntimeError
          puts("SF::SEARCH: failed with a WIN32OLERuntimeError")
          # ignore and try a standard search. Not sure why this happens
          # but nextsibling here sometimes gives this error
        end
      end
      false
    end

    #TODO: change refs to SFView to SFView and add keywords to SFView
    def chatter_search(select_item, rasta)
      begin
        url = Page.browser.url
        SFView.chatter_search_term.focus
        SFView.chatter_search_term = ''
        SFView.chatter_search_term = rasta[:searchstring]
        SFView.chatter_search_button.click_no_wait
        # This is a little complicated. What happens is that in some environments, when
        # running a series of chatter searches (which is common in cleanup routines), Salesforce
        # will choke and never load the page that has the search request (browser stuck waiting for site).
        # This causes the scripts to run unreliably, so we've added this wait putsic to trap this
        # scenario and set up for a retry. Since it was hanging on Page.browser.wait
        # we needed a little different putsic to trap the broken state while at least waiting
        # some amount of time for the page to load
        Watir::Wait.until(5) {url != Page.browser.url && Page.browser.document.readystate == 'complete'}
        Page.browser.wait
      rescue Watir::Wait::TimeoutError
        Page.browser.refresh
        retry
      end

      # Scope search option to all data types
      if SFView.chatter_options_frame.exists?
        SFView.chatter_option_all.value = true
        SFView.chatter_option_save.click
      end

      unless Page.browser.text =~ /(No matches found|No recent records)\./
        searchgroup = SFView.search_list_section(rasta[:searchgroup])
        if searchgroup
          list_link = SFView.search_list_link(searchgroup, rasta[:searchstring])
          if list_link.exists?
            list_link.click if select_item
            return true
          end
        end
      end
      false
    end

    # Navigates to the view page for the specified record. Returns false if unsuccessful.
    def look_in_search_popup(select_item, rasta)
      default_retries = 5
      default_waittime = 1
      rasta[:retries] = (rasta[:retries] == nil) ? default_retries : rasta[:retries].to_i
      rasta[:waittime] = (rasta[:waittime] == nil) ? default_waittime : rasta[:waittime].to_i
      actual_retries = 0
      loop do
        found = chatter_search(select_item, rasta)
        return found if found
        sleep rasta[:waittime] unless rasta[:retries] == 0
        actual_retries += 1
        break if actual_retries > rasta[:retries]
      end
      false
    end

  end
end
