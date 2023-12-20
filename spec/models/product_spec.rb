require 'rails_helper'

describe 'Product model should work', type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Electronics') # Creating a category for testing
      @product = Product.new(
        name: 'Example Product',
        price: 20.00,
        quantity: 10,
        category: @category
      )
    end

    it 'saves successfully with all four fields set' do
      expect(@product.save).to be true
    end

    it 'requires the presence of name' do
      @product.name = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires the presence of price' do
      @product.price_cents = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'requires the presence of quantity' do
      @product.quantity = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'requires the presence of category' do
      @product.category = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end