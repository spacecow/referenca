module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("articles/"+association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end

  def add(s); t2(:add,s) end
  def chain(s1,s2); "#{s1.to_s}.#{s2.to_s}" end
  def create(s); t2(:create,s) end
  def d(s); t(s).downcase end
  def dp(s); d(s).pluralize end
  def edit(s); t2(:edit,s) end
  def fetch_image(path)
    ext = path.split('.').last
    image_tag("#{ext}.jpeg", :height => "20", :alt => "#{ext}")
  end
  def lbl(s); chain(:label,s) end
  def list_dp(s); tdp2(:list,s) end
  def list_p(s); tp2(:list,s) end
  def new(s); t2(:new,s) end
  def new_d(s); td2(:new,s) end
  def pl(s); t(s).match(/\w/) ? t(s).pluralize : t(s) end
  def remove(s); t2(:remove,s) end
  def show(s); t2(:show,s) end
  def sure?; t('message.sure?') end
  def t2(s1,s2); t(lbl(s1), :obj => t(s2)) end
  def td2(s1,s2); t(lbl(s1), :obj => d(s2)) end
  def tdp2(s1,s2); t(lbl(s1), :obj => dp(s2)) end
  def tp2(s1,s2); t(lbl(s1), :obj => pl(s2)) end
  def update(s); t2(:update,s) end
  def view(s); tp2(:view,s) end
  def your_p(s); tp2(:your,s) end
end
