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
        body: @event_notice.description
      )

      mail(to: member.email, subject: @event_notice.title) do |format|
        format.text { render plain: @event_notice.description }
        format.html { render html: @event_notice.description.html_safe }
      end
    end
  end
end
