class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :edit]
  before_filter :load_micropost,   only: [:destroy, :edit]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_path
    else
      @feed_items = []
      render 'welcome/index'
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      redirect_to @micropost.user
    else
      render 'edit'
    end
  end


  def destroy
    @micropost.destroy
    redirect_to :back
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


    def load_micropost
      @micropost = current_user.admin ? Micropost.find(params[:id]) : current_user.microposts.find(params[:id])
    end
end

