--interactables
exit_mssg = {"you ventured deeper...?", "the rats will eat you now", "prepare to die","far underground our hero continues their quest","what lurkes on this floor?","impossible","press: ➡️+⬅️ to see the curses","enemies are evil","your suffering will never end","etsylep is watching","the darkness closes in","this is where the fun begins","dont let your torch snuff out","where am i"}
grave_msg ={"i see clear now","here lies hopes and dreams. . . they where siblings","here lies sans from undertale","the name is weathered away","nothing more to fight for","stand tall in the eye of the abyss","the void has taken me and soon it will also take thee"}
--dialog
-- Initialize the dialogue text box system
function dtb_init(n)
    dtb_q = {}
    dtb_f = {}
    dtb_n = 3  -- default number of lines in the text box

    if n then 
        dtb_n = n  -- set the number of lines if specified
    end

    _dtb_c()  -- initialize other variables
end

-- Display text in the dialogue text box with optional callback
function dtb_disp(t, c)
    local s, l, w, h, u
    s = {}
    l = ""
    w = ""
    h = ""
    u = function()
        if #w + #l > 29 then
            add(s, l)
            l = ""
        end
        l = l .. w
        w = ""
    end

    for i = 1, #t do
        h = sub(t, i, i)
        w = w .. h
        if h == " " then
            u()
        elseif #w > 28 then
            w = w .. "-"
            u()
        end
    end

    u()
    if l ~= "" then
        add(s, l)
    end

    add(dtb_q, s)
    if c == nil then
        c = 0
    end

    add(dtb_f, c)
end

-- Internal function to initialize dialogue display variables
function _dtb_c()
    dtb_d = {}
    for i = 1, dtb_n do
        add(dtb_d, "")
    end
    dtb_c = 0
    dtb_l = 0
end

