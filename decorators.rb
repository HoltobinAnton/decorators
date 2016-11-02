module Decorators

  module ClassMethods
    def add_prefix(text = '')
      next_subs = method(:method_added)
      define_singleton_method(:method_added) do|name|
        to_decorate = instance_method(name)
        define_singleton_method(:method_added, &next_subs)
        define_method(name) do|*args, &block|
          text + to_decorate.bind(self).call(*args, &block)
        end
      end
    end

    def add_after(text ='')
      next_subs = method(:method_added)
      define_singleton_method(:method_added) do|name|
        to_decorate = instance_method(name)
        define_singleton_method(:method_added, &next_subs)
        define_method(name) do|*args, &block|
          to_decorate.bind(self).call(*args, &block) + text
        end
      end
    end
  end

  def self.included(klass)
    klass.extend ClassMethods
  end
end

