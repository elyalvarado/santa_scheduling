def load_script filename
  callable_var = nil
  file_contents = File.read(filename)
  proc = Proc.new {}
  eval("callable_var = " + file_contents, proc.binding, filename)
  raise "Solution file must start with method to call or lambda" unless
      [Symbol, Proc].include?(callable_var.class)

  {
      size: file_contents.size,
      callable: callable_var.class === :Symbol ? method(callable_var) : callable_var
  }
end
