require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

  # SETUP
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

  scenario "Can add product to cart" do
    # ACT
    visit root_path

    click_on('Add', match: :first)
    sleep 1
    save_screenshot 'after_clicking_add_button.png'

    expect(page).to have_text 'My Cart (1)'
  end

end
