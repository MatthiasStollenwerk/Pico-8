function generate_new_dungeon()
    logInfo("generating new dungeon")
    
    global_weapons = {}
    dungeon_generator(size)
    add_decoration()
end
    
function dungeon_generator(room_num)
    x =0
    y =0
    for r = 0,room_num*size,size do
        for r2 = 0,room_num*size,size do
            for i = 0 , size, 1 do
                for j=0, size, 1 do
                    x=i+r
                    y=j+r2
                    mset(x,y,rnd(floor))
                    add(floor_tiles,{x=x,y=y})
                    if i == 1 then
                        mset(x-1,y, 125)
                        if j == size/2 and r >1 then
                            mset(x-1,y,rnd(doors))
                        end
                        if j == 1 then
                            mset(x-1,y-1,124)
                        end
                    end
                    if j ==1 then
                        mset(x,y-1, 110)
                        if r2 >1 then
                            if i ==size/2 then
                                mset(x,y-1,rnd(doors))
                            end
                        end
                    end
                    if j==size then
                        mset(x,y+1, 93)
                    end
                    if i== size then
                        mset(x,y,109)
                        if j == 1 then
                            mset(x,y-1,94)
                        end
                    end
                end
            end
        end
    end    
end

function add_decoration()
    local spawn_boss = true
    //make sure decoration does not spawn inside walls
    for i in all(floor_tiles) do
        for j in all(walls) do
            if mget(i.x+1,i.y+1) ==j then
                del(floor_tiles,i)
            end
        end
    end
    
    local ex = flr(rnd(size*size))
    local ey = flr(rnd(size*size))
    local ex2 = flr(rnd(size*size))
    local ey2 = flr(rnd(size*size))
    
    for i in all(floor_tiles) do
                //spawn enemie
                if (flr(rnd(40)) ==1 and spawn_boss ==true and player.stage==6) then
                    spawn_final_boss(i)
                    spawn_boss = false		
                end
                //weak enemies
                if (flr(rnd(40)) ==1) then
                    add_enemie(rnd(basic_enemies),i.x*8+8,i.y*8+8,3*player.stage+player.stage+player.dmg,player.stage+1 ,flr(rnd(32)))
                end
                //medium enemies
                if (flr(rnd(100)) ==1) then
                    add_enemie(rnd(medium_enemies),i.x*8+8,i.y*8+8,6*player.stage+player.dmg,(player.stage+1) *1.5 ,flr(rnd(32)))
                end
                //mini_bosses
                if (flr(rnd(400)) ==1) then
                    add_enemie(rnd(strong_enemies),i.x*8+8,i.y*8+8,7*player.stage+player.dmg,(player.stage+1)*2 ,flr(rnd(32)))
                end
                
                if (flr(rnd(800)) ==1 and spawn_boss ==true) then
                    add_boss(rnd(bosses),i.x*8+8,i.y*8+8,8*player.stage+player.dmg,(player.stage+1)*2.5,32)
                    spawn_boss = false		
                end
        
            if (flr(rnd(50)) == 1)	then
            mset(i.x+1,i.y+1,rnd(decoration))
            end
            
            if i.x == ex or i.x==ex2 then
                if i.y == ey or i.y==ey2 then
                    mset(i.x+8,i.y+8, 67)
                end
            end
        end
    end
    
    function deathscreen()
        camera(0,0)
        spr(16,8+28,64,1,1, false,false)
        spr(17,8+28+8,64,1,1, false,false)
        spr(18,8+28+16,64,1,1, false,false)
        spr(19,8+28+24,64,1,1, false,false)
        spr(20,8+28+24+8,64,1,1, false,false)
        
        print("number of turns:" .. turn_num,24,80,6)
        print("floor : " .. player.stage,24,88,6)
    end
    
    function virctory()
        camera(0,0)
        spr(32,8+28,64,1,1, false,false)
        spr(33,8+28+8,64,1,1, false,false)
        spr(34,8+28+16,64,1,1, false,false)
        spr(35,8+28+24,64,1,1, false,false)
        spr(36,8+28+24+8,64,1,1, false,false)
        
        print("number of turns:" .. turn_num,24,80,6)
        print("floor : " .. player.stage,24,88,6)
    end
    
    
    
    function spawn_final_boss(i)
        add_enemie(5,i.x*8+8,i.y*8+8,120,player.max_hp/10 +9 ,flr(rnd(32)))
    end