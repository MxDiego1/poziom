-- Uzycie: kopanie <X> <Z>

local args = {...}

local x = tonumber(args[1])
local z = tonumber(args[2])

if not x or not z or x < 1 or z < 1
    or x % 1 ~= 0 or z % 1 ~= 0 then
    print("Uzycie: kopanie <X> <Z>")
    print("Przyklad: kopanie 10 10")
    return
end

local function kopPrzod()
    while turtle.detect() do
        if not turtle.dig() then
            print("Nie mozna wykopac bloku!")
            return false
        end
        sleep(0.2)
    end

    while not turtle.forward() do
        if turtle.detect() then
            turtle.dig()
        else
            print("Brak miejsca lub problem z ruchem!")
            return false
        end
        sleep(0.2)
    end

    return true
end

local function kopBok()
    while turtle.detect() do
        if not turtle.dig() then
            print("Nie mozna wykopac bloku!")
            return false
        end
        sleep(0.2)
    end
    return true
end

for row = 1, z do
    for col = 1, x - 1 do
        if not kopPrzod() then return end
    end

    if row < z then
        if row % 2 == 1 then
            turtle.turnRight()
            if not kopBok() then return end
            turtle.turnRight()
        else
            turtle.turnLeft()
            if not kopBok() then return end
            turtle.turnLeft()
        end
    end
end

print("Kopanie zakonczone!")
