# boolean\_attributes

## Quickstart

```ruby
require 'boolean_attributes'

class Option
  # Make the helper methods for boolean attributes available in this class.
  include BooleanAttributes

  # Define getter/setter methods for the boolean instance attributes @valid and
  # @required.
  b_attr_accessor :valid, :required
end

o = Option.new
o.valid = true
o.valid?         # => true
o.required?      # => false
```

## Synopsis

The `boolean_attributes` gem provides convenient methods to dynamically define
boolean attributes on Ruby classes. When you `include` the module
`BooleanAttributes` in any class, it will define the following three class
methods:

1. `b_attr_accessor` -- defines both getter and setter methods for the given
   attribute(s). You can also use `b_attr` as an alias.
2. `b_attr_writer` -- defines a setter method for the given attribute(s).
3. `b_attr_reader` -- defines a 'getter' method for the given attribute(s).
   Since we're dealing with boolean attributes here, the 'getter' method is
   `#attr?` rather than `#attr`.

## 'Getter' method (`#attr?`)

Using `b_attr_reader` or `b_attr_accessor` with `:attr` as the parameter
defines the instance method `#attr?` Depending on the value of the associated
instance variable `@attr`, this method returns the following:

1. `false` if `@attr` is `false` or `nil`.
2. `true` if `@attr` is neither `false` nor `nil`.

This follows the Ruby convention of treating everything that is not `false` or
`nil` as `true` where appropriate.

## Inheritance

The methods that you get when including `BooleanAttributes` are inherited by
all child classes. So if you don't mind namespace pollution, you can include
it in `Object` and use the helper methods in all classes of your application.

```
require 'boolean_attributes'
include BooleanAttributes

class Option
  b_attr_accessor :valid
end

Option.new.valid? # => false
```

Unfortunately, class methods are not inherited from modules, so you can't
include `BooleanAttributes` in the top level module of your library and use it
for classes defined within that module.

## How It Works

Usually, including a module in a class will only make the module's _instance
methods_ available, not its _class methods_ (or module methods).
`boolean_attributes` uses a rather nasty hack to get around this problem: It
redefines `BooleanAttribute#append_features`, which is the method that
determines what happens when the module is included in another module or class.
This essentially overrides the standard Ruby inheritance mechanism.

**Word of warning:** I can't claim to fully understand the implications of that
hack. The standard use case of including `BooleanAttributes` via
`Class.include` is fairly thoroughly tested and should work as expected, but
I can't guarantee that special configurations etc. don't cause subtle problems.

## Non-Gem Usage

If you find a gem to be too much overhead for a simple library like this,
just copy `lib/boolean_attributes.rb` to your project and `require` it.

## Contributing

Please do! I'm very happy about any ideas on how to make this library or its
documentation better (ideally in the form of a pull request :]). If you
discover any bugs, please [open an
issue](http://github.com/JLimperg/boolean_attributes/issues) on Github.

## License

`boolean_attributes` is distributed under the terms of the MIT license. You can
find a copy in the `LICENSE` file or under <http://opensource.org/licenses/MIT>.
