class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]  
    #übersetzt: hiermit wird sichergestellt, dass die action nur von show, edit, update und destroy benutzt werden dürfen.

    def test
        if params[:category].blank?
            #@items = Item.all.order("created_at DESC")
            @categories = Category.all
            @all_items = {}
            @categories.each do |cat|
                temp = Item.where(:category_id => cat).order("title ASC")
                @all_items[cat] = temp

            end
            
            #@category_id = Category.find_by(name: "Drinks").id
            #@items_drinks = Item.where(:category_id => @category_id).order("title ASC")

            #@category_id = Category.find_by(name: "Cleaning Agent").id
            #@items_cleaning = Item.where(:category_id => @category_id).order("title ASC")

            #@category_id = Category.find_by(name: "Frozen Food").id
            #@items_frozen = Item.where(:category_id => @category_id).order("title ASC")

            #@category_id = Category.find_by(name: "Cookies").id
            #@#items_cookies = Item.where(:category_id => @category_id).order("title ASC")

            #@category_id = Category.find_by(name: "Beauty").id
            #@items_beauty = Item.where(:category_id => @category_id).order("title ASC")

            #@category_id = Category.find_by(name: "Ice Cream").id
            #@items_ice = Item.where(:category_id => @category_id).order("title ASC")

        else
            @category_id = Category.find_by(name: params[:category]).id
            @items = Item.where(:category_id => @category_id).order("created_at DESC")
        end

    end 


    def index
        @categories = Category.all
            @all_items = Hash.new(0)
            @categories.each do |cat|
                temp = Item.where(:category_id => cat).order("title ASC")
                @all_items[cat.name] = temp

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
