require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates presence of name' do
      product = Product.new( price: 100, quantity: 10, category: Category.new(name: "test") )
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of price' do
      product = Product.new( name: "test", quantity: 10, category: Category.new(name: "test") )
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end

    it 'validates presence of quantity' do
      product = Product.new( name: "test", price: 100, category: Category.new(name: "test") )
      expect(product).not_to be_valid
      expect(product.errors[:quantity]).to include("can't be blank")
    end

    it 'validates presence of category' do
      product = Product.new( name: "test", price: 100, quantity: 10 )
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include("can't be blank")
    end

  end
end
