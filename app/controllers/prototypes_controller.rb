class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def create    
      @prototype = Prototype.create(prototype_params)
    if
      @prototype.save
      redirect_to root_path
    else
      render :new     
    end
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
      @prototype = Prototype.find(params[:id])
    if

      @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end  
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

def move_to_index
  prototype = Prototype.find(params[:id])
  if prototype.user_id != current_user.id
    redirect_to action: :index
  end
end