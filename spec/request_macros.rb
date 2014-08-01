module RequestMacros
  def select_by_id(id, options = {})
    field = options[:from]
    option_xpath = "//*[@id='#{field}']/option[#{id}]"
    option_text = find(:xpath, option_xpath).text
    select option_text, from => field
  end

  def select_date(date, options = {})
    raise ArgumentError, 'from is a required option' if options[:from].blank?   
    field = options[:from]
    year, month, day = date.strftime("%Y,%B,%e").split(',').map(&:strip)
    select year,  :from => "#{field}_1i"
    select month, :from => "#{field}_2i"
    select day,   :from => "#{field}_3i"
  end
     
end
