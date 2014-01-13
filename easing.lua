-- Adapted from Robert Penner's easing equations
-- http://www.robertpenner.com
-- Bruno Barbosa Pinheiro 2012
-- brunobp07@gmail.com

--[[
Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]


EasingLib = {}

-- Back
EasingLib.defaultBackOvershoot = 1.70158

EasingLib.inBack = function(time,duration,initial,delta,overshoot)
	local s = EasingLib.defaultBackOvershoot
	if overshoot then s = overshoot end
	local elapsed = time/duration
	return delta * (elapsed^2) * ((s+1) * elapsed - s) + initial
end

EasingLib.outBack = function(time,duration,initial,delta,overshoot)
	local s = EasingLib.defaultBackOvershoot
	if overshoot then s = overshoot end
	local elapsed = time/duration - 1
	return delta * ((elapsed^2) * ((s + 1) * elapsed + s) + 1) + initial
end

EasingLib.inOutBack = function(time,duration,initial,delta,overshoot)
	local s = EasingLib.defaultBackOvershoot * 1.525
	if overshoot then s = overshoot end
	local elapsed = time/(duration/2)
	if elapsed < 1 then
		return delta/2 * ((elapsed^2) * ((s+1) * elapsed - s)) + initial
	else
		elapsed = elapsed - 2
		return delta/2 * ((elapsed^2) * ((s+1) * elapsed + s) + 2) + initial
	end
end




-- Bounce
EasingLib.outBounce = function(time,duration,initial,delta)
	local elapsed = time/duration
	local modifier = 0
	if elapsed < 1/2.75 then
		elapsed = elapsed
		modifier = 0
	elseif elapsed < 2/2.75 then
		elapsed = elapsed - 1.5/2.75
		modifier = 0.75
	elseif elapsed < 2.5/2.75 then
		elapsed = elapsed - 2.25/2.75
		modifier = 0.9375
	else
		elapsed = elapsed - 2.625/2.75
		modifier = 0.984375
	end
	return delta * (7.5625 * (elapsed^2) + modifier) + initial
end

EasingLib.inBounce = function(time,duration,initial,delta)
	local outBounce = EasingLib.outBounce(duration - time,duration,0,delta)
	return delta - outBounce + initial	
end

EasingLib.inOutBounce = function(time,duration,initial,delta)
	if time < duration/2 then 
		return EasingLib.inBounce(2 * time,duration,0,delta) * 0.5 + initial
	else 
		return EasingLib.outBounce(time * 2 - duration,duration,0,delta) * 0.5 + delta * 0.5 + initial
	end
end




-- Circ
EasingLib.inCirc = function(time,duration,initial,delta)
	local elapsed = time/duration
	return -delta * (math.sqrt(1 - (elapsed^2)) - 1) + initial
end

EasingLib.outCirc = function(time,duration,initial,delta)
	local elapsed = time/duration - 1
	return delta * math.sqrt(1 - (elapsed^2)) + initial
end

EasingLib.inOutCirc = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed < 1 then
		return -delta/2 * (math.sqrt(1 - (elapsed^2)) - 1) + initial
	else
		elapsed = elapsed - 2
		return delta/2 * (math.sqrt(1 - (elapsed^2)) + 1) + initial
	end
end




-- Cubic
EasingLib.inCubic = function(time,duration,initial,delta)
	local elapsed = time/duration
	return delta * (elapsed^3) + initial
end

EasingLib.outCubic = function(time,duration,initial,delta)
	local elapsed = time/duration - 1
	return delta * ((elapsed^3) + 1) + initial
end

EasingLib.inOutCubic = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed < 1 then
		return delta/2 * (elapsed^3) + initial
	else
		elapsed = elapsed - 2
		return delta/2 * ((elapsed^3) + 2) + initial
	end
end




-- Elastic
EasingLib.defaultElasticAmplitude = 0
EasingLib.defaultElasticPeriod = 0

EasingLib.inElastic = function(time,duration,initial,delta,period,amplitude)
	local elapsed = time/duration
	if elapsed == 0 then return initial end
	if elapsed == 1 then return initial + delta end
	
	local p = EasingLib.defaultElasticPeriod
	if period then p = period end
	if p == 0 then p = duration * 0.3 end
	
	local s = 0
	local a = EasingLib.defaultElasticAmplitude
	if amplitude then a = amplitude end
	if a == 0 or a < math.abs(delta) then
		a = delta
		s = p/4	
	else
		s = p/(2 * math.pi) * math.asin(delta/a)
	end
	
	elapsed = elapsed - 1
	return -(a * (2^(10*elapsed)) * math.sin((elapsed * duration - s) * (2 * math.pi)/p )) + initial
end

EasingLib.outElastic = function(time,duration,initial,delta,period,amplitude)
	local elapsed = time/duration
	if elapsed == 0 then return initial end
	if elapsed == 1 then return initial + delta end
	
	local p = EasingLib.defaultElasticPeriod
	if period then p = period end
	if p == 0 then p = duration * 0.3 end
	
	local s = 0
	local a = EasingLib.defaultElasticAmplitude
	if amplitude then a = amplitude end
	if a == 0 or a < math.abs(delta) then
		a = delta
		s = p/4	
	else
		s = p/(2 * math.pi) * math.asin(delta/a)
	end
	
	return a * (2^(-10 * elapsed)) * math.sin((elapsed * duration - s) * (2 * math.pi)/p) + delta + initial
end

EasingLib.inOutElastic = function(time,duration,initial,delta,period,amplitude)
	local elapsed = time/(duration/2)
	if elapsed == 0 then return initial end
	if elapsed == 2 then return initial + delta end
	
	local p = EasingLib.defaultElasticPeriod
	if period then p = period end
	if p == 0 then p = duration * 0.3 * 1.5 end
	
	local s = 0
	local a = EasingLib.defaultElasticAmplitude
	if amplitude then a = amplitude end
	if a == 0 or a < math.abs(delta) then
		a = delta
		s = p/4	
	else
		s = p/(2 * math.pi) * math.asin(delta/a)
	end
	
	
	if elapsed < 1 then
		elapsed = elapsed - 1
		return -0.5 * (a * (2^(10*elapsed)) * math.sin((elapsed * duration - s) * (2 * math.pi)/p)) + initial
	else
		elapsed = elapsed - 1
		return a * (2^(-10 * elapsed)) * math.sin((elapsed * duration - s) * (2 * math.pi)/p) * 0.5 + delta + initial
	end
end





-- Expo
EasingLib.inExpo = function(time,duration,initial,delta)
	if time == 0 then return initial end
	return delta * (2^(10 * (time/duration - 1))) + initial
end

EasingLib.outExpo = function(time,duration,initial,delta)
	if time == duration then return initial + delta end
	return delta * (-(2^(-10 * time/duration)) + 1) + initial
end

EasingLib.inOutExpo = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed == 0 then return initial end
	if elapsed == 1 then return initial + delta end
	if elapsed < 1 then
		return delta/2 * (2^(10 * (elapsed - 1))) + initial
	else
		elapsed = elapsed - 1
		return delta/2 * (-(2^(-10 * elapsed)) + 2) + initial
	end
end





-- Linear
EasingLib.linear = function(time,duration,initial,delta)
	return delta * time/duration + initial
end





-- Quad
EasingLib.inQuad = function(time,duration,initial,delta)
	local elapsed = time/duration
	return delta * (elapsed^2) + initial
end

EasingLib.outQuad = function(time,duration,initial,delta)
	local elapsed = time/duration
	return -delta * elapsed * (elapsed - 2) + initial
end

EasingLib.inOutQuad = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed < 1 then
		return delta/2 * (elapsed^2) + initial
	else
		elapsed = elapsed - 1
		return -delta/2 * ((elapsed) * (elapsed - 2) -1) + initial
	end
end





-- Quart
EasingLib.inQuart = function(time,duration,initial,delta)
	local elapsed = time/duration
	return delta * (elapsed^4) + initial
end

EasingLib.outQuart = function(time,duration,initial,delta)
	local elapsed = time/duration - 1
	return -delta * ((elapsed^4) - 1) + initial
end

EasingLib.inOutQuart = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed < 1 then
		return delta/2 * (elapsed^4) + initial
	else
		elapsed = elapsed - 2
		return -delta/2 * ((elapsed^4) - 2) + initial
	end
end





-- Quint
EasingLib.inQuint = function(time,duration,initial,delta)
	local elapsed = time/duration
	return delta * (elapsed^5) + initial
end

EasingLib.outQuint = function(time,duration,initial,delta)
	local elapsed = time/duration - 1
	return delta * ((elapsed^5) + 1) + initial
end

EasingLib.inOutQuint = function(time,duration,initial,delta)
	local elapsed = time/(duration/2)
	if elapsed < 1 then 
		return delta/2 * (elapsed^5) + initial
	else
		elapsed = elapsed - 2
		return delta/2 * ((elapsed^5) + 2) + initial
	end
end





-- Sine
EasingLib.inSine = function(time,duration,initial,delta)
	return -delta * math.cos(time/duration * math.pi/2) + delta + initial
end

EasingLib.outSine = function(time,duration,initial,delta)
	return delta * math.sin(time/duration * math.pi/2) + initial
end

EasingLib.inOutSine = function(time,duration,initial,delta)
	return -delta/2 * (math.cos(math.pi * time/duration) - 1) + initial
end


return EasingLib
