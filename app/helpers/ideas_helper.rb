module IdeasHelper

    def ideas
        Idea.all
    end

    def create_idea
        @idea = Idea.new
    end

end
