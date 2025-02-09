class EventNoticesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_event_notice, only: [:show]

  def index
    @event_notices_emails = @group.event_notice_emails.where(user_id: current_user.id)
    #@event_notice_emails = current_user.event_notice_emails.()
  end

  def show
    @event_notices_email = EventNoticeEmail.find_by(group_id: params[:group_id],id: params[:id])
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_event_notice

    @event_notice_email = @group.event_notice_emails.find_by(id: params[:id])
    redirect_to group_event_notices_path(@group), alert: 'Event notice not found.' unless @event_notice_email
  end
end