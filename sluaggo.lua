sluaggo = {}

local _sluaggoRanges

function sluaggo.sluaggo(s, options)
  local n = ''
  local bad
  -- typecast other things to string carefully
  if (s == nil) then
    s = ''
  end
  if (type(s) ~= 'string') then
    if (tostring(s) ~= nil) then
      s = tostring(s)
    else
      s = ''
    end
  end
  if (!options) then
    options = {}
  end

  local separator = '-'
  if (options.separator ~= nil) then
    local separator = options.separator
  end

  local i, j

  -- Track whether last character was also bad to
  -- prevent duplicate dashes.
  --
  -- Starting this out true prevents leading dashes
  local lastBad = true

  local startOfMostRecentRun

  for i = 1, s:len() do
    local code = s:byte(i)
    bad = false
    if ((options.allow ~= nil) and (options.allow == s:sub(i,i))) then
      -- Make an exception
    else
      -- efficient binary search for a disallow character code
      local low = 1
      local high = #_sluaggoRanges
      while (true) do
        j = (low + high) >> 1
        if ((code >= _sluaggoRanges[j][1]) and (code <= _sluaggoRanges[j][2])) then
          bad = true
          break
        end
        if (j == low) then
          break
        end
        if (code <= _sluaggoRanges[j][1]) then
          high = j - 1
        else
          low = j + 1
        end
      end
    end
    if (bad) then
      if (not lastBad) then
        n = n .. separator              -- These two lines swapped from JS to account for
        startOfMostRecentRun = n:len()  -- Lua's 1-indexed strings vs JS' 0-indexed
      end
    else
      n = n .. s:sub(i,i):lower()
    end
    lastBad = bad
  end
  -- Remove trailing dashes
  if (lastBad) then
    n = n:sub(1, startOfMostRecentRun)
  end
  if (n:len() == 0) then
    -- No slug at all is usually bad news for Express wildcard routes, etc.
    if (options.def ~= nil) then
      n = 'none'
    else
      n = options.def
  end
  return n
}

