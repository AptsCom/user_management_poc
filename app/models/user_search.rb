class UserSearch

  include ActiveModel::Validations

  validates_size_of :first_name, :last_name, :email, :minimum => 2, :allow_blank => true
  validates_numericality_of :id, :only_integer => true, :allow_blank => true
  validate :criteria_present?
  attr_accessor :criteria

  def initialize(criteria = {})
    self.criteria = criteria
  end

  def read_attribute_for_validation(key)
    criteria[key]
  end

  def query
  	criteria.delete_if {|key, value| value.blank? }
  end

  def results_for
    @results = User
    user_columns = User.columns_hash
    criteria.each do |key, value|
      if user_columns[key].type == :integer
      	@results = @results.where("#{key} = ?", value)
      else	
        @results = @results.where("#{key} LIKE ?", "%#{value}%")
      end 
    end
    @results = @results.order("status ASC, last_name ASC").limit(100)
    
    @results
  end

  def completed?
    self.criteria.present? && valid?
  end

  private 

  def criteria_present?
    errors[:base] << "No search criteria specified" if query.empty?
  end
end