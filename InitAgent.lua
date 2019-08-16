Agent = require "ranalib_agent"
Collision = require "ranalib_collision"

function InitializeAgent()
    --Agent.addAgent("torus_agent.lua")
    for i=1,3 do
        Agent.addAgent("agentFox.lua")
        for i=1,10 do
        Agent.addAgent("agentRabbit.lua")
        end
    end  
    Agent.removeAgent(ID)
end