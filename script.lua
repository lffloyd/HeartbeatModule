--Local variables.
local rate = 0

server = 'm11.cloudmqtt.com'
user = 'ghpqajfd'
password = 'LxnxmMcKgIYt'
port = 17639

--Variaveis para uso da biblioteca client MQTT
mqtt = require 'paho.mqtt'
socket = require 'socket'
client = mqtt.client.create(server, port, call)

client:auth(user, password)
client:connect('conn_eyre')
client:subscribe({'oi'})

function call(topico, mensagem)
	print("Tópico: "..topico.."\tMsg.: "..mensagem)
end

function getHeartbeatRate()
	--The instructions to get the rate will be here.
	--return math.random(0, 100)
	client:handler()
	socket.sleep(1)
end

--Makes the program wait for 'n' seconds.
function sleep(n)
	local ntime = os.clock() + n
  	repeat until os.clock() > ntime
end

--Draw a given text on the screen.
function drawText(rate)
	canvas:attrColor('black')
	canvas:drawRect('fill', 0, 0, canvas:attrSize())
	canvas:attrFont("vera", 36)
	canvas:attrColor("white")
	canvas:drawText(0, 50, rate)
	canvas:flush()
end

--Handles 'presentation' events.
function handler(evt)
	--if evt.class ~= 'ncl' then return end
	--if evt.type ~= 'presentation' then return end
	--if evt.action == 'start' then
		--while true do
			--sleep(1)
			--rate = getHeartbeatRate()
			--for i=1,2 do
			 	getHeartbeatRate()
			--end 
			--print("\nHeartbeat rate: "..rate)
			--drawText(rate)
		--end
	--end
end

event.register(handler)
--handler(nil)