-- Internal function to advance to the next line in the dialogue
function _dtb_l()
    dtb_c = dtb_c + 1
    for i = 1, #dtb_d - 1 do
        dtb_d[i] = dtb_d[i + 1]
    end
    dtb_d[#dtb_d] = ""
    sfx(0)  -- play sound effect
end

-- Update the dialogue text box
function dtb_update()
    if #dtb_q > 0 then
        if dtb_c == 0 then
            dtb_c = 1
        end

        local z, x, q, c
        z = #dtb_d
        x = dtb_q[1]
        q = #dtb_d[z]
        c = q >= #x[dtb_c]

        if c and dtb_c >= #x then
            if btnp(4) then
                if dtb_f[1] ~= 0 then
                    dtb_f[1]()
                end
                del(dtb_f, dtb_f[1])
                del(dtb_q, dtb_q[1])
                _dtb_c()
                sfx(0)
                return
            end
        elseif dtb_c > 0 then
            dtb_l = dtb_l - 1
            if not c then
                if dtb_l <= 0 then
                    local v, h
                    v = q + 1
                    h = sub(x[dtb_c], v, v)
                    dtb_l = 1
                    if h ~= " " then
                        sfx(0)
                    end
                    if h == "." then
                        dtb_l = 6
                    end
                    dtb_d[z] = dtb_d[z] .. h
                end
                if btnp(4) then
                    dtb_d[z] = x[dtb_c]
                end
            else
                if btnp(4) then
                    _dtb_l()
                end
            end
        end
    end
end

-- Draw the dialogue text box on the screen
function dtb_draw()
    if #dtb_q > 0 then
        local z, o
        z = #dtb_d
        o = 0

        if dtb_c < z then
            o = z - dtb_c
        end

        rectfill(player.gridx, player.gridy + 125 - z * 8 - 3, player.gridx + 125, player.gridy + 125 + 4, 1)
        rect(player.gridx, player.gridy + 125 - z * 8 - 3, player.gridx + 125, player.gridy + 125 + 2, 2)

        if dtb_c > 0 and #dtb_d[#dtb_d] == #dtb_q[1][dtb_c] then
            print("\x8e", player.gridx + 118, 120 + player.gridy, 7)
        end

        for i = 1, z do
            print(dtb_d[i], player.gridx + 5, i * 8 + 119 - (z + o) * 8 + player.gridy, 7)
        end
    end
end

--objects
objects = {}
function add_object(effect,spr_id,msg,dest,broken_spr,sound)
local obj ={
		effect = effect,
		spr_id = spr_id,
		msg = msg,
		dest = dest,
		broken_spr = broken_spr,
		sound = sound,
		}	
	add(objects,obj)
end
function inderactable(x,y)
			local obj = mget(x,y)
			for i in all(trap_tiles) do
				if obj==i then
					 player.hp -= player.stage+1
					 sfx(9)
					 atk_eff(player.x,player.y,4)
				end
			end			
			for i in all(objects) do
				if (obj == i.spr_id)then
					--do something object specific
					if i.effect == "break" then
                        logDebug("break got triggered")
						sfx(i.sound)
						mset(x,y,i.broken_spr)
						local rng=flr(rnd(50))
						if rng == 1 then
						drop_loot(x*8,y*8,rnd({{"weapon"},{"scroll"},{"scroll"}}))
						end
						elseif i.effect =="steps" then
						floor_tiles = {}
						enemies ={}
						sfx(6)
						player.stage +=1
						
						generate_new_dungeon()
						player.x = 3*8
						player.y = 6*8
						
						dtb_disp(rnd(exit_mssg))
					elseif i.effect =="chest" then
					sfx(i.sound)
						if flr(rnd(20)) == 1 then
							mset(x,y,127)							
							add_enemie(25,x*8,y*8,10*player.stage+5,10+player.stage+5,32)
						else
							mset(x,y,i.broken_spr)
							drop_loot(x*8,y*8,rnd({{"weapon"},{"scroll"},{},{"scroll"},{}}))
						end
					elseif i.effect == "grave" then
						dtb_disp(rnd(grave_msg))
						mset(x,y,i.broken_spr)
						sfx(i.sound)
					elseif i.effect =="evil_shrine" then
						local point = rnd(floor_tiles)
						add_boss(rnd(bosses),point.x*8+8,point.y*8+8,player.max_hp,(player.stage)*(player.stage)*5,32)
						mset(x,y,i.broken_spr)
					elseif i.effect =="good_shrine"then
						player.hp = player.max_hp
						def +=2
						mset(x,y,i.broken_spr)
					end			
					if not(i.msg ==0) then
						dtb_disp(i.msg)
					end
				end
		end			
end
function check_attack(x,y)
	if count(enemies)>0 then
		for e in all(enemies)do
				if e.x ==x and e.y == y then
					//attack the enemie
					curse_handler(e)
					player.hs =0
					player.vs =0					
					atk_eff(x,y,rnd(30))
					sfx(5)
					e.hp -= player.dmg + player.weapon_held.dmg

				end
		end
	end
end
function check_weapon(x,y)
				if count(global_weapons) > 0 then
					for i in all(global_weapons) do
						if x==i.x and y==i.y then
							player.hs =0
							player.vs =0
							local x1 = player.x
							local y1 = player.y
							player.weapon_held.x = x1
							player.weapon_held.y = y1							
							add(global_weapons,player.weapon_held)													
							player.weapon_held = i
							del(global_weapons,i)														
				end
					
					end
				
				
				end

end

--initialise all objects and interactables

--add_object(effect,spr_id,msg,dest,broken_spr,sound)
add_object("break",96,0,false,112,1)
add_object("break",97,0,false,113,1)
add_object("break",99,0,false,115,1)
add_object("break",64,0,false,65,1)
add_object("break",84,0,false,85,1)
add_object("break",66,0,false,114,1)
add_object("break",68,0,false,116,1)
add_object("break",98,0,false,117,1)
add_object("break",75,0,false,74,3)
add_object("grave",69,0,false,87,3)
add_object("break",88,0,false,89,3)
add_object("chest",121,0,false,119,3)
add_object("chest",103,0,false,104,3)
add_object("evil_shrine",181,"you have unleashed a great evil",false,87,3)
add_object("good_shrine",180,"you feel safer",false,87,3)
add_object("break",70,0,false,48,3)
add_object("break",102,0,false,48,13)
add_object("break",90,0,false,49,13)
add_object("break",247,0,false,246,3)


--fully break object
add_object("break",117,0,false,118,1)
add_object("break",115,0,false,100,1)
add_object("break",112,0,false,118,1)
add_object("break",116,0,false,118,1)



--exit

add_object("steps",67,0,false,0,6)

-->8
--enemie ai


function enemie_movement(e)
//attacking
if e.state ==3 then
	//attacking player
	sfx(5)
	if e.dmg >= def then
		player.hp -= e.dmg-def
	end
end

if e.state==2  then
	if enemie_los(e.x+4,e.y+4,player.x+4,player.y+4,e.range+8) then
		e.state = 1
	end 

end

//is chasing
if e.state==1 then
 if player.x<e.x then
 	e.hs = -8
 	e.face = true
 end
 if player.x>e.x then
 	e.hs = 8
 	e.face = false
 end
 if player.y < e.y then
 	e.vs = -8
 end
 if player.y > e.y then
 	e.vs = 8
 end
end
//is idle


//collision
if abs(e.hs)>0 then
	if (enemie_coll(e.x,e.y,e.hs,0)) then
		e.hs =0
	end
end
if abs(e.vs) > 0 then
	if (enemie_coll(e.x,e.y,0,e.vs)) then
		e.vs =0
	end
end

//prevent double tile walking
	if abs(e.hs)+abs(e.vs) > 8 then
	local rng = flr(rnd(2))
		if rng ==1 then
			e.x += e.hs
		else
			e.y += e.vs
		end	
	else
		e.x += e.hs
		e.y += e.vs	
	end
	//reset state and momentum
	e.hs =0
	e.vs =0
	e.state = 2
end

function enemie_coll(x,y,hs,vs)
local obj = 	mget((x+hs)/8,(y+vs)/8)
			for wall in all(walls) do
				if wall == obj then
					return true
				end
			end			
			for i in all(enemies)do
				if x+hs==i.x and y+vs==i.y then
					return true
				end
			end
			return false
end

function enemie_los(x1,y1,x2,y2,len)
--x1 and y1 are the point of view
    local xvec=0
    local yvec=0
    local len=len
    local ret=true   
    local tx=x1
    local ty=y1
    xvec=x2-x1
    yvec=y2-y1
    len=sqrt(xvec^2+yvec^2)
    if len==0 then
        ret=false
    end
    xvec=(xvec/len)
    yvec=(yvec/len)
        for i=1,len do
        tx+=xvec
        ty+=yvec
            if fget(mget(flr(tx/8),flr(ty/8)),1) then
                ret=false
                break
            end
        end
    return ret
end
