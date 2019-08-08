module ApplicationHelper
  def active_notifications
    Notification.active.count
  end

  def current_module
    return @module_name if defined?(@module_name)
    "#{controller_name.humanize.classify.pluralize} > #{action_name}"
  end

  def format_amount(amount)
    amount = '%.2f' % amount
    amount = amount.insert(-7, ',') if amount.size > 6 
    amount = amount.insert(-10, ',') if amount.size > 9 
    amount = amount.insert(-13, ',') if amount.size > 12 
    return amount
  end
end
