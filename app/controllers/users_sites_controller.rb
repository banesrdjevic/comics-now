class UsersSitesController < ApplicationController
  respond_to :html, :js

  def create
  	@user_site = UsersSite.new(users_site_params)
  	@user_site.save
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def index
    @users_sites = UsersSite.where(users_id: session[:user_id])
    render :index
  end

  def destroy
    @site_match = UsersSite.find(params[:id])
    @site_match.destroy if @site_match
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private

  def users_site_params
    params.require(:users_site).permit(:users_id, :sites_id)
  end
end
