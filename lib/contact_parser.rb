require "contact_parser/version"
require "email_address"

class ContactParser
  def initialize(str)
    @str = str
  end

  def bulk_parse
    split_records
    names_and_emails = split_names_and_email(split_records)
    contact_list_cleaned_for_hash = remove_angle_bracket_from_emails(names_and_emails)
    convert_contacts_to_hash(contact_list_cleaned_for_hash)
  end

  def split_records
    @str.split(',')
  end

  def split_names_and_email(split_records_array)
    split_records_array.map { |e| e.split(' ') }
  end

  def remove_angle_bracket_from_emails(name_and_email_array)
    name_and_email_array.map { |e| e.last.gsub!(/<|>/, '') }
    name_and_email_array
  end

  def convert_contacts_to_hash(name_and_email_array)
    name_and_email_array.each_with_object(final_hash) do |e, hash|
      first_name = e.first
      last_name = e[-2]
      email = e.last

      if valid_contact?(first_name, last_name, email)
        contact_hash = Hash.new
        contact_hash[:first_name] = first_name
        contact_hash[:last_name] = last_name
        contact_hash[:email] = email
        hash[:accepted].push(contact_hash)
      else
        hash[:rejected] << e.join(' ')
      end
    end
  end

  def final_hash
    {
      accepted: [],
      rejected: []
    }
  end

  def valid_contact?(first_name, last_name, email)
    if !EmailAddress.valid?(email)
      return false
    elsif first_name.nil?
      return false
    elsif last_name.nil?
      return false
    else
      true
    end
  end
end
