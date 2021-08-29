# s*lua*ggo

[Sluggo slug generator][sluggo] implemented in [Lua]. Primarily intended for (although
not limited to) use in [Pandoc filters][pandoc].


## References

 * [sluggo.js][sluggo]
 * utf8data.lua — originally (?) from [here][wowace], but more recently found
   [here][lualabs], and other locations.

[sluggo]: https://github.com/apostrophecms/sluggo
[lua]: https://en.wikipedia.org/wiki/Lua_%28programming_language%29
[pandoc]: https://pandoc.org/lua-filters.html
[wowace]: https://web.archive.org/web/20161030200131/http://www.wowace.com/addons/utf8/
[lualabs]: https://github.com/irr/lua-labs/tree/master/utf-8
[pkgpath]: http://www.lua.org/manual/5.3/manual.html#pdf-package.path


## Installation

Copy the following files to a directory in which Lua will look for packages:

 * `sluaggo.lua`
 * `sluggo_ranges.lua`
 * `utf8case.lua`
 * *`utf8data.lua`*

(Note that `utf8data.lua` is not required if this file is already in the package path.)

Or, add the `sluaggo` directory to your shell’s `LUA_PATH`:

```bash
export LUA_PATH='$HOME/some/dir/sluaggo/?.lua;;'
```

(Note the [double semicolon][pkgpath].)

Or, Lua’s `package.path`:

```lua
package.path = os.getenv('HOME')..'/some/dir/sluaggo/?.lua;'..package.path
```


## Usage

```lua
local slugago = require('sluaggo')

s = sluaggo.sluaggo('@ monkey\'s are elab؉؉orate fools##')
print(s)
```

Outputs:

```
monkey-s-are-elab-orate-fools
```

## Options

### separator

Change the string separator by passing a string (usually one character) to `separator`.

```lua
local slugago = require('sluaggo')

s = sluaggo.sluaggo('monkey\'s are elaborate fools', { separator = ','})
print(s)
```

Outputs:

```
monkey,s,are,elaborate,fools
```

### allow

Set a single-character string to allow in returned strings. Otherwise all
punctuation characters are replaced by the separator.

```lua
local sluaggo = require('sluaggo')

s = sluaggo.sluaggo('@ monkey\'s are elab؉؉orate fools##', { allow = '؉'})
print(s)
```

Outputs:

```
monkey-s-are-elab؉؉orate-fools
```
