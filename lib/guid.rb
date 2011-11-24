# generate guids
class Guid
  
  # guid length
  GUID_LENGTH = 20
  
  def self.generate_20_guid
    generate_guid( 20 )
  end
  
  def self.generate_guid( length=GUID_LENGTH )
    UUIDTools::UUID.random_create.hexdigest[ 0,length ]
  end
end