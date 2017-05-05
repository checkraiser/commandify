class QueryGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :values, type: :array, :default => [], :banner => 'value1 value2 value3 etc...'

  def create_application_query_file
    template "application_query.rb", "app/queries/application_query.rb"
    template "query.rb", "app/queries/#{class_name.underscore}_query.rb"
    template "query_spec.rb", "spec/queries/#{class_name.underscore}_query_spec.rb"
  end

  private

  def params
    return @params if @params
    @params = values.map do |v|
      "#{v}:"
    end.join(", ")
  end

  def params_declaration
    return @params_declartion if @params_declartion
    @params_declartion = values.map do |v|
      "@#{v} = #{v}"
    end.join("\n\t\t")
  end

  def params_assignment
    return @params_assignment if @params_assignment
    @params_assignment = values.map do |v|
      "#{v}: #{v}"
    end.join(", ")
  end

  def params_accessor
    return @params_accessor if @params_accessor
    @params_accessor = values.map do |v|
      ":#{v}"
    end.join(", ")
  end
end
