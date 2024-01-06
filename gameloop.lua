function _update()
    logDebug(">> update")	

    if player.stage == 7 then
		player.game_state = "victory"
	end

    if player.game_state == "intro" then
        logDebug("player.game_state == intro")
        camera(0,0)
        if btnp(❎) then
            logDebug("btnp(❎)")
            player.game_state = "start"
        end
    end

    if player.game_state == "start" then
        logInfo("player.game_state == start")
        generate_new_dungeon()
        player.game_state = "play"
    end

    if player.game_state == "play" then
        logDebug("player.game_state == play")
        //update everything game related
        if (dtb_f[1]~=0) then
            if player.turn then	
                move_player()
            elseif player.turn == false then
                turn_num += 1
				logInfo("player.x: "..player.x .." player.y: "..player.y)
                if (turn_num%6 ==0) then
                    player.hp +=1
                end
                status_handler()
                update_mines()
                update_enemies()
                player.turn = true
            end
        end	
        can_see(player.x,player.y,player.x+8,player.y+8,64)
        camera(player.x-64,player.y-64)
        player.gridx = player.x-64
        player.gridy = player.y-64
    end
    dtb_update()
    update_fx()
end


function _draw()

cls()
if player.game_state == "intro" then 

map(0, 0,0,0, 128, 64)
clip(0, 7*8, 128, 112)
print("welcome loot goblin",28,64-time()*2,3)
print("a great evil has taken",28,72-time()*2,3)
print("root ,you must venture",28,80-time()*2,3)
print("deep into the caverns",28,88-time()*2,3)
print("to save this land",28,96-time()*2,3)
print("and bring back light and...",28,104-time()*2,3)
print("prospehrity",28,112-time()*2,3)
print("good luck!",28,120-time()*2,3)
clip()
end
if player.game_state == "death" then
	deathscreen()
end
if player.game_state =="victory" then
	virctory()
end

if player.game_state == "play" then
	before_draw()

	//floor layer
	pal(1,0)
	pal(13,1)
	map(0, 0,0,0, 128, 64)
	//instance layer
	pal()
	draw_mines()
	render_weaponds()
	draw_enemies()
	
	//shading and ui layer
	
	bad_shader()
	afterdraw()
	draw_player()
	clip()
	draw_ui()
end

dtb_draw()
draw_fx()
end



function before_draw()

 myx= camx+44
 myy= camy+20
 myr=flr(16 + 4*sin(time()/18))+player.light_str

 clip(myx-myr,myy-myr,myr*2,myr*2)
	
	
end

function afterdraw()
	myx= camx+44
 myy= camy+20
 for i=0,flr(myr/2) do
 	circ(player.x+4,player.y+4,myr+i,0)
  circ(player.x+4-1,player.y+4,myr+i,0)
end
end


function draw_ui()
if player.game_state == "transition" then
transition()
end

//draw scroll beneath hp
if count(player.scrolls_held) > 0 then	
	local item = player.scrolls_held[player.curr_scroll]
	pal(15,player.curr_scroll%15 +2)
	
	spr(176, player.x-64,player.y-50,1,1, false,false)
	print(player.curr_scroll,player.x-64,player.y-50,7)
	spr(184, player.x-64,player.y-42,1,1, false,false)
	spr(183, player.x-56,player.y-42,1,1, false,false)

	pal()
	print(" : ",player.x-60,player.y-48,7)
	print(item,player.x-50,player.y-48,7)
end

//draw hp in top left corner
rectfill(player.x-66,player.y-56,player.x-63+player.hp,player.y-54,8)
rect(player.x-64,player.y-57,player.x-54+player.max_hp-3,player.y-53,2)
pal(11,0)
spr(178,player.x-64+player.max_hp,player.y-53-7)
pal()
//draw equipped weapon beheath scroll
rect(player.x-64,player.y+62,player.x+32,player.y+39,13)
spr(player.weapon_held.sprite,player.x-62,player.y+40)
if not(player.weapon_held.curse =="") then
	spr(187,player.x-50,player.y+40)
	spr(188,player.x-42,player.y+40)
	spr(189,player.x-34,player.y+40)
	print(player.weapon_held.curse, player.x-30,player.y+41,2)
end
print(player.weapon_held.name,player.x-62,player.y+50,7)
print("damage : " .. player.weapon_held.dmg,player.x-62,player.y+56,7)


//draw_xp in top corner

spr(179, player.x-54,player.y-60,1,1, false,false)
spr(185, player.x-64,player.y-64,1,1, false,false)
for i =1, player.xp , 1 do
	pset(player.x-54+i,player.y-60,12)
end
for i=0, player.max_xp, 1 do
	pset(player.x-54+i,player.y-59,6)
end


//draw floor number
spr(254, player.x+32,player.y-60,1,1, false,false)
spr(255, player.x+40,player.y-60,1,1, false,false)
spr(186, player.x+48,player.y-60,1,1, false,false)
print(player.stage,player.x+48+4,player.y-58,10)


//draw player lvl
spr(240, player.x+32,player.y-52,1,1, false,false)
spr(241, player.x+40,player.y-52,1,1, false,false)
print(player.lvl +1,player.x+48,player.y-52,10)


end

function render_weaponds()
	for i in all(global_weapons) do
		spr(i.sprite, i.x,i.y,1,1,false,false)
	end
end



function transition()
cls()
spr(244,0,0,1,1,false,false)
spr(245,player.x,player.y,1,1,false,false)
spr(243,player.x+8,player.y,1,1,false,false)

if btnp(3) or btnp(1) or btnp(2) or btnp(4) or btnp(5) or btnp(6) then
	player.game_state = "play"
end

end

