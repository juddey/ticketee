module TicketsHelper
  def state_transition_for(comment)
    if comment.previous_state != comment.state
      content_tag(:p) do
        value = "&raquo; state changed "
        if comment.previous_state.present?
          value += "from #{render comment.previous_state} "
        end
        value += " to #{render comment.state}"
        value.html_safe
      end
    end
  end

  def toggle_watching_button
    text = if @ticket.watchers.include?(current_user)
      "Stop watching this ticket"
    else
      "Watch this ticket"
    end
    button_to text, watch_project_ticket_path(@ticket.project, @ticket)
  end
end
