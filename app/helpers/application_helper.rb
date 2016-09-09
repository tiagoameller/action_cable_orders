module ApplicationHelper
  def self.format_date_time(date_time)
    date_time.present? ? I18n.l(date_time, format: '%0d/%0m/%Y %H:%M') : I18n.t('views.undefined')
  end
end
