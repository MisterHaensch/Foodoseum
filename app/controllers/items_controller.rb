class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]  
    #übersetzt: hiermit wird sichergestellt, dass die action nur von show, edit, update und destroy benutzt werden dürfen.

    def index
        if params[:category].blank?
            @categories = Category.all
                @all_items = Hash.new(0)
                @categories.each do |cat|
                    temp = Item.where(:category_id => cat).order("rating DESC")
                    @all_items[cat.name] = temp

                end
        else
            @all_items = Hash.new(0)
            categories = Category.find_by(name: params[:category]).id
            categorie_name = Category.find_by(name: params[:category]).name
            temp = Item.where(:category_id => categories).order("rating DESC")
            @all_items[categorie_name] = temp
            
        end

    end

    def show        
    end

    def new
        @item = current_user.items.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def create
        @item = current_user.items.build(item_params)
        @item.category_id = params[:category_id]
        if @item.save
            redirect_to root_path
        else
            render 'new'
        end

    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }        
    end

    def update
        @item.category_id = params[:category_id]

        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            render 'edit'
        end
    end

    def destroy
        @item.destroy
        redirect_to root_path
    end

    private
    
    def item_params
        params.require(:item).permit(:title, :description, :category_id, :image, :rating)
    end

    def find_item
        @item = Item.find(params[:id])
    end
end
