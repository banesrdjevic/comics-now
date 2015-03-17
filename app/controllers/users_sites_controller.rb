class UsersSitesController < ApplicationController

  def create
  	@user_site = UsersSite.new(users_site_params)
  	@user_site.save
  end

  def index
    @users_sites = UsersSite.where(users_id: session[:user_id])
    render :index
  end

  def destroy
  end

  private

  def users_site_params
    params.require(:users_site).permit(:user_id, :site_id)
  end
end
