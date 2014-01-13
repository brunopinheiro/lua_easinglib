lua_easinglib
=========
A simple Lua port for the Robert Penner's easing equations. You can find more informations about easing functions on http://easings.net and http://www.robertpenner.com

Version
---------
1.0


Works with
--------------
- Corona SDK
 

Usage
--------------

```lua
local easing = require("easing")

local duration = 1000 -- In milliseconds
local initial = 0
local delta = 200

for time = 0, duration, 1 do
    print(easing.inBack(time,duration,initial,delta))
    -- you can use easing.inBack(time,duration,initial,delta,overshoot) to change the overshoot value. Otherwise, the default value (1.70158) will be used!
end

-- You can also change the overshoot for back easing and amplitude and period for the elastic easing.
easing.defaultBackOvershoot = 2 -- The default value is 1.70158
easing.defaultElasticAmplitude = 1 -- The default value is 0
easing.defaultElasticPeriod = 1 -- The default value is 0

```


License
--------------
MIT License
