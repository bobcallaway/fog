module Fog
  module Compute
    class SoftLayer

      class Real
        def add_virtual_server_tags(id, tags="")
          # TODO: do we need to create a tag at the account level for each and then associate?
          if (tags =~ /([^,]+)(,[^,]*)*/) #ensure the string structure via regex
          # the API requires that you do full replace each time, so we fetch the existing list and augment with the argument to this method
          existingTags = get_virtual_server_tags(id).body
          newTags = tags
          if existingTags.size > 0
            newTags << ","
            existingTags.each_with_index { |x, index| if index != existingTags.size - 1 then newTags << x["tag"]["name"] + ',' else newTags << x["tag"]["name"] end }
          end
          puts newTags
          request( {
            :method => "POST",
            :path => "SoftLayer_Virtual_Guest/#{id}/setTags",
            :body => { :tags => newTags },
            :expects => 200
          },
          true
          )
          else #regex failed b/c tag
            raise
          end
        end
      end
    end
  end
end
