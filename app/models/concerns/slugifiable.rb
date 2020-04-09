module Slugifiable 
    module InstanceMethods 
        def slug
            artist_name = self.name
            slug = artist_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
          end
    end 
end 