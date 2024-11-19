class Language < ApplicationRecord
  has_many :pages, dependent: :destroy
end
