class CommandGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :values, type: :array, :default => [], :banner => 'value1:attr1 value2:attr2 value3:attr3 etc...'

  class_option :collection, type: :boolean, default: false
  class_option :version, type: :string, default: "v1"

  def create_command_file
    template "command.rb", "app/commands/api/#{options[:version]}/#{file_name}_command.rb"
    template "command_spec.rb", "spec/commands/api/#{options[:version]}/#{file_name}_command_spec.rb"
    inject_into_file "config/routes.rb", routes_temp, before: /^end/
    template "command.feature", "features/api/#{options[:version]}/#{file_name}.feature"
    template "application_controller.rb", "app/controllers/api/#{options[:version]}/application_controller.rb"
    template "authentication.rb", "app/controllers/concerns/authentication.rb"
    template "serializer.rb", "app/controllers/concerns/serializer.rb"
    template "application_serializer.rb", "app/serializers/application_serializer.rb"
    template "resource_serializer.rb", "app/serializers/api/#{options[:version]}/#{file_name}_serializer.rb"
    template "command_handler.rb", "app/controllers/concerns/command_handler.rb"
    template "resources_controller.rb", "app/controllers/api/#{options[:version]}/#{resources}_controller.rb"
    inject_into_file "app/controllers/api/#{options[:version]}/#{resources}_controller.rb", inject_action_controller, before: /private/
    inject_into_file "app/controllers/api/#{options[:version]}/#{resources}_controller.rb", inject_params_controller, after: /private/
    if options[:collection]
      inject_into_file "config/routes.rb", inject_route_temp_collection, after: /namespace :#{options[:version]} do/
    else
      inject_into_file "config/routes.rb", inject_route_temp_member, after: /namespace :#{options[:version]} do/
    end    
  end

  private

  def routes_temp
    <<~HEREDOC
      namespace :api do
        namespace :#{options[:version]} do

        end
      end
    HEREDOC
  end

  def inject_route_temp_collection
    <<~HEREDOC

      resources :#{resource.pluralize} do
        post :#{verb}, on: :collection
      end

    HEREDOC
  end

  def inject_route_temp_member
    <<~HEREDOC

      resources :#{resource.singlarize} do
        put :#{verb}, on: :member
      end

    HEREDOC
  end

  def feature_name
    "#{verb.titleize} #{resource.camelize}"
  end

  def intention
    "#{verb} #{resource.camelize}"
  end

  def resources
    resource.pluralize
  end

  def inject_action_controller
    <<~HEREDOC

      def #{verb}
        serialize(
          handle(Api::#{options[:version].upcase}::#{file_name.camelize}Command, #{file_name}_params), Api::#{options[:version].upcase}::#{file_name.camelize}Serializer
        )          
      end

    HEREDOC
  end

  def inject_params_controller
    <<~HEREDOC

      def #{file_name}_params
        params.require(:#{resource})
              .permit(#{kreaders})
              .merge(current_user: current_user)
      end

    HEREDOC
  end

  def resource
    return @resource if @resource
    @resource = file_name.split("_")[1..-1].join("_")
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
