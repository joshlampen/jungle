require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves when name, price, quantity, and category fields are set correctly' do
      @category = Category.new(
        id: 1,
      )
      @category.save!

      @product = Product.new(
        name: 'LG TV',
        price_cents: 100000,
        quantity: 10,
        category_id: 1
      )
      @product.save!

      expect(@product.id).to be_present
    end

    it 'does not save if the name field is nil' do
      @category = Category.new(
        id: 1,  
      )
      @category.save!

      @product = Product.new(
        name: nil,
        price_cents: 100000,
        quantity: 10,
        category_id: 1
      )
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'does not save if the price field is nil' do
      @category = Category.new(
        id: 1,  
      )
      @category.save!

      @product = Product.new(
        name: 'LG TV',
        price_cents: nil,
        quantity: 10,
        category_id: 1
      )
      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'does not save if the quantity field is nil' do
      @category = Category.new(
        id: 1,  
      )
      @category.save!

      @product = Product.new(
        name: 'LG TV',
        price_cents: 100000,
        quantity: nil,
        category_id: 1
      )
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'does not save if the category field is nil' do
      @category = Category.new(
        id: 1,  
      )
      @category.save!

      @product = Product.new(
        name: 'LG TV',
        price_cents: 100000,
        quantity: 10,
        category_id: nil
      )
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end