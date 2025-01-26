class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:id])
  end
  
  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer
  end
  
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループ画像が更新されました！'
    else
      render :edit
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :post_image)
  end
end
