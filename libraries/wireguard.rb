class Chef
  class Recipe
    def configure_keys(recipe)
      %w(public private).each do |name|
        file "/etc/wireguard/#{name}key" do
          content node[cookbook_name][recipe]["#{name}_key"]
          owner 'root'
          group 'root'
          mode '0400'
          sensitive true
        end
      end
    end
  end
end
