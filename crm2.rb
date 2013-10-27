require 'debugger'
require_relative "contact"
require_relative "rolodex"

class CRM

   def initialize name
      @name = name
      @quit = false
   end

   def start
      while !@quit
         main_menu
      end
   end

   def main_menu
      title = "#{@name.upcase} > MAIN MENU"
      options = [
         "Add new contact",
         "Modify existing contact",
         "Delete contact",
         "Display all contacts",
         "Display an attribute",
         "Exit"
      ]
      actions = [
      	:add,
      	:modify,
      	:delete,
      	:display_all,
      	:display_attr,
      	:quit
      ]
      prompt = "Select an option by entering a number: "
      action = menu_builder(title, options, prompt, actions)
		send("#{action}")
   end

   def menu_builder title, options, prompt, actions=nil
      menu_display(title, options, prompt)
      menu_selector(title, options, actions)
   end

   def menu_display title, options, prompt
      clear
      puts title + "\n\n"
      counter = 1
      options.each {|option|
         puts "[#{counter}] \t#{option}"
         counter += 1
      }
      puts ""
      print prompt
   end

   def menu_selector title, options, actions=nil
      user_selection = gets.chomp.to_i
  
      if (user_selection == nil) || (user_selection > options.length) || (user_selection < 1)
         prompt = "Invalid input, please try again: "  
         menu_builder(title, options, prompt, actions)
      elsif actions == nil
      	user_selection
      elsif actions != nil
         actions[user_selection-1]
      end
   end

   def add
    new_contact_info
    contact = Contact.new(@first_name, @last_name, @email, @note)
    Rolodex.add_contact(contact)
  end

  def new_contact_info
    clear
    puts "#{@name}.upcase > ADD NEW CONTACT"
    puts ""
    @first_name = get_input("Enter First Name: ", "to_s")
    @last_name = get_input("Enter Last Name: ", "to_s")
    @email = get_input("Enter Email: ", "to_s")
    @note = get_input("Enter Note: ", "to_s")
  end

  def get_input prompt, input_type
    user_input = nil
    print prompt
    user_input = gets.chomp.send("#{input_type}")
  end

   def modify
   	title = "#{@name}.upcase > MODIFY EXISTING CONTACTS"
   	options = Rolodex.all_contact_details      
      prompt = "Which contact would you like to modify?: "
      user_selection = menu_builder(title, options, prompt)
      contact = Rolodex.find(user_selection+999)

      clear
    	
    	title = "You have selected #{contact.first_name} #{contact.last_name}"
    	options = [
    	"First Name",
    	"Last Name",
    	"Email",
    	"Note"
    	]
    	actions = [
    		:first_name,
    		:last_name,
    		:email,
    		:note
    	]
    	prompt = "Which attribute would you like to modify?: "
    	action = menu_builder(title, options, prompt, actions)

	   puts "Input new attribute:"
    	user_input = gets.chomp.to_s
    	contact.send("#{action}=", user_input)

    	puts "Success!"
    	pause
   end

   def delete
   	title = "#{@name}.upcase > DELETE CONTACT"
   	options = Rolodex.all_contact_details      
      prompt = "Which contact would you like to delete?: "
      user_selection = menu_builder(title, options, prompt)
      index = Rolodex.find(user_selection+999, true)
    	confirm "delete contact"
    	Rolodex.delete(index)
   end

   def display_all
   	clear
   	title = "#{@name}.upcase > DISPLAY ALL CONTACTS"
   	options = Rolodex.all_contact_details      
      prompt = "Enter a number to view contact details: "
      user_selection = menu_builder(title, options, prompt)
      contact = Rolodex.find(user_selection+999)
      clear
      contact.print_details
      pause
   end

   def display_attr
      puts "To be implemented..."
      pause
   end

   def clear
   	puts "\e[H\e[2J"
   end

   def quit
      @quit = true
   end

   def pause
      puts ""
      print "Hit 'ENTER' to continue: "
      continue = nil
      until continue == "\n"
      continue = gets
      end
   end

   def confirm do_what
	   clear
	   puts ("Are you sure you want to " + do_what)
	   print "Y/N: "
	   user_input = gets.chomp.downcase
	   if user_input == "y"
	     
	   elsif user_input == "n"
	     start
	   else
	     print "I don't understand. Please type 'Y' or 'N': "
	     confirm do_what
	   end
  end
end

crm = CRM.new("Assignment 7 CRM")

# CREATE DUMMY CONTACTS
   def prime  
     first_name = ["James", "Mark", "Angela", "Theodore", "Sarah", "Burt"]
     last_name = ["Bond", "Sheffield", "La Roche", "Michaels", "Robertson", "Wonderful"]
     email = ["jamesbond@mi6.gov.uk", "mshef@gmail.com", "angie@hotmail.com", "theo23@yahoo.com", "srobertson@aol.com", "wonderful@earthlink.com"]
     note = ["This guys is badass!", "He's ok.", "Super annoying", "Great customer!", "Not much to say", "great moustache"]

     first_name.each_index do |i|
       contact = Contact.new(first_name[i], last_name[i], email[i], note[i])
       Rolodex.add_contact(contact)
       Rolodex.contacts  
     end
   end
   prime

crm.start












