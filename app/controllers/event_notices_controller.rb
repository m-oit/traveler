class EventNoticesController < ApplicationController
  before_action :set_group


  def new
    @event_notice = @group.event_notices.new
  end


  def create
    @event_notice = @group.event_notices.new(event_notice_params)

    if @event_notice.save
      redirect_to @group, notice: 'Event notice created successfully.'
    else
      render :new
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def event_notice_params
    params.require(:event_notice).permit(:title, :description, :event_date)
  end
end