require_relative "contact"

class Rolodex
  @contacts = []
  @id = 1000

  def self.add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def self.contacts
    @contacts
  end

  def self.find(id, return_index=false)
    @contacts.each_with_index { |contact, index|
    	if (contact.id == id) && (return_index == false)
      		return contact
      elsif (contact.id == id) && (return_index == true)
      		return index
      else
      	# do nothing
      end
    }
  end

  def self.delete(index)
    @contacts.delete_at(index)
  end

  def self.all_contact_details
  	details = []
    @contacts.each do |contact|
		details << "#{contact.first_name} #{contact.last_name}"
	end
	details
  end


end




