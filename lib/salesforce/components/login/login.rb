module Salesforce
  class Login < SFController

    @view = Salesforce::LoginView
    @model = Salesforce::LoginModel

    alias :login :create

    def submit
      @view.login.click
    end

  end
end