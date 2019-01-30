class Engine
  def initialize(name)
    @name = name
  end

  def convert(value, from:, to:)
    ensure_class_exists!

    api.convert(value, from: from, to: to)
  rescue => e
    { error: e.message }
  end

  private

  def api
    @api ||= Object.const_get(class_name)
  end

  def class_name
    @class_name ||= @name.camelize
  end

  def ensure_class_exists!
    return if Object.const_defined? class_name
    raise "Plugin #{@name} not exists"
  end
end