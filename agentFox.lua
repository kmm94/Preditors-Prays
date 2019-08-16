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
FoxIDs = {}
ConsumedRabbits = {}
RabbitID = 0
IsHunting=false

-- Initialization of the agent.
function InitializeAgent()	
	say("The Fox#: " .. ID .. " has been initialized")
    Agent.changeColor{id=ID, r=255}
	Speed = 15
	GridMove = true
    Moving = true
end


function TakeStep()
        
    --eat a pray
    if Counter% 1000 == 0 then

        --Eat if close to target
        local eatRange = 2
        local collisionTable = Collision.radialCollisionScan(eatRange)
        if collisionTable ~= nil then
            for i=1, #collisionTable do
                if RabbitID == collisionTable[i].id then
                    Event.emit{speed=100, description= Constants.attack, table={targetID=collisionTable[1].id}}
                    IsHunting = false
                    break
                end
            end
        end


        -- find out if im allready hunting
        if IsHunting then 
            local isTargetInsigth = false
            local huntradius = 50
            local collisionTable = Collision.radialCollisionScan(huntradius)
            if collisionTable ~= nil then
                for i=1, #collisionTable do
                    if RabbitID == collisionTable[i].id then
                        isTargetInsigth = true
                        Move.to{x=collisionTable[i].posX, y=collisionTable[i].posY, speed=30}
                        break
                    end
                end
            end
            if isTargetInsigth == false then
                say(" target got away :( ")
                IsHunting = false
            end

        else -- if not hunting then search for target
            Move.toRandom()
            -- find a Rabbit
            IsFox = false
            local huntradius = 50
            local collisionTable = Collision.radialCollisionScan(huntradius)
            if collisionTable ~= nil then
                if FoxIDs ~= nil then
                    --figure out if target is a rabbit
                    for i=1, #FoxIDs do
                        if FoxIDs[i] == collisionTable[1].id then
                            IsFox = true
                        end
                    end

                    if IsFox == false then
                        Event.emit{speed=0, description= Constants.whoAreYou, table={targetID=collisionTable[1].id}}
                        say("Fox#"..ID.." says who are you: " ..collisionTable[1].id)
                    end
                end
            end
        end
    end

	Counter = Counter +1
end

function HandleEvent(event)
    --A fox is asking who i am
    if event.description == Constants.whoAreYou and event.table.targetID==ID then 
        insertFox(event.ID)
        say("a fox has found me: "..ID.." found fox: " ..event.ID)
        Event.emit{speed=0, description=Constants.Fox, table={targetID=event.ID}}
    end

    --recived info from another fox
    if event.table.targetID == ID and event.description == Constants.Fox then
        say("I have found a fox me: "..ID.." found fox: " ..event.ID)
        insertFox(event.ID)
    end

    --found a Rabbit
    if event.description == Constants.Rabbit and event.table.targetID == ID then
        --start the hunt
        RabbitID = event.ID
        IsHunting = true
        say("Hunting: "..RabbitID)
    end

    --I have eaten a Rabbit
    if event.description == Constants.consumed and event.table.targetID == ID then
        table.insert(ConsumedRabbits, event.ID)
        say("i got it: "..event.ID)
        IsHunting = false
    end

end

function cleanUp()
    say("***----****")
    say("Fox#: "..ID)
    say("I have found foxes:")
    for i=1, #FoxIDs do
        say(FoxIDs[i])
    end
    say("I have eaten rabbit#:")
    for i=1, #ConsumedRabbits do
        say(ConsumedRabbits[i])
    end

end

function insertFox(FoxID)
    if FoxIDs ~= nil then
        for i=1, #FoxIDs do
            if FoxID == FoxIDs[i] then
                return
            end
        end
    end
    table.insert(FoxIDs, FoxID)
end