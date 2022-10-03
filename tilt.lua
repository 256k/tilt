--         TI////////LT
--       A study of balance 
--
-- Tilt monome to move the ball
-- Press monome to set the ball
--
-- - A script by 256k

--                      ___________________
--                     / o o o o o o o o / 
--                    / o o o o o o o o / 
--                   / o o o o o o o o / 
--                  / o o o o o o o o / 
--                 / o o o o o o o o / 
--                / o o o o o o . o /  
--               /-----------------/


g = grid.connect()

function init()
  redraw()
  gridSizeX = 8 + 1
  gridSizeY = 8 + 1


  g:tilt_enable(0, 1)
  x_delta = 0
  y_delta = 0

  point_pos = {0,0}

  framerate = 24
  clock.run(function()  
    while true do
      clock.sleep(1/framerate)
      udpatePos()
      gridRedraw() 
    end
  end)
end



g.tilt = function(_grid_id, _x, _y)
  x_delta = math.ceil( _x /4 - 32)  * -1
  y_delta = math.floor( _y /4 - 32) 
  
end

function gridRedraw()
  g:all(0)
  g:led(point_pos[1],point_pos[2], 15) 
  g:refresh()
end

function setPos(x,y)
  point_pos = {x,y}  
end

function udpatePos()
  if point_pos[1] + 1 > gridSizeX  then point_pos[1] = 8 end
  if point_pos[1] - 1 < 0 then point_pos[1] = 1 end
  if point_pos[2] + 1 > gridSizeY then point_pos[2] = 8 end
  if point_pos[2] - 1 < 0 then point_pos[2] = 1 end
  if x_delta > 0 and point_pos[1] + 1 < gridSizeX  then point_pos[1] = point_pos[1] + 1 print("1")end
  if x_delta < 0 and point_pos[1] - 1 > 0 then  point_pos[1] = point_pos[1] - 1 print("2")end
  if y_delta > 0 and point_pos[2] + 1 < gridSizeY then  point_pos[2] = point_pos[2] + 1 print("3")end
  if y_delta < 0 and point_pos[2] - 1 > 0 then  point_pos[2] = point_pos[2] - 1 print("4")end
  gridRedraw()
end

g.key = function(x, y, z) 
  if z == 1 then
    setPos(x,y)
    gridRedraw()
  end
end

function redraw()
  screen.clear()
  screen.aa(1)
  screen.move(18, 45)
  screen.font_face(8)
  screen.font_size(38)
  screen.level(15)
  screen.text("TI/_T")
  screen.update()
end


