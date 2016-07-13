class NewHigh < ActiveRecord::Base
  before_validation :blank_field, on: :create

  scope :period, -> (time_period) { where("saved_on > ?", time_period) }
  scope :monthly, -> { where("saved_on >  ?", 1.month.ago) }
  scope :by_symbol, -> { group(:symbol) }
  scope :ordered_by, -> { order('count_id DESC').count('id') }

  protected
    def blank_field
      raise 'Empty Field For AllTimeHigh' if self.symbol.blank? || self.saved_on.blank?
    end
end
