module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty? && include_company?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    (messages += @company.errors.full_messages.map { |msg| content_tag(:li, msg) }.uniq.join) if @company

    count = resource.errors.count
    count += @company.errors.count if @company
    sentence = I18n.t("errors.messages.not_saved",
                      :count => count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div  id="error_explanation" class="alert alert-error alert-danger">
<button type="button" class="close" data-dismiss="alert">x</button>
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

  def include_company?
    if @company
      company = @company.errors.empty?
    else
      company = true
    end
  end

end