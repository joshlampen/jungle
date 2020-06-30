require 'rails_helper'

RSpec.feature "Visitor can add products to the cart", type: :feature, js: true do
  
  # setup fake database
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They see the cart size update' do
    visit root_path

    first('.product > footer > form').click

    expect(page).to have_content 'My Cart (1)'
  end

end