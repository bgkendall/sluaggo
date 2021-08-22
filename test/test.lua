local sluggo
local s

sluaggo = require('sluaggo')
assert(sluaggo, 'FAILED: should be successfully initialized')

s = sluaggo.sluaggo('@ monkey\'s are elab؉؉orate fools## ')
assert(s == 'monkey-s-are-elab-orate-fools', 'FAILED: slugifies a complex unicode string [\"' .. s .. '\"]')

s = sluaggo.sluaggo('@ monkey\'s are elab؉؉orate fools##', { separator = ',', allow = '؉'})
assert(s == 'monkey,s,are,elab؉؉orate,fools', 'FAILED: slugifies a complex unicode string with allowed punctuation and a different separator [\"' .. s .. '\"]')

s = sluaggo.sluaggo('monkey-s-are-elab-orate-fools ')
assert(s == 'monkey-s-are-elab-orate-fools', 'FAILED: behaves sensibly with existing slugs [\"' .. s .. '\"]')

s = sluaggo.sluaggo('Monkeys Are Elaborate Fools ')
assert(s == 'monkeys-are-elaborate-fools', 'FAILED: converts to lowercase [\"' .. s .. '\"]')

s = sluaggo.sluaggo('/', { allow = '/' })
assert(s == '/', 'FAILED: behaves sensibly when only the allowed punctuation character is present [\"' .. s .. '\"]')

s = sluaggo.sluaggo('@#(*&@', {})
assert(s == 'none', 'FAILED: Fallback default is none (1) [\"' .. s .. '\"]')
s = sluaggo.sluaggo('', {})
assert(s == 'none', 'FAILED: Fallback default is none (2) [\"' .. s .. '\"]')
s = sluaggo.sluaggo('test', {})
assert(s == 'test', 'FAILED: Fallback default is none (3) [\"' .. s .. '\"]')

s = sluaggo.sluaggo('@#(*&@', { def = '' })
assert(s == '', 'FAILED: Empty string can be passed as default (1) [\"' .. s .. '\"]')
s = sluaggo.sluaggo('', { def = '' })
assert(s == '', 'FAILED: Empty string can be passed as default (2) [\"' .. s .. '\"]')
s = sluaggo.sluaggo('test', { def = '' })
assert(s == 'test', 'FAILED: Empty string can be passed as default (3) [\"' .. s .. '\"]')
