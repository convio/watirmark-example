module Salesforce
  ContactModel = Struct.new(*ContactView.keywords) do

    include Model::Simple

    def defaults
      {
        :email => "foobar@nullmail.com",
        :phone => "123-456-7890",
      }
    end

  end
end