class Contact
  
  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  def modify_unit unit, new_unit
    
    case unit
      when "first_name"
        @first_name = new_unit
      when "last_name"
        @last_name = new_unit
      when "email"
        @email = new_unit
      when "notes"
        @notes = new_unit
    end
  end
end