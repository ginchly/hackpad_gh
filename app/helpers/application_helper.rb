module ApplicationHelper
    def users
     User.all
    end
    def link_to_delete
      link_to %{<i class="icon-trash icon-white"></i> Delete}, '#', class: "btn btn-danger remove_fields" 
    end

  
end
