agents = {
     "C:/Users/nobody/Desktop/Rana_development/lua_agents/01_pingpong.lua", 2, -- Path to the agent(s)
}
param = {
     {21},       -- Parameter '1', is a static parameter which is accessible by the agents.
     {1,100},    -- Parameter '2', going from 1 to 100, with step increments of 1.
     {1,0.1,10}, -- Parameter '3', going from 1 to 10, with step increments of 0.1.
}
sim = {
    eDistPrecision = 0.000001,
    stepPrecision = 0.001,
    mapWidth = 100,
    mapHeight = 100,
    mapScale = 1.0,
    simThreads = 4,
}
