require './decorators'

class C
  include Decorators

  add_prefix('hello ')
  def a
    'from a'
  end

  def b
    'from b'
  end

  add_prefix('hello ')
  add_prefix('hello_second  ')
  add_after(' after bye!')
  def c
    'from c'
  end

  add_after(' after good bye!')
  def d
    'from d'
  end

end

p C.new.a # 'hello from a'
p C.new.b # 'from b'
p C.new.c # 'hello hello from c after bye!'
p C.new.d # 'from d after good bye!'
