class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:index]

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id).includes(:animal)
  end

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      if params[:from_page] == "matchs"
      #   redirect_to matchs_path, notice: "Animal favoritado com sucesso!"
      # elsif @bookmark.animal.present?
      #   redirect_to user_path(@bookmark.animal.user), notice: "Animal favoritado com sucesso!"
      else
        redirect_to animals_path, notice: "Animal favoritado com sucesso!"
      end
    else
      redirect_to animals_path, alert: "Falha ao favoritar o animal."
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    if @bookmark.destroy
      if params[:from_page] == "matchs"
        redirect_to matchs_path, notice: "Animal removido dos favoritos com sucesso!"
      elsif params[:from_page] == "dashboard"
        redirect_to dashboard_path, notice: "Animal removido dos favoritos com sucesso!"
      # elsif @bookmark.animal.present?
      #   redirect_to user_path(@bookmark.animal.user), notice: "Animal removido dos favoritos com sucesso!"
      else
        redirect_to animals_path, notice: "Animal removido dos favoritos com sucesso!"
      end
    else
      redirect_to dashboard_path, alert: "Falha ao remover o animal dos favoritos."
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :animal_id)
  end

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end
end
