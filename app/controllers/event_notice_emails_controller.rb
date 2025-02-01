class EventNoticeEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_event_notice_email, only: [:show]

  def index
    @event_notice_emails = @group.event_notice_emails
  end

  def show
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_event_notice_email
    @event_notice_email = @group.event_notice_emails.find_by(id: params[:id])
    redirect_to group_event_notice_emails_path(@group), alert: 'Not found or you do not have access to this email.' unless @event_notice_email
  end
end