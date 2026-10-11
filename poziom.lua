local args = {...}
local x = tonumber(args[1])
local z = tonumber(args[2])

if not x or not z or x < 1 or z < 1
    or x % 1 ~= 0 or z % 1 ~= 0 then
    print("Uzycie: kopanie X Z")
    return
end

local function kopDoPrzodu()
    if turtle.detect() then
        turtle.dig()
        sleep(0.2)
    end

    if turtle.detect() then
        print("Blok nie daje sie wykopac!")
        return false
    end

    if not turtle.forward() then
        print("Nie mozna isc do przodu.")
        return false
    end

    return true
end

local function zmienRzad(prawo)
    if prawo then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end

    local ok = kopDoPrzodu()

    if prawo then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end

    return ok
end

for row = 1, z do
    for col = 1, x - 1 do
        if not kopDoPrzodu() then
            print("Przerwano kopanie.")
            return
        end
    end

    if row < z then
        local ok

        if row % 2 == 1 then
            ok = zmienRzad(true)
        else
            ok = zmienRzad(false)
        end

        if not ok then
            print("Przerwano kopanie.")
            return
        end
    end
end

print("Kopanie zakonczone!")
