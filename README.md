# string-direction

`string-direction` is a ruby library for automatic detection of the direction (left-to-right, right-to-left or bi-directional) in which a text should be displayed.

## Overview

```ruby
require 'string-direction'

detector = StringDirection::Detector.new

detector.direction('english') #=> 'ltr'
detector.direction('العربية') #=> 'rtl'
detector.direction("english العربية") #=> 'bidi'

detector.ltr?('english') #=> true
detector.rtl?('العربية') #=> true
detector.bidi?('english') #=> false
```

But, if you preffer, you can monkey patch `String`:

```ruby
String.send(:include, StringDirection::StringMethods)

'english'.direction #=> 'ltr'
'العربية'.rtl? #=> true
```

## Strategies

`string-direction` uses different strategies in order to try to detect the direction of a string. The detector uses them once at a time and returns the result once one of them succeeds, aborting any further analysis.

Strategies are passed to the detector during its initialization:

```ruby
detector = StringDirection::Detector.new(:foo, :bar)
```

In the above example, classes `StringDirection::FooStrategy` and `StringDirection::BarStrategy` have to be in the load path.

Two strategies are natively integrated: `marks` and `characters`. They are used, in that order, as default strategies if no arguments are given to the detector.

### marks

Looks for the presence of Unicode direction marks: [left-to-right](http://en.wikipedia.org/wiki/Left-to-right_mark) (\u200e) or [right-to-left](http://en.wikipedia.org/wiki/Right-to-left_mark) (\u200f).

```ruby
detector = StringDirection::Detector.new(:marks)

detector.direction("\u200eالعربية") #=> "ltr"
detector.direction("\u200fEnglish") #=> "rtl"
```

### characters

Looks for the presence of right-to-left characters in the scripts used in the string.

By default, `string-direction` consider following scripts to have a right-to-left writing:

* Arabic
* Hebrew
* Nko
* Kharoshthi
* Phoenician
* Syriac
* Thaana
* Tifinagh

```ruby
detector = StringDirection::Detector.new(:characters)

detector.direction('english') #=> 'ltr'
detector.direction('العربية') #=> 'rtl'
```

You can change these defaults:

```ruby
detector.direction('ᚪᚫᚬᚭᚮᚯ') #=> 'ltr'

StringDirection.configure do |config|
    config.rtl_scripts << 'Runic'
end

detector.direction('ᚪᚫᚬᚭᚮᚯ') #=> 'rtl'
```

This can be useful, mainly, for scripts that have both left-to-right and right-to-left representations:

* Bopomofo
* Carian
* Cypriot
* Lydian
* Old_Italic
* Runic
* Ugaritic

Keep in mind than only [scripts recognized by Ruby regular expressions](http://www.ruby-doc.org/core-1.9.3/Regexp.html#label-Character+Properties) are allowed.

### Custom Strategies

You can define your custom strategies. To do so, you just have to define a class inside `StringDirection` module with a name ending with `Strategy`. This class has to respond to an instance method `run` which takes the string as argument. You can inherit from `StringDirection::Strategy` to have convenient methods `ltr`, `rtl` and `bidi` which return expected result. If the strategy doesn't know the direction, it must return `nil`.

```ruby
class StringDirection::AlwaysLtrStrategy < StringDirection::Strategy
  def run(string)
    ltr
  end
end

detector = StringDirection::Detector.new(:always_ltr)
detector.direction('العربية') #=> 'ltr'
```

### Changing default strategies

`marks` and `characters` are default strategies, but you can change them:

```ruby
StringDirection.configure do |config|
    config.default_strategies = [:custom, :marks, :always_ltr]
end
```

## Release Policy

`string-direction` follows the principles of [semantic versioning](http://semver.org/).

## Disclaimer

I'm not an expert neither in World scripts nor in Unicode. So, please, if you know some case where this library is not working as it should be, [open an issue](https://github.com/laMarciana/string-direction/issues) and help improve it.

## Thanks

[Omniglot.com](http://www.omniglot.com/), where I learnt which Ruby recognized scripts have a right-to-left writing system.

## LICENSE

Copyright 2013 Marc Busqué - <marc@lamarciana.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
