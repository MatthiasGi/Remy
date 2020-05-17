SimpleForm.setup do |config|
  config.wrappers :custom_horizontal_file, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.wrapper :custom_file_wrapper, tag: 'div', class: 'custom-file' do |baa|
        baa.use :input, class: 'custom-file-input', error_class: 'is-invalid', valid_class: 'is-valid'
        baa.use :label, class: 'custom-file-label'
        baa.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      end
    end
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end
end
