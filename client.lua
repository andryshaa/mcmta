-- Наборосок хуйни
-- v0.0.2beta


-- Генерация 4х чанков
setTimer(function()
    for x = 0, 8 do
        for y = 0, 8 do
            createChunk(x, y)
        end
    end
end, 500, 1)

-- pre make chunk


-- Render
blockinrender = 0
world.polygoninrender = 0

showChat(false)

local screenWidth, screenHeight = guiGetScreenSize ( )
local fps = 0
local nextTick = 0

local function updateFPS(msSinceLastFrame)
    local now = getTickCount()
    if (now >= nextTick) then
        fps = math.floor((1 / msSinceLastFrame) * 1000)
        nextTick = now + 1000
    end
end
addEventHandler("onClientPreRender", root, updateFPS)

addEventHandler("onClientRender", root, function()
    local camx, camy, camz, camlx, camly, camlz = getCameraMatrix ()

    world.camera.position = Vector3(camx, camy, camz)

    for chunkid, chunkdata in pairs(world.chunks) do
        drawChunk(chunkid)
    end
    --[[
    for chunkid, chunkdata in pairs(chunks) do
        for x, ty in pairs(chunkdata.blocks) do
            for y, tz in pairs(ty) do
                for z, idBlock in pairs(tz) do
                    if idBlock ~= 0 then
                        --dxDrawText ( '[c'..chunkid..'] block:' .. coordsBlock.x ..','..coordsBlock.y..','..coordsBlock.z, 50, 50 + texty, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1.3 )
                        --texty = texty + 20
                        drawBlock(1, x, y, z, chunkid)
                    end
                end
            end
            --local startCoords = startPosition + 
            --dxDrawMaterialLine3D(x, y, z, lx, ly, lz, dot, h, c or white, ...)
        end
    end
    ]]
    dxDrawText ( 'blocks: '..blockinrender..' | polygons: '..world.polygoninrender..' | FPS: '..fps, 50, 30, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1.3 )

    blockinrender = 0
    --polygoninrender = 0
end)
