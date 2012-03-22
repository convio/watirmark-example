module Salesforce
  LeadModel = Struct.new(*LeadView.keywords) do

    include Model::Simple

    def defaults
      {
        :email => "foobar@nullmail.com",
        :phone => "123-456-7890",
      }
    end


  end

  ConvertLeadModel = Struct.new(*ConvertLeadView.keywords) do

    include Model::Simple

    def defaults
      {
        :dont_create_opp => true
      }
    end

  end
end