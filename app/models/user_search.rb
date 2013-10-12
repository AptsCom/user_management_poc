class UserSearch

  include ActiveModel::Validations

  validates_presence_of :criteria
  validates_size_of :criteria, :minimum => 2

  attr_accessor :criteria

  def initialize(criteria)
    @criteria = criteria
  end

  def results_for()
    @results = User
    unless is_integer? @criteria
      @results = @results.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?","%#{@criteria}%", "%#{@criteria}%", "%#{@criteria}%")
    else
      @results = @results.where("email LIKE ? OR id = ?", "%#{@criteria}%", @criteria)
    end
    @results = @results.order("status ASC, last_name ASC").limit(100)
    
    @results
  end

  private 

  def is_integer?(obj) 
   obj.to_s.match(/\A\d+?\Z/) == nil ? false : true
  end

end