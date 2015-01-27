module TicketsHelper
  def state_transition_for(comment)
    if comment.previous_state != comment.state
      content_tag(:p) do
        value = "&raquo; state changed "
        if comment.previous_state.present?
          value += "from #{ comment.previous_state } "
        end
        value += "to #{ comment.state }"
        value.html_safe
      end
    end
  end
end
