require 'rails_helper'

RSpec.describe "Movie Index" do
  before :each do
    @user = User.create!(email: "andrewpatrick138@gmail.com", password: "cowboy1138")
    @user_2 = User.create!(email: "marky123@gmail.com", password: "spacemonkey123")
    @user_3 = User.create!(email: "BrianZ123@gmail.com", password: "happymonkey123")
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/discover'
  end

  it "displays top rated movies" do

    click_button "Find Top Rated Movies"

    expect(current_path).to eq(movies_path)
    expect(page.status_code).to eq(200)

    expect(page).to have_content("")
  end
end