# string-direction

`string-direction` is a ruby `String` extension for automatic detection of the direction (left-to-right, right-to-left or bi-directional) in which a text should be displayed.

Mainly, it exposes four new methods to `String` instances. `direction` can return `ltr`, `rtl` or `bidi` depending on the characters used in the string. There are as well `is_ltr?`, `is_rtl?` and `is_bidi?` convenient predicate methods.

```ruby
#encoding: utf-8
require 'string-direction'

p 'english'.direction #=> "ltr"
p 'العربية'.direction #=> "rtl"
p 'english العربية'.direction #=> "bidi"

p 'english'.is_ltr? #=> "true"
p 'العربية'.is_ltr? #=> "false"
p 'العربية'.is_rtl? #=> "true"
p 'english العربية'.is_bidi? #=> "true"
```

## Unicode marks
If Unicode marks [left-to-right](http://en.wikipedia.org/wiki/Left-to-right_mark) (\u200e) or [right-to-left](http://en.wikipedia.org/wiki/Right-to-left_mark) (\u200f) are present, then `string-direction` rely on them instead of trying to guess from the characters used.

```ruby
p "\u200eالعربية".direction #=> "ltr"
p "\u200fEnglish".direction #=> "rtl"
```

## Changing default right-to-left scripts
By default, `string-direction` consider following scripts to have a right-to-left writing:

* Arabic
* Hebrew
* Nko
* Kharoshthi
* Phoenician
* Syriac
* Thaana
* Tifinagh

You can change easily these defaults interacting with the array `StringDirection.rtl_scripts`

```ruby
p 'ᚪᚫᚬᚭᚮᚯ'.direction #=> "ltr"
StringDirection.rtl_scripts << 'Runic'
p 'ᚪᚫᚬᚭᚮᚯ'.direction #=> "rtl"
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
