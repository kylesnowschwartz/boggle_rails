require 'rails_helper'

describe "starting a new game", type: :feature do
  before :each do
    visit '/'
    click_button 'Click to Play'
  end

  it "has a new board on the page" do
    expect(page).to have_css '#board'
  end

  it "has instructions on the page" do
    expect(page).to have_css '.scoring_instructions'
  end

  it "has a text box on the page" do
    expect(page).to have_css '#user_input'
  end

  it "has a submit button for the text area" do
    expect(page).to have_css '.submit_user_input'
  end
end