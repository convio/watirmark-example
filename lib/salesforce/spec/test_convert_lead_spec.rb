require 'spec_helper'

describe "Automating the Lead Conversion" do

  before :all do
    @model = LeadModel.new
    @model[:first_name] = "Foo"
    @model[:last_name] = "Bar"
    @model[:company] = "Foo Bar Inc"

    @lead = Lead.new(@model)

    Login.new(LoginModel.new).login
  end

  it "can be created and converted to a contact" do
    @lead.get
    @lead.convert
  end

end