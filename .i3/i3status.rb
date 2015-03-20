#!/usr/bin/ruby
require 'json'
require 'io/console'
require 'date'

require 'sqlite3'
require "dbus"

require 'pp'

db = SQLite3::Database.open "/home/marcos_sandim/.local/share/hamster-applet/hamster.db"
query = 'SELECT a.name,
			   f.start_time
		FROM main.facts f
		JOIN main.activities a ON f.activity_id = a.id
		WHERE end_time IS NULL
			AND start_time >=
				(SELECT max(end_time)
				 FROM main.facts)
		ORDER BY start_time DESC'

emotesArray = [{:text => 'dance!',
		   :data => ['/o/',
					'|o/',
					'\o\\',
					'\o|',
					'<o/',
					'<o>',
					'\\o>',
					'~o^']},
		  {:text => 'run!',
		   :data => [
					 '\\o\\                   ',
					 ' \\o\\                  ',
					 '  \\o\\                 ',
					 '   \\o\\                ',
					 '    \\o\\               ',
					 '     \\o\\              ',
					 '      \\o\\             ',
					 '       \\o\\            ',
					 '        \\o\\           ',
					 '         \\o\\          ',
					 '          \\o\\         ',
					 '           \\o\\        ',
					 '            \\o\\       ',
					 '             \\o\\      ',
					 '              \\o\\     ',
					 '               \\o\\    ',
					 '                \\o\\   ',
					 '                 \\o\\  ',
					 '                  \\o\\ ',
					 '                   \\o\\',
					 '                   /o/',
					 '                  /o/ ',
					 '                 /o/  ',
					 '                /o/   ',
					 '               /o/    ',
					 '              /o/     ',
					 '             /o/      ',
					 '            /o/       ',
					 '           /o/        ',
					 '          /o/         ',
					 '         /o/          ',
					 '        /o/           ',
					 '       /o/            ',
					 '      /o/             ',
					 '     /o/              ',
					 '    /o/               ',
					 '   /o/                ',
					 '  /o/                 ',
					 ' /o/                  ',
					 '/o/                   '
					 ]}]

currentEmote = 0;
currentData = 0;

while $stdin.gets
	s = $_

	putComma = false
	if s[0] == ','
		newS = s[1, s.length]
		putComma = true;
	else
		newS = s;
	end

	begin
		data = JSON.load(newS)

		# Uptime
		uptimeSecs = IO.read('/proc/uptime').split()[0].to_i
		uptime = (uptimeSecs/3600).to_s.rjust(2, '0') + ':' + (uptimeSecs%3600/60).to_s.rjust(2, '0')
		data.unshift(Hash["name" => "uptime", "full_text" => "up: "+uptime, "color" => "#008800"])

		# Hamster activity
		activity = db.get_first_row query
		if (activity)
			duration = (Time.now - Time.parse(activity[1])).to_i;
			durationText = (duration/3600).to_s.rjust(2, '0') + ':' + (duration%3600/60).to_s.rjust(2, '0')
			data.unshift(Hash["name" => "hamster_activity", "full_text" => activity[0]+": "+durationText, "color" => "#00EE00"])
		else
			data.unshift(Hash["name" => "hamster_activity", "full_text" => 'no activity', "color" => "#0000EE"])
		end

		# DANCE!
		data << Hash["name" => "trade", "full_text" => emotesArray[currentEmote][:text]+" "+emotesArray[currentEmote][:data][currentData], "color" => "#888888"]
		currentData += 1
		if currentData >= emotesArray[currentEmote][:data].length
			currentData = 0
			if (rand < 0.7)
				currentEmote = (currentEmote+1)%emotesArray.length
			end
		end

		# Spotify
		begin
			bus = DBus::SessionBus.instance
			spotify_service   = bus["org.mpris.MediaPlayer2.spotify"]
			spotify_object    = spotify_service.object "/org/mpris/MediaPlayer2"
			spotify_object.introspect
			#puts spotify_object.introspect
			#spotify_object.PlayPause
			#print spotify_object.inspect
			#print "\n\n"
			#spotify_interface = spotify_object["org.freedesktop.DBus.Properties"]
			#pp spotify_interface
			#print "\n\n"

			status =  spotify_object.Get "org.mpris.MediaPlayer2.Player", "PlaybackStatus"
			metadata = spotify_object.Get "org.mpris.MediaPlayer2.Player", "Metadata"
			str = metadata[0]["xesam:artist"][0] + " - " + metadata[0]["xesam:title"] + " [" + status[0] + "]";
			data.unshift(Hash["name" => "spotify_status", "full_text" => str, "color" => "#AAAAAA"])
		rescue
			#data.unshift(Hash["name" => "spotify_status", "full_text" => '', "color" => "#AAAAAA"])
		end

		if putComma
			print "\n,"
		end

		print data.to_json

	rescue #Exception
		#pp $!, $@
		print s
	end

	STDOUT.flush

	#print "\n\n\n"
end
