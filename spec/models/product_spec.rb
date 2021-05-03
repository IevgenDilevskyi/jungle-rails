require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it "should save new product successfully" do
      @category = Category.new( :id => 1)
      @category.save
      @product = Product.new(:name => 'Test_product', :price => "1000", :quantity => 55, :category_id => 1)
      @product.save!
      expect(@product).to be_present
    end

    it "should return error about empty Name field" do
      @category = Category.new( :id => 1)
      @category.save
      @product = Product.new(:price => "1000", :quantity => 55, :category_id => 1)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should return error about empty Price field" do
      @category = Category.new( :id => 1)
      @category.save
      @product = Product.new(:name => 'Test_product', :quantity => 55, :category_id => 1)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should return error about empty Quantity field" do
      @category = Category.new( :id => 1)
      @category.save
      @product = Product.new(:price => "1000", :name => 'Test_product', :category_id => 1)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should return error about empty Category field" do
      @category = Category.new( :id => 1)
      @category.save
      @product = Product.new(:price => "1000", :quantity => 55, :name => 'Test_product')
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
