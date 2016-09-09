module ApplicationHelper
  def self.format_date_time(date_time)
    date_time.present? ? I18n.l(date_time, format: '%d %b %H:%M') : 'undefined'
  end
end
