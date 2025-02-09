class EventNoticesController < ApplicationController
  before_action :set_group


  def new
    @event_notice = @group.event_notices.new
  end


  def create
    @event_notice = @group.event_notices.new(event_notice_params)

    if @event_notice.save

      EventNoticeMailer.send_event_notice(@event_notice, @group).deliver_later
      EventNoticeMailer.send_event_notice_to_owner(@event_notice, @group).deliver_later

      redirect_to sent_group_event_notices_path(@group), notice: 'Event notice created and emails sent successfully.'
    else
      render :new
    end
  end

  def sent
    @event_notice = EventNotice.last
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def event_notice_params
    params.require(:event_notice).permit(:title, :description, :event_date)
  end
end