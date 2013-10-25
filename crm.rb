require_relative "contact"
require_relative "rolodex"
require_relative "tools"

class CRM

  include Tools
  attr_reader :menu_selection

  def start
    while @menu_selection != 6
      main_menu
    end
  end

  def print_main_menu
    clear
    puts "MAIN MENU"
    puts ""
    puts "[1] Add new contact"
    puts "[2] Modify existing contact"
    puts "[3] Delete contact"
    puts "[4] Display contacts"
    puts "[5] Display an attribute" 
    puts "[6] Exit"
    puts ""
    line
    puts "Where would you like to go?"
    line
  end

  def main_menu
    print_main_menu
    menu_selection = gets.chomp.to_i
    call_option(menu_selection)
  end

  def call_option menu_selection
    
    case menu_selection
    when 1
      add_new_contact
    when 2
      modify_existing_contact
    when 3
      delete_contact
    when 4
      display_all_contacts
    when 5
      display_attribute
    when 6
      exit_app
    end
  end

  def add_new_contact
    new_contact_info
    contact = Contact.new(@first_name, @last_name, @email, @note)
    Rolodex.add_contact(contact)
    Rolodex.contacts
  end

  def new_contact_info
    # print "Enter First Name: "
    # first_name = gets.chomp.downcase
    # print "Enter Last Name: "
    # last_name = gets.chomp.downcase
    # print "Enter Email Address: "
    # email = gets.chomp.downcase
    # print "Enter a Note: "
    # note = gets.chomp.downcase
    
    # FOR TESTING
    @first_name = "James"
    @last_name = "Bond"
    @email = "jamesbond@mi6.gov.uk"
    @note = "This guys is badass!"
  end

  def modify_existing_contact
    clear
    puts "MODIFY EXISTING CONTACT"
    puts ""
    loop_contacts { |contact|
      puts "[#{contact.id-999}] #{contact.first_name} #{contact.last_name}"
    }
    puts ""
    line
    puts "Which contact do you want to modify?"
    line

    input = gets.chomp.to_i+999
    modify_contact = Rolodex.find_by_id(input)
    
    clear
    puts "You selected: #{modify_contact.first_name} #{modify_contact.last_name}"
    puts ""
    puts "What attribute would you like to modify?"
    puts "[1] First Name"
    puts "[2] Last Name"
    puts "[3] Email"
    puts "[4] Note" 
    puts "[5] Cancel (back to main menu)"
    puts "Enter a number: "
    input = gets.to_i

    case input
      when 1
        unit = :first_name
      when 2
        unit = :last_name
      when 3
        unit = :email
      when 4
        unit = :note
      when 5
        exit
    end

    clear
    puts "Input new attribute:"
    new_unit = gets.chomp.to_s

    modify_contact.send("#{unit}=", new_unit)

    puts "Success!"
    pause
  end

  def delete_contact
    clear
    puts "DELETE CONTACT"
    puts ""

    loop_contacts { |contact|
      puts "[#{contact.id-999}] #{contact.first_name} #{contact.last_name}"
    }

    puts ""
    line
    puts "Which contact do you want to delete?"
    line

    deleted_id = gets.chomp.to_i+999

    confirm "delete contact"

    Rolodex.delete(deleted_id)
  end

  def display_all_contacts
    clear
    puts "DISPLAY ALL CONTACT"
    puts ""

    loop_contacts { |contact|
      # puts "[#{contact.id-999}] #{contact.first_name} #{contact.last_name}"
      contact.print
    }

    line
    puts "Which contact do you wish to view?"
    puts "or, press ENTER to return to menu"
    line
    
    input = gets
    if input == "\n"
    else
      input = input.chomp.to_i+999

      display_contact = Rolodex.find_by_id(input)

      clear

      display_contact.print_details

      pause
    end
  end

  def loop_contacts
    contacts = Rolodex.contacts
    
    contacts.each {|contact|
      yield(contact)
    } 
  end

  def display_attribute
  end

  def exit_app
    puts "Bye!" 
    exit
  end

  def pause
    puts ""
    line
    puts "Hit ENTER to continue to main menu"
    line
    continue = nil
    until continue == "\n"
     continue = gets
    end
  end

  def clear
    puts "\e[H\e[2J"
  end

  def confirm do_what
    clear
    line
    puts ("Are you sure you want to " + do_what)
    puts "Y/N"
    line

    input = gets.chomp.downcase
    if input[0] == "y"
      
    elsif input[0] == "n"
      start
    else
      puts "I don't understand. Please type 'Y' or 'N':"
      confirm do_what
    end
  end
end


crm_app = CRM.new

# Input dummy contact data
def prime  
  first_name = ["James", "Mark", "Angela", "Theodore", "Sarah"]
  last_name = ["Bond", "Sheffield", "La Roche", "Michaels", "Robertson"]
  email = ["jamesbond@mi6.gov.uk", "mshef@gmail.com", "angie@hotmail.com", "theo23@yahoo.com", "srobertson@aol.com"]
  note = ["This guys is badass!", "He's ok.", "Super annoying", "Great customer!", "Not much to say"]

  first_name.each_index do |i|
    contact = Contact.new(first_name[i], last_name[i], email[i], note[i])
    Rolodex.add_contact(contact)
    Rolodex.contacts  
  end
end
# End prime
prime
crm_app.start


start












