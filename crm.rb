require "debugger"

require_relative "contact"
require_relative "rolodex"

class CRM

  attr_reader :user_selected

  def initialize(name)
    @name = name
  end

  def print_main_menu
    puts "\e[H\e[2J"
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute" 
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.chomp.to_i
    call_option(user_selected)
  end

  def call_option user_selected
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    delete_contact if user_selected == 3
    display_all_contacts if user_selected == 4
    display_attribute if user_selected == 5
    exit_app if user_selected == 6
  end

  def add_new_contact
    # print "Enter First Name: "
    # first_name = gets.chomp.downcase
    # print "Enter Last Name: "
    # last_name = gets.chomp.downcase
    # print "Enter Email Address: "
    # email = gets.chomp.downcase
    # print "Enter a Note: "
    # note = gets.chomp.downcase
    
    # TEST-------
    first_name = "James"
    last_name = "Bond"
    email = "jamesbond@mi6.gov.uk"
    note = "This guys is badass!"
    # /TEST-------

    contact = Contact.new(first_name, last_name, email, note)
    Rolodex.add_contact(contact)
    Rolodex.contacts
  end

  def modify_existing_contact
  end

  def delete_contact
  end

  def display_all_contacts
  puts "\e[H\e[2J"
  contacts = Rolodex.contacts
  counter = 1
  contacts.each {|contact|
    p "[#{counter}] #{contact.first_name} #{contact.last_name}"
    counter += 1
  }
  pause
  end

  def exit_app
    puts "Bye!" 
    exit
  end

  def pause
    p "Press ENTER to continue"
    continue = nil
    until continue == "\n"
     continue = gets 
    end
  end

end

crm_app = CRM.new("My First CRM")
crm_app.main_menu

while crm_app.user_selected != 6
  crm_app.main_menu
end
