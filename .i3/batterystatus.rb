#!/usr/bin/ruby
require 'json'
require 'io/console'
require 'pp'

class Integer
	def to_b
		!self.zero?
	end
end

connected = IO.read('/sys/class/power_supply/ACAD/online').to_i.to_b
if (!connected)
	energyFull = IO.read('/sys/class/power_supply/BAT1/energy_full_design').to_f
	energyNow = IO.read('/sys/class/power_supply/BAT1/energy_now').to_f

	batLevel = ((energyNow/energyFull)*100).round(2)

	if (batLevel < 20)
		exec('DISPLAY=:0 xcowsay --cow-size=large "FODEO: bateria a ' + batLevel.to_s + '%"')
	#else
	#	exec('xcowsay "bateria a ' + batLevel.to_s + '%"')
	end
end
