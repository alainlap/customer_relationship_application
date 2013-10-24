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

  def self.find_by_id requested_id
    @contacts.each {|contact|
      if contact.id == requested_id
        @requested_contact = contact
      end
    }
    @requested_contact
  end

  def self.delete deleted_id
    @contacts.each_with_index {|contact, index|
      if contact.id == deleted_id
        @contacts.delete_at(index)
      end
    }
  end
end