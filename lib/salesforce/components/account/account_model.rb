module Salesforce
  AccountModel = Struct.new(*AccountView.keywords) do

    include Model::Simple

    def defaults
      {
        :phone => "123-456-7890"
      }
    end

  end
end