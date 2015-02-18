require "rails_helper"

describe Receiver, :type => :mailer do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket_owner) { FactoryGirl.create(:user) }
  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project,
                                author: ticket_owner)
  end
  let!(:commenter) { FactoryGirl.create(:user) }
  let(:comment) do
    Comment.new({
      ticket: ticket,
      author: commenter,
      text: "Test comment"
    })
  end

  it "parses a reply from a comment update into a comment" do
    comment_email = CommentNotifier.updated(comment, ticket_owner)
    mail = Mail.new(from: commenter.email,
                    subject: "Re: #{comment_email.subject}",
                    body: %Q{This is a brand new comment

                        #{comment_email.body}
                   },
                   to: comment_email.reply_to)
    expect(lambda { Receiver.parse(mail) }).to(
       change(comment.ticket.comments, :count).by(1)
    )
    expect(ticket.comments.last.text).to eql("This is a brand new comment")
  end
end