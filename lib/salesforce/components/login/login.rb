module Salesforce
  class Login < SFController

    @view = Salesforce::LoginView

    alias :login :create

    def submit
      @view.login.click
    end

  end
end