sluaggo = {};


require("utf8case")
require("sluggo_ranges")


function sluaggo.sluaggo(s, options)
  local n = '';
  local bad;
  -- typecast other things to string carefully
  if (s == nil) then
    s = '';
  end
  if (type(s) ~= 'string') then
    if (tostring(s) ~= nil) then
      s = tostring(s);
    else
      s = '';
    end
  end
  if (options == nil) then
    options = {};
  end

  local separator = options.separator or '-';

  local i, j;

  -- Track whether last character was also bad to
  -- prevent duplicate dashes.
  --
  -- Starting this out true prevents leading dashes
  local lastBad = true;

  local startOfMostRecentRun;

  for i, code in utf8.codes(s) do
    bad = false;
    if ((options.allow ~= nil) and (options.allow == utf8.char(code))) then
      -- Make an exception
    else
      -- efficient binary search for a disallow character code
      local low = 1;
      local high = #_sluggoRanges;
      while (true) do
        j = (low + high) >> 1;
        if ((code >= _sluggoRanges[j][1]) and (code <= _sluggoRanges[j][2])) then
          bad = true;
          break;
        end
        if (j == low) then
          break;
        end
        if (code <= _sluggoRanges[j][1]) then
          high = j - 1;
        else
          low = j + 1;
        end
      end
    end
    if (bad) then
      if (not lastBad) then
        -- Use string.len not utf8.len as we'll use this with string.sub later
        startOfMostRecentRun = n:len();
        n = n .. separator;
      end
    else
      n = n .. utf8.lowerchar(utf8.char(code));
    end
    lastBad = bad;
  end
  -- Remove trailing dashes
  if (lastBad) then
    n = n:sub(1, startOfMostRecentRun);
  end
  if (n:len() == 0) then
    -- No slug at all is usually bad news for Express wildcard routes, etc.
    n = options.def or 'none';
  end
  return n;
end


return sluaggo
