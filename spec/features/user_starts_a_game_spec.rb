require 'rails_helper'

describe "starting a new game", type: :feature do
  before :each do
    visit '/'
    click_button 'Click to Play'
  end

  it "has a new board on the page" do
    expect(page).to have_css '#board'
  end
end