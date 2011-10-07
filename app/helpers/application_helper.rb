module ApplicationHelper
  def post_add_image_fields(name, f, association)

    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |assoc_builder|
      render :partial => "posts/" + association.to_s.singularize + "_fields", :locals => {:builder => assoc_builder}
    end

    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')".html_safe, :class=> 'add-more-link')

  end
end
