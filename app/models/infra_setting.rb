class InfraSetting < ApplicationRecord

  #TO-DO: Add validation to save value by encrypting it, encryption algorithm and key (if required) to be set in env variables
  #TO-DO: Override find_by function to decrypt values and send back value

  def self.find_by(**params)
    super(**params).value
  end

end
