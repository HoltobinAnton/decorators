module Decorators

  module ClassMethods

    define_method :method_missing do |method_name, value = ''|
      before,after = '',''
      method_name.to_s == 'add_prefix'?before = value : after = value
      next_subs = method(:method_added)
      define_singleton_method(:method_added) do|name|
        to_decorate = instance_method(name)
        define_singleton_method(:method_added, &next_subs)
        define_method(name) do|*args, &block|
          before + to_decorate.bind(self).call(*args, &block) + after
        end
      end
    end

  end

  def self.included(klass)
    klass.extend ClassMethods
  end
end

