require_relative 'tools'

class Contact
  
  include Tools

  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  def print
    puts "[#{@id-999}] #{@first_name} #{@last_name}"
  end

  def print_details

    puts "CONTACT DETAILS"
    line
    puts "ID No. \t#{@id-999}"
    puts "First Name: \t#{@first_name}"
    puts "Last Name: \t#{@last_name}"
    puts "Email: \t\t#{email}"
    puts "Note: \t\t#{note}"

  end
end