class Product < ApplicationRecord
    has_many :line_items, dependent: :destroy
    validates :name, :price, presence: true

end
