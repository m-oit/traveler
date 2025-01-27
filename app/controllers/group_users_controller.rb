class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :create, :destroy, :update, :destroy_user]

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
  end
  
  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy 
    redirect_to request.referer
  end
  
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    if group_user
      group_user.destroy
      redirect_to @group, notice: 'グループから退出しました。'
    else
      redirect_to @group, alert: 'グループから退出できませんでした。'
    end
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

  def set_group
    @group = Group.find(params[:group_id])
  end
end
