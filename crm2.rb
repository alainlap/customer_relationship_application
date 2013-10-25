require_relative "contact"
require_relative "rolodex"

class Menu

   def initialize name
      # begin
      # rescue
      # raise
      @name = name.upcase
      @quit = false
   end

   def start
      while !@quit
         main_menu
      end
   end

   def main_menu
      title = "#{@name} > MAIN MENU"
      options = [
         ["Add new contact", :add],
         ["Modify existing contact", :modify],
         ["Delete contact", :delete],
         ["Display all contacts", :display_all],
         ["Display an attribute", :display_attr],
         ["Exit", :quit]
      ]
      prompt = "Enter a no. to do something"
      menu_builder(title, options, prompt)
   end

   def menu_builder title, options, prompt
      menu_display(title, options, prompt)
      menu_selector(title, options)
   end

   def menu_display title, options, prompt
      clear
      puts title + "\n\n"
      counter = 1
      options.each {|option|
         puts "[#{counter}] \t#{option[0]}"
         counter += 1
      }
      puts ""
      puts prompt
   end

   def menu_selector title, options
      user_selection = gets.chomp.to_i
      # begin
      #    user_selection
      #    raise if (user_selection == nil) || (user_selection > options.length) || (user_selection < 1)
      #    selected_option = options[user_selection-1][1]
      #    send("#{selected_option}")
      # rescue
      #    prompt = "Invalid input, please try again:"  
      #    menu_builder(title, options, prompt)
      # end
  
      if (user_selection == nil) || (user_selection > options.length) || (user_selection < 1)
         prompt = "Invalid input, please try again:"  
         menu_builder(title, options, prompt)
         else
         selected_option = options[user_selection-1][1]
         send("#{selected_option}")
      end
   end

   def add
      puts "add!"
      pause
   end

   def modify
      puts "modify!"
      pause
   end

   def delete
      puts "delete!"
      pause
   end

   def display_all
      puts "display all!"
      pause

      title = "#{@name} > DISPLAY ALL CONTACTS"
      
      options = []
      Rolodex.contacts.each_with_index {|contact, index|
         options << ["#{contact.first_name} #{contact.last_name}", :test]
      }
      prompt = "Enter a number to view contact details"
      
      puts title
      puts options
      puts prompt
      pause
      # menu_builder(title, options, prompt)
   end

   def display_attr
      puts "display attribute!"
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
      puts "Hit 'ENTER' to continue"
      continue = nil
      until continue == "\n"
      continue = gets
      end
   end

end

my_menu = Menu.new("My CRM")

# CREATE DUMMY CONTACTS
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
   prime

my_menu.start












