class CategoriesController < ApplicationController
    def new
        @categories = Category.new()
    end

    def create
       @categories = Category.new(category_params)       

       if @categories.save
         redirect_to root_path
       else
         render :new
       end
    end
    
    private

    def category_params
        params.require(:category).permit(:name)
    end
end
