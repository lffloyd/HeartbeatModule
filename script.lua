function call(topic, message)
	print("Topic: "..topic.."\tMsg.: "..message)
end

function getHeartbeatRate()
	client:handler()
	socket.sleep(1)
	print(i)
	i=i+1
end

--Makes the program wait for 'n' seconds.
function sleep(n)
	local ntime = os.clock() + n
  	repeat until os.clock() > ntime
end

--Draws a text on the screen.
function drawText(topic, message)
	call(topic, message)
	canvas:attrColor('black')
	canvas:drawRect('fill', 0, 0, canvas:attrSize())
	canvas:attrFont("vera", 36)
	canvas:attrColor("white")
	canvas:drawText(0, 50, string.format("Topic: %s\tMsg.: %s", topic, message))
	canvas:flush()
end

server = 'm11.cloudmqtt.com'
user = 'ghpqajfd'
password = 'LxnxmMcKgIYt'
port = 17639

--Variables for MQTT client use.
mqtt = require 'paho.mqtt'
socket = require 'socket'
client = mqtt.client.create(server, port, drawText)

client:auth(user, password)
client:connect('conn_eyre')
client:subscribe({'oi'})

--'Handler' function.
function handler(evt)
	i=1
	while (true) do	getHeartbeatRate() end
end

event.register(handler)