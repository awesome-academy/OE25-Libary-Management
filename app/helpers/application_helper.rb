module ApplicationHelper
  def full_title page_title = ""
    base_title = t "library_management"
    page_title ? "#{page_title} - #{base_title}" : base_title
  end
end
