# lib/active_admin_views_pages_base.rb

class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para "Copyright &copy; #{Date.today.year.to_s} [Active Admin v#{ActiveAdmin::VERSION}]".html_safe
    end
  end

end