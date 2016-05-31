class WikisController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.private && current_user.standard?
      flash[:alert] = "You must be a priemium user to view this Wiki."
      redirect_to root_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki


    if @wiki.save
      flash[:notice] = "Your wiki was published."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an Error creating your Wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "You wiki has been updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an Error editing your Wiki."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki #{@wiki.title} was deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was a Error deleting your Wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
