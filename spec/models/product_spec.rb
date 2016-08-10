require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'attributes' do
    it { should respond_to :id           }
    it { should respond_to :name         }
    it { should respond_to :description  }
    it { should respond_to :category     }
    it { should respond_to :product_type }
    it { should respond_to :price        }
    it { should respond_to :created_at   }
    it { should respond_to :updated_at   }
  end

  describe 'validations' do
    it { should validate_presence_of :name         }
    it { should validate_presence_of :product_type }
    it { should validate_presence_of :category     }
    it { should validate_numericality_of :price    }

    context 'type is dish' do
      subject { build :product, product_type: Product::TYPES[:dish] }

      it { should validate_presence_of :description }
    end
  end

  describe 'scopes' do

    def check_results list, included, not_included
      expect(list).to include included
      expect(list).to_not include not_included
    end

    def check_results_for_menu cat
      other_cat    = Product::CATEGORIES - [cat]
      included     = create_list :product, 10, category: cat
      not_included = create_list :product, 10, category: other_cat.sample

      list = Product.to_menu cat
      expect(list.pluck(:category).uniq.first).to eq cat
      expect(list).to_not include not_included
      expect(list.uniq.count).to eq 4
    end

    describe '.with_name' do
      it 'has to return the products whit the requested name' do
        included     = create :product
        not_included = create :product

        list = Product.with_name included.name
        check_results list, included, not_included
      end
    end

    describe '.with_type' do
      it 'has to return the products whit the requested type' do
        dish         = Product::TYPES[:dish]
        included     = create :product, product_type: dish
        not_included = create :product, product_type: Product::TYPES[:drink]

        list = Product.with_type dish
        check_results list, included, not_included
      end
    end

    describe '.with_category' do
      it 'has to return the products whit the requested category' do
        cat          = Product::CATEGORIES.sample
        other_cat    = Product::CATEGORIES - [cat]
        included     = create :product, category: cat
        not_included = create :product, category: other_cat.sample

        list = Product.with_category cat
        check_results list, included, not_included
      end
    end

    describe '.featured_dishes' do
      it 'has to return 6 differents products' do
        create_list :product, 10
        expect(Product.featured_dishes.uniq.count).to eq 6
      end
    end

    describe '.to_menu' do
      it 'has to return 4 differents products with the same category' do
        check_results_for_menu Product::CATEGORIES.sample
      end
    end

    describe '.drinks' do
      it 'has to return 4 differents drinks' do
        check_results_for_menu 'Cocktails'
      end
    end

    describe '.mains' do
      it 'has to return 4 differents mains' do
        check_results_for_menu 'Salads & Mains'
      end
    end

    describe '.desserts' do
      it 'has to return 4 differents desserts' do
        check_results_for_menu 'Dessert'
      end
    end

    describe '.starters' do
      it 'has to return 4 differents starters' do
        check_results_for_menu 'Starters'
      end
    end
  end

  describe '#display_type' do
    it 'has to return the product type' do
      type = Product::TYPES.values.sample
      product = build :product, product_type: type
      expect(product.display_type).to eq Product::TYPES.invert[type]
    end
  end

end
