require 'spec_helper'

describe "Automating the Lead Conversion" do

  before :all do
    @model = LeadModel.new
    @model[:first_name] = "Art"
    @model[:last_name] = "Vandelay"
    @model[:company] = "Vandelay Industries"

    @lead = Lead.new(@model)

    Login.new(LoginModel.new).login
  end

  it "can be created and converted to a contact" do
    @lead.get
    @lead.convert
  end

end