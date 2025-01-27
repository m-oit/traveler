class PermitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    permit = current_user.permits.new(group_id: params[:group_id])
    if permit.save
      redirect_to request.referer, notice: "グループへ参加申請をしました"
    else
      redirect_to request.referer, alert: "申請に失敗しました"
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @permits = @group.permits
  end

  def destroy
    permit = current_user.permits.find_by(group_id: params[:group_id])
    if permit
      permit.destroy
      redirect_to request.referer, alert: "グループへの参加申請を取消しました"
    else
      redirect_to request.referer, alert: "申請が見つかりませんでした"
    end
  end

  def index
    @permits = @group.permits.page(params[:page]).per(10)
    render 'groups/permits'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
