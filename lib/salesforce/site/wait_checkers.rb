# Methods that run when loading pages
# * Some make sure the page is truly loaded before returning
# * Others raise exceptions if they find an error on the page

require 'watirmark/session'

include Watirmark

module Salesforce end

#Salesforce has a javascript method that is called after the html
# body is loaded to run some ajax calls to complete the data. At the
# end of this, a comment is appended to url with the page load time
# so we can use this to know that all of the ajax has completed. 
def Salesforce.wait_for_salesforce(browser=Page.browser)
  begin
    Watir::Wait.until(15) do
      begin
        case browser.url
          when /login.salesforce.com/, /test.salesforce.com/, /my.salesforce.com\?c=/, /my.salesforce.com\/\?c=/
            browser.text_field(:name, 'pw').exists?
          when /security\/ChangePassword/
            browser.html.include?("function bodyOnUnload")
          when /maintenance\.jsp/
            Salesforce::LoginPage.continue.exists?
          when /servlet\/servlet\.Integration/
            true #FlexRecurringGift extracting from iframe
          when /salesforce\.com\/apex\/PP2/, /salesforce\.com\/apex\/CreateDemoTestOrg/
            # Partner Portal pages
            browser.html.include?("<!-- END #footerpane inserted content -->")
          when /salesforce\.com/
            browser.html.include?("<!-- page generation time") ||
            browser.html.include?("performing scheduled maintenance")
          else
            true
        end
      rescue WIN32OLERuntimeError
        # ignore
      end
    end
  # try to continue even though page not seen as loaded
  rescue Watir::Wait::TimeoutError
    puts 'page timeout loading salesforce content...continuing'
  end
end
Watirmark::IESession::POST_WAIT_CHECKERS << Proc.new {Salesforce.wait_for_salesforce(Page.browser)}

def Salesforce.check_for_login_error
  return unless Page.browser.url =~ /login.salesforce.com/
  error_div = Page.browser.div(:class => 'loginError')
  return unless error_div.exists?
  return if error_div.text =~ /You have attempted to access a page that requires a salesforce.com login/
  message = error_div.text.gsub("\r", "")
  session = Watirmark::IESession.instance
  if session.respond_to?(:buffer_post_failure) && session.buffer_post_failure
    session.post_failure = message
  else
    raise Watirmark::PostFailure, message
  end
end
Watirmark::IESession::POST_WAIT_CHECKERS << Proc.new {Salesforce.check_for_login_error}

def Salesforce.check_for_validation_errors
  if Page.browser.div(:class, 'pbError').exists?
    div = Page.browser.div(:class, 'pbError')
  else
    div = Page.browser.div(:class, /message error/)
  end

  return unless div.exists? && div.text != ""
  if div.locate.style.getAttribute('display') != 'none'
    div.locate.style.setAttribute('display', 'none') # clear error so we don't read it on the next test
    message = div.text.gsub("\r", "")
    session = Watirmark::IESession.instance
    if session.respond_to?(:buffer_post_failure) && session.buffer_post_failure
      session.post_failure = message
    else
      raise Watirmark::PostFailure, message
    end
  end
end
unless ENV['watir_browser'] == 'firefox'
  Watirmark::IESession::POST_WAIT_CHECKERS << Proc.new {Salesforce.check_for_validation_errors}
end

def Salesforce.check_for_error # e.g. "Record Deleted"
  title = Page.browser.div(:id => 'errorTitle')
  return unless title.exists?
  message = title.text + ": "
  desc = Page.browser.div(:id => 'errorDesc')
  message += desc.text if desc.exists?
  session = Watirmark::IESession.instance
  if session.respond_to?(:buffer_post_failure) && session.buffer_post_failure
    session.post_failure = message
  else
    raise Watirmark::PostFailure, message
  end
end
Watirmark::IESession::POST_WAIT_CHECKERS << Proc.new {Salesforce.check_for_error}
