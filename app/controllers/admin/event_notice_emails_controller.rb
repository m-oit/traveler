class Admin::EventNoticeEmailsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @event_notice_emails = EventNoticeEmail.all
  end

  def destroy
    @event_notice_email = EventNoticeEmail.find(params[:id])
    if @event_notice_email.destroy
      redirect_to admin_event_notice_emails_path, notice: '通知が削除されました。'
    else
      redirect_to admin_event_notice_emails_path, alert: '通知の削除に失敗しました。'
    end
  end


end
