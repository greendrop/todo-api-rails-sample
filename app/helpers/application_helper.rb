# frozen_string_literal: true

module ApplicationHelper
  def nl2br(str)
    safe_join(sanitize(str.to_s).split("\n"), '<br/>'.html_safe)
  end
end
