tVertexSides = {
    ['left'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x, y, z+1, tocolor(x*10, y*10, z*10, 255)},

            {x, y, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)}
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end,
    ['right'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x+1, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)},

            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z, tocolor(x*10, y*10, z*10, 255)},
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end,
    ['bottom'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x+1, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x, y, z, tocolor(x*10, y*10, z*10, 255)},

            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z, tocolor(x*10, y*10, z*10, 255)}
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end,
    ['top'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y, z+1, tocolor(x*10, y*10, z*10, 255)},

            {x, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)}
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end,
    ['back'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)},

            {x, y, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y, z+1, tocolor(x*10, y*10, z*10, 255)}
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end,
    ['front'] = function(oldt, x,y,z)
        local nt = oldt
        local ver = {
            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},

            {x, y+1, z+1, tocolor(x*10, y*10, z*10, 255)},
            {x, y+1, z, tocolor(x*10, y*10, z*10, 255)},
            {x+1, y+1, z+1, tocolor(x*10, y*10, z*10, 255)}
        }
        for i, v in ipairs(ver) do
            table.insert(nt, v)
        end
        return nt
    end
}

local maxDistanceRender = 7

local dot = dxCreateTexture('px.jpg')
local white = tocolor(255, 255, 255, 255)

function drawChunk(chunkid)
    local chunk = world.chunks[chunkid]

    --local distance = math.sqrt( (camera.position.x-coordsBlock.x)^2 + (camera.position.y-coordsBlock.y)^2 )
    --if distance > maxDistanceRender then
        --return false
    --end

    --blockinrender = blockinrender + 1
    for k, v in pairs(chunk.vertexes) do
        dxDrawPrimitive3D("trianglelist", false, unpack(v))
    end
end