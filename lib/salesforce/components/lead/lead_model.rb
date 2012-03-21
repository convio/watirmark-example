module Salesforce
  LeadModel = Struct.new(*LeadView.keywords) do

    include Model::Simple

    def defaults
      {
        #:salutation => "Mr.",
        :email => "foobar@nullmail.com",
        :phone => "123-456-7890",
      }
    end

  end
end