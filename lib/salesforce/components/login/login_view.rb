module Salesforce
  class LoginView < SFView

    keyword(:username) {browser.text_field(:name,"username")}
    keyword(:password) {browser.text_field(:name,"pw")}
    keyword(:login)    {browser.button(:name,"Login")}

    class << self

      def create(hash)
        browser.goto "#{config.url}"
      end

    end

  end
end