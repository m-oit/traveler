class EventNoticeMailer < ApplicationMailer
  def send_event_notice(event_notice, group)
    @event_notice = event_notice
    @group = group
    @members = group.users

    @members.each do |member|


      EventNoticeEmail.create!(
        group: @group,
        user: member,
        title: @event_notice.title,
        body: @event_notice.body 
      )


      mail(to: member.email, subject: @event_notice.title) do |format|
        format.text { render plain: @event_notice.body }
        format.html { render html: @event_notice.body.html_safe }
      end
    end
  end

  def send_event_notice_to_owner(event_notice, group)
    @event_notice = event_notice
    @group = group
    @owner = group.owner


    EventNoticeEmail.create!(
      group: @group,
      user: @owner,
      title: @event_notice.title,
      body: @event_notice.body,
      event_date: @event_notice.event_date
    )


    mail(to: @owner.email, subject: @event_notice.title) do |format|
      format.text { render plain: @event_notice.body }
      format.html { render html: @event_notice.body.html_safe }
    end
  end
end