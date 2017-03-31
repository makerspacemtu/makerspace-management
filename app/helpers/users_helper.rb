module UsersHelper
  def previous_class
    unless @page > 0
      "disabled"
    end
  end

  def next_class
    if (@page + 1) >= total_page_count
      "disabled"
    end
  end

  def total_page_count
    (User.count.to_f / User::PAGE_SIZE.to_f).ceil
  end
end
