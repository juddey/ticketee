class CommentNotifier < ApplicationMailer

  def updated(comment, user)
    @comment = comment
    @user = user
    @ticket = comment.ticket
    @project = @ticket.project
    subject = "[ticketee] #{@project.name} - #{@ticket.title}"
    mail(to: user.email, subject: subject,
         reply_to: "TicketeeApp <myfriend+" +
         "#{@project.id}+#{@ticket.id}@example.com>")
  end
end
