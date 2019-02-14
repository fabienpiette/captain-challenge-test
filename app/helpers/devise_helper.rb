# frozen_string_literal: true

module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    content_tag :div, class: 'alert alert-danger alert-dismissible fade show', role: 'alert' do
      content_tag(:button, type: 'button', class: 'close', 'data-dismiss': 'alert') do
        content_tag(:span, '&times;', 'aria-hidden': 'true')
      end +
        content_tag(:strong, "#{pluralize(resource.errors.count, 'error')} must be fixed") +
        messages
    end
  end

  protected

  def messages
    resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
  end
end
