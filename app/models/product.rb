class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :price, :image_url, presence: true
  validates :price, numericality: {greater_then_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)$}i,
      message: 'must be a URL for GIF, JPG or PNG image.',
      multiline: true
  }

private
  # убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'there are products_line')
      return false
    end
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
