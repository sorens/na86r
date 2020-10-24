# provide the model with a common way to generate a uuid for a record
module NA86
    module ModelUuid
      def generate_uuid( str="" )
        # generate a seed string using the name of the class, the parameter and the current time
        # converted to a float and then a string
        seed = self.class.name + str.to_s + Time.now.to_f.to_s
        uuid = UUIDTools::UUID.sha1_create( UUIDTools::UUID_OID_NAMESPACE, seed ).to_s.upcase
        return uuid
      end
    end
end
