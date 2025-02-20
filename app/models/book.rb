class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    validates :title, :author, presence: true
    validates :status, inclusion: { in: %w[available borrowed] }
  
    def available?
      status == "available"
    end
  
    def borrowed?
      status == "borrowed"
    end
  end
  