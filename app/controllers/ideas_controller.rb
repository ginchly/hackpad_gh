class IdeasController < ApplicationController
Pusher.app_id = '25258'
Pusher.key = '4e245534166218fe9521'
Pusher.secret = '25c3d35b733fb28b6bab'
    def create
           @idea = Idea.new(params[:idea])
           if @idea.save
              idea = params[:idea]
              idea_content = idea["content"]
              data = {'content' => idea_content}
              Pusher['hackPad'].trigger('new_idea', data)
              redirect_to root_path
            else
                flash[:error] =  "Couldn't add idea"
                render 'static_pages/home'
            end
    end

    def new
        @idea = Idea.new
    end

    def clear_all
        Idea.delete_all
        redirect_to root_path
    end

    def destroy
        @idea = Idea.find(params[:id])
        @idea.destroy
        redirect_to root_path
    end

end
