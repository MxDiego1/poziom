local args = { ... }
local x = tonumber(args[1])
local z = tonumber(args[2])

if not x or not z or x < 1 or z < 1 then
  print("Uzycie: dig <x> <z>")
  print("x, z = liczby calkowite >= 1")
  return
end

-- Kopie i idzie do przodu; radzi sobie ze zwirem/piaskiem i mobami
local function forward()
  local tries = 0
  while not turtle.forward() do
    if turtle.detect() then
      turtle.dig()
    else
      turtle.attack()
    end
    tries = tries + 1
    if tries > 50 then
      error("Turtle jest zablokowany (bedrock lub inna przeszkoda)")
    end
    sleep(0.2)
  end
end


-- Kopiemy wezykiem: rzedy ida wzdluz osi x, kolejne rzedy przesuwaja sie w osi z
-- Stan: czy skrecamy w prawo (true) czy w lewo (false) na koncu rzedu
local turnRight = true

for row = 1, z do
  -- jeden rzad: x-1 krokow do przodu (pierwsza kratka to pozycja turtle'a)
  for step = 1, x - 1 do
    forward()
  end

  -- przejscie do kolejnego rzedu
  if row < z then
    if turnRight then
      turtle.turnRight()
      forward()
      turtle.turnRight()
    else
      turtle.turnLeft()
      forward()
      turtle.turnLeft()
    end
    turnRight = not turnRight
  end
end

-- Powrot na pozycje startowa
-- Po z rzedach: jesli z jest nieparzyste, turtle jest po przeciwnej stronie w osi x
if z % 2 == 1 then
  -- stoimy na koncu osi x, zwroceni do przodu (kierunek +x) -> zawracamy
  turtle.turnLeft()
  turtle.turnLeft()
  for i = 1, x - 1 do
    forward()
  end
  -- teraz zwroceni w kierunku -x; wracamy w osi z
  turtle.turnLeft()  -- patrzymy w kierunku -z (lewo od startu)
  for i = 1, z - 1 do
    forward()
  end
  turtle.turnLeft()  -- zwroceni w kierunku +x (kierunek startowy)
else
  -- stoimy na poczatku osi x, zwroceni w kierunku -x
  turtle.turnRight()  -- patrzymy w kierunku -z
  for i = 1, z - 1 do
    forward()
  end
  turtle.turnRight()  -- zwroceni w kierunku +x
  turtle.turnRight()
  turtle.turnRight()
end

print("Gotowe! Wykopano " .. x .. "x" .. z)
