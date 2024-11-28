-- Генерация чанка
world.chunks = {}

print(123123)

function getBlockTable( blockid )
    idmaterial = blockid or false
    
    return { blockid = idmaterial }
end

-- pre make vertex chunk
function makeVertexChunk( chunkid )
    chunkdata = world.chunks[chunkid]

    local idTable = 1
    local idVert = 1

    for x, ty in pairs(chunkdata.blocks) do
        for y, tz in pairs(ty) do
            for z, blockData in pairs(tz) do
                if blockData.blockid then
                    if not chunkdata.vertexes[idTable] then
                        chunkdata.vertexes[idTable] =  {}
                    end
                    local coordsBlock = startPosition + 
                        Vector3(x, y, z) - 
                        Vector3(1, 1, 1) + 
                        Vector3(
                            chunkdata.position.x*widthWorld, 
                            chunkdata.position.y*widthWorld,
                        0)

                    local tVertex =  {}
                    if chunkdata.blocks[x][y][z+1] then
                        if not chunkdata.blocks[x][y][z+1].blockid then
                            tVertex = tVertexSides['top'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                            world.polygoninrender = world.polygoninrender + 1
                        end
                    end
                    -- bottom
                    if y > 0 then
                        if chunkdata.blocks[x][y][z-1] then
                            if not chunkdata.blocks[x][y][z-1].blockid then
                                tVertex = tVertexSides['bottom'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                                world.polygoninrender = world.polygoninrender + 1
                            end
                        end
                    end
                    -- left
                    if x < widthWorld and x > 1 then
                        if chunkdata.blocks[x-1][y][z] then
                            if not chunkdata.blocks[x-1][y][z].blockid then
                                tVertex = tVertexSides['left'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                                world.polygoninrender = world.polygoninrender + 1
                            end
                        end
                    else
                        tVertex = tVertexSides['left'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                        world.polygoninrender = world.polygoninrender + 1
                    end
                    -- right
                    if x < widthWorld then
                        if chunkdata.blocks[x+1][y][z] then
                            if not chunkdata.blocks[x+1][y][z].blockid then
                                tVertex = tVertexSides['right'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                                world.polygoninrender = world.polygoninrender + 1
                            end
                        end
                    else
                        tVertex = tVertexSides['right'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                        world.polygoninrender = world.polygoninrender + 1
                    end
                    -- front
                    if y < widthWorld then
                        if chunkdata.blocks[x][y+1][z] then
                            if not chunkdata.blocks[x][y+1][z].blockid then
                                tVertex = tVertexSides['front'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                                world.polygoninrender = world.polygoninrender + 1
                            end
                        end
                    else
                        tVertex = tVertexSides['front'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                        world.polygoninrender = world.polygoninrender + 1
                    end
                    -- back
                    if y < widthWorld and y > 1 then
                        if chunkdata.blocks[x][y-1][z] then
                            if not chunkdata.blocks[x][y-1][z].blockid then
                                tVertex = tVertexSides['back'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                                world.polygoninrender = world.polygoninrender + 1
                            end
                        end
                    else
                        tVertex = tVertexSides['back'](chunkdata.vertexes[idTable], coordsBlock.x, coordsBlock.y, coordsBlock.z)
                        world.polygoninrender = world.polygoninrender + 1
                    end
                    chunkdata.vertexes[idTable] = tVertex

                    idVert = idVert + 1
                    if #chunkdata.vertexes[idTable] >= world.limitTableVertex then
                        idTable = idTable + 1
                        idVert = 1
                    end
                end
            end
        end
    end
end

local smoothiness = 170
local seed = math.random(1,999299929)
function generateChunkPixel (id, xx, yy) -- perlin noise
    for x = world.chunks[id].position.x*widthWorld, world.chunks[id].position.x*widthWorld+widthWorld do
        for y = world.chunks[id].position.y*widthWorld, world.chunks[id].position.y*widthWorld+widthWorld do
            if x-world.chunks[id].position.x*widthWorld == xx and y-world.chunks[id].position.y*widthWorld == yy then
                local z = math.min(math.max(perlin_2d(x / smoothiness, y / smoothiness, seed), -1), 1)
                return math.floor(-1*z*heightWorld)
            end
        end
    end
end

function generateChunk (id)
    --local chunk = world.chunks[id]
    for x = 1, widthWorld do
        for y = 1, widthWorld do
            local z = generateChunkPixel(id, x, y)
            if z then
                --world.chunks[id].blocks[x][y][z] = getBlockTable('core:dirt')
                --for i = 1, 1 do
                    world.chunks[id].blocks[x][y][z] = getBlockTable('core:dirt')
                --end
            end
        end
    end
    makeVertexChunk(id)
end

function createChunk(cx, cy)
    id = #world.chunks+1
    world.chunks[id] = { position = { x = cx, y = cy }, blocks = {}, vertexes = {} }
    for x = 1, widthWorld do
        world.chunks[id].blocks[x] = {}
        for y = 1, widthWorld do
            world.chunks[id].blocks[x][y] = {}
            for z = 1, heightWorld do
                world.chunks[id].blocks[x][y][z] = getBlockTable()
            end
        end
    end
    generateChunk(id)
end