SimpleForm.setup do |config|
  config.wrappers :tag => :p, :class => :input,
                     :error_class => :fieldWithErrors do |b|
      b.use :html5
      b.use :maxlength
      b.use :placeholder
      b.use :readonly
      b.use :pattern

      b.use :label_input
      b.use :hint,  :wrap_with => { :tag => :span, :class => :inputHint }
      b.use :error, :wrap_with => { :tag => :span, :class => :inputError }
    end
end
