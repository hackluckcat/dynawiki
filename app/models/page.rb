class Page < ApplicationRecord
  belongs_to :language
  has_many :references, dependent: destroy
end
