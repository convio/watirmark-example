module Salesforce
  LoginModel = Struct.new(*LoginView.keywords) do
    include Model::Simple
    def defaults
      {
        :username => config.username,
        :password => config.password,
      }
    end
  end
end