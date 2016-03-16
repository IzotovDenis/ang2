every 1.hour do
	rake "ts:index"
end

every :reboot do
	rake "ts:start"
end