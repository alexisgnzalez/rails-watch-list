class BookmarksController < ApplicationController
  def new
    # /lists/:list_id/bookmark/new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    @bookmark.save
    # no need for app/views/bookmarks/create.html.erb
    redirect_to lists_path
  end

  def destroy
    @bookmark = bookmark.find(params[:id])
    @bookmark.destroy

    # no need for app/views/bookmarks/destroy.html.erb
    redirect_to lists_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