local _sluaggoRanges = {{0,47},{58,64},{91,96},{123,169},{171,177},{180,180},{182,184},{187,187},{191,191},{215,215},{247,247},{706,709},{722,735},{741,747},{749,749},{751,879},{885,885},{888,889},{894,894},{896,901},{903,903},{907,907},{909,909},{930,930},{1014,1014},{1154,1161},{1328,1328},{1367,1368},{1370,1376},{1416,1487},{1515,1519},{1523,1567},{1611,1631},{1642,1645},{1648,1648},{1748,1748},{1750,1764},{1767,1773},{1789,1790},{1792,1807},{1809,1809},{1840,1868},{1958,1968},{1970,1983},{2027,2035},{2038,2041},{2043,2047},{2070,2073},{2075,2083},{2085,2087},{2089,2111},{2137,2207},{2227,2307},{2362,2364},{2366,2383},{2385,2391},{2402,2405},{2416,2416},{2433,2436},{2445,2446},{2449,2450},{2473,2473},{2481,2481},{2483,2485},{2490,2492},{2494,2509},{2511,2523},{2526,2526},{2530,2533},{2546,2547},{2554,2564},{2571,2574},{2577,2578},{2601,2601},{2609,2609},{2612,2612},{2615,2615},{2618,2648},{2653,2653},{2655,2661},{2672,2673},{2677,2692},{2702,2702},{2706,2706},{2729,2729},{2737,2737},{2740,2740},{2746,2748},{2750,2767},{2769,2783},{2786,2789},{2800,2820},{2829,2830},{2833,2834},{2857,2857},{2865,2865},{2868,2868},{2874,2876},{2878,2907},{2910,2910},{2914,2917},{2928,2928},{2936,2946},{2948,2948},{2955,2957},{2961,2961},{2966,2968},{2971,2971},{2973,2973},{2976,2978},{2981,2983},{2987,2989},{3002,3023},{3025,3045},{3059,3076},{3085,3085},{3089,3089},{3113,3113},{3130,3132},{3134,3159},{3162,3167},{3170,3173},{3184,3191},{3199,3204},{3213,3213},{3217,3217},{3241,3241},{3252,3252},{3258,3260},{3262,3293},{3295,3295},{3298,3301},{3312,3312},{3315,3332},{3341,3341},{3345,3345},{3387,3388},{3390,3405},{3407,3423},{3426,3429},{3446,3449},{3456,3460},{3479,3481},{3506,3506},{3516,3516},{3518,3519},{3527,3557},{3568,3584},{3633,3633},{3636,3647},{3655,3663},{3674,3712},{3715,3715},{3717,3718},{3721,3721},{3723,3724},{3726,3731},{3736,3736},{3744,3744},{3748,3748},{3750,3750},{3752,3753},{3756,3756},{3761,3761},{3764,3772},{3774,3775},{3781,3781},{3783,3791},{3802,3803},{3808,3839},{3841,3871},{3892,3903},{3912,3912},{3949,3975},{3981,4095},{4139,4158},{4170,4175},{4182,4185},{4190,4192},{4194,4196},{4199,4205},{4209,4212},{4226,4237},{4239,4239},{4250,4255},{4294,4294},{4296,4300},{4302,4303},{4347,4347},{4681,4681},{4686,4687},{4695,4695},{4697,4697},{4702,4703},{4745,4745},{4750,4751},{4785,4785},{4790,4791},{4799,4799},{4801,4801},{4806,4807},{4823,4823},{4881,4881},{4886,4887},{4955,4968},{4989,4991},{5008,5023},{5109,5120},{5741,5742},{5760,5760},{5787,5791},{5867,5869},{5881,5887},{5901,5901},{5906,5919},{5938,5951},{5970,5983},{5997,5997},{6001,6015},{6068,6102},{6104,6107},{6109,6111},{6122,6127},{6138,6159},{6170,6175},{6264,6271},{6313,6313},{6315,6319},{6390,6399},{6431,6469},{6510,6511},{6517,6527},{6572,6592},{6600,6607},{6619,6655},{6679,6687},{6741,6783},{6794,6799},{6810,6822},{6824,6916},{6964,6980},{6988,6991},{7002,7042},{7073,7085},{7142,7167},{7204,7231},{7242,7244},{7294,7400},{7405,7405},{7410,7412},{7415,7423},{7616,7679},{7958,7959},{7966,7967},{8006,8007},{8014,8015},{8024,8024},{8026,8026},{8028,8028},{8030,8030},{8062,8063},{8117,8117},{8125,8125},{8127,8129},{8133,8133},{8141,8143},{8148,8149},{8156,8159},{8173,8177},{8181,8181},{8189,8303},{8306,8307},{8314,8318},{8330,8335},{8349,8449},{8451,8454},{8456,8457},{8468,8468},{8470,8472},{8478,8483},{8485,8485},{8487,8487},{8489,8489},{8494,8494},{8506,8507},{8512,8516},{8522,8525},{8527,8527},{8586,9311},{9372,9449},{9472,10101},{10132,11263},{11311,11311},{11359,11359},{11493,11498},{11503,11505},{11508,11516},{11518,11519},{11558,11558},{11560,11564},{11566,11567},{11624,11630},{11632,11647},{11671,11679},{11687,11687},{11695,11695},{11703,11703},{11711,11711},{11719,11719},{11727,11727},{11735,11735},{11743,11822},{11824,12292},{12296,12320},{12330,12336},{12342,12343},{12349,12352},{12439,12444},{12448,12448},{12539,12539},{12544,12548},{12590,12592},{12687,12689},{12694,12703},{12731,12783},{12800,12831},{12842,12871},{12880,12880},{12896,12927},{12938,12976},{12992,13311},{19894,19967},{40909,40959},{42125,42191},{42238,42239},{42509,42511},{42540,42559},{42607,42622},{42654,42655},{42736,42774},{42784,42785},{42889,42890},{42895,42895},{42926,42927},{42930,42998},{43010,43010},{43014,43014},{43019,43019},{43043,43055},{43062,43071},{43124,43137},{43188,43215},{43226,43249},{43256,43258},{43260,43263},{43302,43311},{43335,43359},{43389,43395},{43443,43470},{43482,43487},{43493,43493},{43519,43519},{43561,43583},{43587,43587},{43596,43599},{43610,43615},{43639,43641},{43643,43645},{43696,43696},{43698,43700},{43703,43704},{43710,43711},{43713,43713},{43715,43738},{43742,43743},{43755,43761},{43765,43776},{43783,43784},{43791,43792},{43799,43807},{43815,43815},{43823,43823},{43867,43867},{43872,43875},{43878,43967},{44003,44015},{44026,44031},{55204,55215},{55239,55242},{55292,63743},{64110,64111},{64218,64255},{64263,64274},{64280,64284},{64286,64286},{64297,64297},{64311,64311},{64317,64317},{64319,64319},{64322,64322},{64325,64325},{64434,64466},{64830,64847},{64912,64913},{64968,65007},{65020,65135},{65141,65141},{65277,65295},{65306,65312},{65339,65344},{65371,65381},{65471,65473},{65480,65481},{65488,65489},{65496,65497},{65501,65535},{65548,65548},{65575,65575},{65595,65595},{65598,65598},{65614,65615},{65630,65663},{65787,65798},{65844,65855},{65913,65929},{65932,66175},{66205,66207},{66257,66272},{66300,66303},{66340,66351},{66379,66383},{66422,66431},{66462,66463},{66500,66503},{66512,66512},{66518,66559},{66718,66719},{66730,66815},{66856,66863},{66916,67071},{67383,67391},{67414,67423},{67432,67583},{67590,67591},{67593,67593},{67638,67638},{67641,67643},{67645,67646},{67670,67671},{67703,67704},{67743,67750},{67760,67839},{67868,67871},{67898,67967},{68024,68029},{68032,68095},{68097,68111},{68116,68116},{68120,68120},{68148,68159},{68168,68191},{68223,68223},{68256,68287},{68296,68296},{68325,68330},{68336,68351},{68406,68415},{68438,68439},{68467,68471},{68498,68520},{68528,68607},{68681,69215},{69247,69634},{69688,69713},{69744,69762},{69808,69839},{69865,69871},{69882,69890},{69927,69941},{69952,69967},{70003,70005},{70007,70018},{70067,70080},{70085,70095},{70107,70112},{70133,70143},{70162,70162},{70188,70319},{70367,70383},{70394,70404},{70413,70414},{70417,70418},{70441,70441},{70449,70449},{70452,70452},{70458,70460},{70462,70492},{70498,70783},{70832,70851},{70854,70854},{70856,70863},{70874,71039},{71087,71167},{71216,71235},{71237,71247},{71258,71295},{71339,71359},{71370,71839},{71923,71934},{71936,72383},{72441,73727},{74649,74751},{74863,77823},{78895,92159},{92729,92735},{92767,92767},{92778,92879},{92910,92927},{92976,92991},{92996,93007},{93018,93018},{93026,93026},{93048,93052},{93072,93951},{94021,94031},{94033,94098},{94112,110591},{110594,113663},{113771,113775},{113789,113791},{113801,113807},{113818,119647},{119666,119807},{119893,119893},{119965,119965},{119968,119969},{119971,119972},{119975,119976},{119981,119981},{119994,119994},{119996,119996},{120004,120004},{120070,120070},{120075,120076},{120085,120085},{120093,120093},{120122,120122},{120127,120127},{120133,120133},{120135,120137},{120145,120145},{120486,120487},{120513,120513},{120539,120539},{120571,120571},{120597,120597},{120629,120629},{120655,120655},{120687,120687},{120713,120713},{120745,120745},{120771,120771},{120780,120781},{120832,124927},{125125,125126},{125136,126463},{126468,126468},{126496,126496},{126499,126499},{126501,126502},{126504,126504},{126515,126515},{126520,126520},{126522,126522},{126524,126529},{126531,126534},{126536,126536},{126538,126538},{126540,126540},{126544,126544},{126547,126547},{126549,126550},{126552,126552},{126554,126554},{126556,126556},{126558,126558},{126560,126560},{126563,126563},{126565,126566},{126571,126571},{126579,126579},{126584,126584},{126589,126589},{126591,126591},{126602,126602},{126620,126624},{126628,126628},{126634,126634},{126652,127231},{127245,131071},{173783,173823},{177973,177983},{178206,194559},{195102,1114112}}

return sluaggo
