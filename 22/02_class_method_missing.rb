class A
  
  @@attributes = {}

  class << self
    def method_missing name, *params
      name = name.to_s

      if name =~ /=$/
        @@attributes[name.sub('=', '')] = params.first
      else
        @@attributes[name]
      end
    end
  end

end

A.title
A.title = 'aaa'
p A.title