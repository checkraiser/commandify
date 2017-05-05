class CommandGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :values, type: :array, :default => [], :banner => 'value1:attr1 value2:attr2 value3:attr3 etc...'

  def create_command_file
    template "command.rb", "app/commands/#{class_name.underscore}.rb"
    template "command_spec.rb", "spec/commands/#{class_name.underscore}_spec.rb"
  end

  private

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
