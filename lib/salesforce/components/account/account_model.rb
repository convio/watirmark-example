module Salesforce
  AccountModel = Struct.new(*AccountView.keywords) do

    include Model::Simple

    def defaults
      {
        :phone => "123-456-7890",
        :fax   => "999-888-7777",
      }
    end

  end
end