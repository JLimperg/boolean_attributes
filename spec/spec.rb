require 'boolean_attributes'

describe BooleanAttributes do

  before :each do
    @c = Class.new
    @c.send(:include, BooleanAttributes)
  end

  describe 'should add the class method Class.b_attr_accessor which' do

    it 'should combine Class.b_attr_reader and Class.b_attr_writer' do
      @c.send(:b_attr_accessor, :valid)

      obj = @c.new
      obj.valid = nil
      obj.valid?.should == false
    end

    it 'should be private' do
      @c.public_methods.include?(:b_attr_accessor).should be_false
      @c.private_methods.include?(:b_attr_accessor).should be_true
    end

    it 'should be an alias of Class.b_attr' do
      @c.send(:b_attr, :valid)
      @c.new.should respond_to :valid?
    end

    it 'should work for multiple attributes' do
      @c.send(:b_attr, :valid, :required)
      @c.new.should respond_to :valid?
      @c.new.should respond_to :required?
    end

  end # Class.b_attr_accessor

  describe 'should add the class method Class.b_attr_reader which' do

    it 'should define the instance method #<attr>?' do
      @c.send(:b_attr_reader, :valid)
      @c.new.should respond_to :valid?
    end

    it 'should be private' do
      @c.public_methods.include?(:b_attr_reader).should be_false
      @c.private_methods.include?(:b_attr_reader).should be_true
    end

    it 'should work for multiple attributes' do
      @c.send(:b_attr_reader, :valid, :required)
      @c.new.should respond_to :valid?
      @c.new.should respond_to :required?
    end

  end # Class.b_attr_reader

  describe 'should add the class method Class.b_attr_writer which' do

    it 'should define the instance method #<attr>=' do
      @c.send(:b_attr_writer, :valid)
      @c.new.should respond_to :valid=
    end

    it 'should be private' do
      @c.public_methods.include?(:b_attr_writer).should be_false
      @c.private_methods.include?(:b_attr_writer).should be_true
    end

    it 'should work for multiple attributes' do
      @c.send(:b_attr_writer, :valid, :required)
      @c.new.should respond_to :valid=
      @c.new.should respond_to :required=
    end

  end # Class.b_attr_writer

end

describe 'the #<attr>? method defined by Class.b_attr_reader' do

  before :each do
    @c = Class.new
    @c.send(:include, BooleanAttributes)
    @c.send(:b_attr_reader, :valid)
    @o = @c.new
  end

  context 'if @attr is false' do
    it 'should return false' do
      @o.instance_variable_set(:@valid, false)
      @o.valid?.should == false
    end
  end

  context 'if @attr is nil' do
    it 'should return false' do
      @o.instance_variable_set(:@valid, nil)
      @o.valid?.should == false
    end
  end

  context 'if @attr is not false or nil' do
    it 'should return true' do
      @o.instance_variable_set(:@valid, true)
      @o.valid?.should == true
      @o.instance_variable_set(:@valid, Object.new)
      @o.valid?.should == true
    end
  end

end #<attr>?

describe 'the #<attr>= method defined by Class.b_attr_writer' do

  before :each do
    @c = Class.new
    @c.send(:include, BooleanAttributes)
    @c.send(:b_attr_writer, :valid)
    @o = @c.new
  end

  it 'should set @attr' do
    @o.valid = true
    @o.instance_variable_get(:@valid).should == true
  end

  it 'should return the value @attr was set to' do
    (@o.valid = 'yes!').should == 'yes!'
  end

end #<attr>=
