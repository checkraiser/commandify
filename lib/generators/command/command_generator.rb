class CommandGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :values, type: :array, :default => [], :banner => 'value1:attr1 value2:attr2 value3:attr3 etc...'

  class_option :collection, type: :boolean, default: false
  class_option :controller, type: :boolean, default: false

  def create_command_file
    template "command.rb", "app/commands/#{class_name.underscore}_command.rb"
    template "command_spec.rb", "spec/commands/#{class_name.underscore}_command_spec.rb"
    template "routes.rb", "config/routes.rb"
    if options[:controller]
      template "application_controller", "app/controllers/api/v1/application_controller.rb"
      template "authentication.rb", "app/controllers/concerns/authentication.rb"
      template "resources_controller.rb", "app/controllers/api/v1/#{resources}_controller.rb"
      inject_into_file "app/controllers/api/v1/#{resources}_controller.rb", inject_action_controller, before: /^private/
      inject_into_file "app/controllers/api/v1/#{resources}_controller.rb", inject_params_controller, before: /^end/
    end
    if options[:collection]
      inject_into_file "config/routes.rb", "resources :#{resource.pluralize} do\n\tpost :#{verb}, on: :collection\nend\n", after: /^namespace :v1 do/
    else
      inject_into_file "config/routes.rb", "resources :#{resource.singlarize} do\n\tput :#{verb}, on: :member\nend\n", after: /^namespace :v1 do/
    end    
  end

  private

  def resources
    resource.pluralize
  end

  def inject_action_controller
    "\tdef #{verb}\n\n\tend\n"
  end

  def inject_params_controller
    "\tdef #{file_name}_params\n\t\tparams.require(:#{resource}.permit(#{kreaders})\n\tend"
  end

  def resource
    return @resource if @resource
    @resource = file_name.split("_")[1]
  end

  def verb
    return @verb if @verb
    @verb = file_name.split("_")[0]
  end

  def declaration
    keys.map do |key|
      "@#{key} = #{key}"
    end.join("\n\t\t")
  end

  def kv
    return @kv if @kv
    @kv = { }
    values.each do |v|
      x, y = v.split(":")
      @kv[x.to_sym] = y
    end
    @kv
  end

  def keys
    return @keys if @keys
    kv.keys.map(&:to_s)
  end

  def values
    return @values if @values
    kv.values
  end

  def kinits
    return @kinits if @kinits
    keys.map { |i| "#{i}:"}.join(", ")
  end

  def kreaders
    return @readers if @readers
    keys.map { |i| ":#{i}"}.join(", ")
  end

  def inits
    return @inits if @inits
    keys.join(", ")
  end
end
