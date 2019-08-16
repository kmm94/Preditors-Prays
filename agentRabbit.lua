-- Import valid Rana lua libraries.
Stat = require "ranalib_statistic"
Move = require "ranalib_movement"
Collision = require "ranalib_collision"
Utility = require "ranalib_utility"
Agent = require "ranalib_agent"
Event =  require "ranalib_event"
Constants = require "PPConstants"

--parameters
Counter = 1

-- Initialization of the agent.
function InitializeAgent()
	
	say("The Rabbit#: " .. ID .. " has been initialized")
	Speed = 10
	GridMove = true
    Moving = true
    Agent.changeColor{id=ID, g=255}

end


function TakeStep()        
        if Counter% 1500 == 0 then
            Move.toRandom()
            
        end
	
	Counter = Counter +1
end

function HandleEvent(event)
    if event.description == Constants.attack and event.table.targetID == ID then
        say("Rabbit#: "..ID.. " Im dead")
        Event.emit{Speed=100, description = Constants.consumed, table={targetID=event.ID}}
        Agent.removeAgent(ID)
    end
    if event.description == Constants.whoAreYou and event.table.targetID == ID then
        Event.emit{Speed=0, description= Constants.Rabbit, table={targetID=event.ID}}
    end
end

