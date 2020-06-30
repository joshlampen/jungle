require 'rails_helper'

RSpec.feature "Visitor can login with an existing account", type: :feature, js: true do
  
  # setup fake database
  before :each do
    @user = User.create!(
      first_name: 'Josh',
      last_name: 'Lampen',
      email: 'joshlampen@gmail.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  scenario 'They are redirected to the home page with their name in the nav bar after successful login' do
    visit '/login'

    fill_in 'email', with: 'joshlampen@gmail.com'
    fill_in 'password', with: '12345678'
    

    find('.col-sm-6').click_on 'Login' # this class is used for the form containing the 'Login' submit button

    expect(page).to have_current_path('/')
    expect(page).to have_content 'Signed in as Josh'
  end

end