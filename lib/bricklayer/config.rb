class Bricklayer::Config
  def initialize(file, options)
    @table = {}
    instance_eval(File.read(file))
    @table.merge!(options.__hash__)
    puts @table
  end

  def method_missing(meth, *args, &block)
    key = meth.to_s.to_sym
    @table[key] = args.first if args.size > 0
    @table[key]
  end

  def to_hash
    @table
  end
end
