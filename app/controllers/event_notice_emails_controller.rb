class EventNoticeEmailsController < ApplicationController
  before_action :set_group

  def new
    @event_notice_email = @group.event_notice_emails.new
  end

  def create
    @event_notice_email = @group.event_notice_emails.new(event_notice_email_params)
    @event_notice_email.user = current_user
  
    if @event_notice_email.save
      EventNoticeMailer.send_event_notice(@event_notice_email, @group).deliver_later
      EventNoticeMailer.send_event_notice_to_owner(@event_notice_email, @group).deliver_later
      redirect_to sent_group_event_notice_email_path(@group,@event_notice_email ), notice: 'Event notice created and emails sent successfully.'
    else
      render :new
    end
  end

  def sent
    @event_notice_email = EventNoticeEmail.find(params[:id])
    @event_notice_emails = @group.event_notice_emails
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def event_notice_email_params
    params.require(:event_notice_email).permit(:title, :description, :event_date, :body)
  end
end