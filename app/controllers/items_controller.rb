class ItemsController < ApplicationController

    def index
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
    end

    private
    
    def item_prams
        params.require(:item).permit(:title, :description)
    end
end
