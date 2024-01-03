function add_status_eff(name,dur)
    local eff={
    name =name,
    dur = dur,
    }
    add(player.status_eff,eff)
    end
    
    function teleport()
    local point = rnd(floor_tiles)
    player.x = point.x*8
    player.y = point.y*8
    sfx(7)
    for i in all(walls) do
        if mget(point.x,point.y) == i then
            teleport()
        end
    end
    
    end
    
    function poision_()
        local x1 = player.x - 8
        local x2 = player.x + 8
        local y1 = player.y - 8
        local y2 = player.y + 8
        poision_cloud_eff(player.x,player.y,rnd(30))
        
        for i =x1, x2, 8 do
            for j=y1, y2,8 do
                for e in all(enemies) do
                    if e.x ==i and e.y==j then
                        add_enemie_effect(e,"posion",5)
                    end
                end
            end
            end	
    end
    
    function shockwave()
        local x1 = player.x - 8
        local x2 = player.x + 8
        local y1 = player.y - 8
        local y2 = player.y + 8
        sfx(12)
        shockwave_eff(player.x,player.y,rnd(15))
        for i =x1, x2, 8 do
            for j=y1, y2,8 do
                for e in all(enemies) do
                    if e.x ==i and e.y==j then
                        e.x = e.x- (player.x-e.x)*2
                        e.y = e.y- (player.y-e.y)*2
                    end
                end
            end
            end	
    end
    
    function boom()
        local x1 = player.x - 8
        local x2 = player.x + 8
        local y1 = player.y - 8
        local y2 = player.y + 8
        sfx(12)
        explosion(player.x,player.y,30)
        player.hp -= (player.stage)*3
        for i =x1, x2, 8 do
            for j=y1, y2,8 do
                for e in all(enemies) do
                    if e.x ==i and e.y==j then
                    e.hp -=(player.stage)*5
                        
                    end
                end
            end
            end	
    
    end
    
    function defense()
    buff_effect(player.x,player.y,5,{12,13})
        add_status_eff("defense",5)
    end
    
    function berserker()
    //todo sound effects
        add_status_eff("berserk",5)
        buff_effect(player.x,player.y,5,{8,2})
    end
    
    function heal()
        buff_effect(player.x,player.y,5,{11,3})
        sfx(4)
        player.hp = player.max_hp
    end
    
    function holy_sacrifice()
        sfx(4)
        local x1 = player.x - 16
        local x2 = player.x + 16
        local y1 = player.y - 16
        local y2 = player.y + 16
        local heal = true
        holy_boom(player.x,player.y,30)
        player.hp -= 6*player.stage
        for i =x1, x2, 8 do
            for j=y1, y2,8 do
                for e in all(enemies) do
                    if e.x ==i and e.y==j then
                    e.hp -= 6*player.stage+5
                    
                    heal = false
                    end
                end
            end
            end
        if heal == true then
            player.hp = player.max_hp
        end
    end
    
    
    function mine()
    local explosion_time = turn_num + 5
    local minee ={
    dmg = 5+player.stage*6,
    deto_t = explosion_time,
    x = player.x,
    y = player.y,
    }
    add(mines,minee)
    end
    function draw_mines()
        for i in all(mines) do
            spr(242,i.x,i.y,1,1,false,false)
        end
    end
    
    
    function update_mines()
    for i in all(mines) do
        if i.deto_t == turn_num then
            local x1 = i.x - 8
        local x2 = i.x + 8
        local y1 = i.y - 8
        local y2 = i.y + 8
        sfx(12)
        explosion(i.x,i.y,30)
        for k =x1, x2, 8 do
            for j=y1, y2,8 do
                for e in all(enemies) do
                    if e.x ==k and e.y==j then
                    e.hp -= i.dmg
                        
                    end
                end
            end
            end	
    
        del(mines, i)
        end
    
    end
    
    end
    
    
    function blind_rage()
    add_status_eff("blind",5)
    end
    
    function regeneration()
    add_status_eff("regen",5)
    end
    
    function necromancy()
    add_enemie(rnd(basic_enemies),player.x+rnd({8,-8}),player.y+rnd({8,-8}),1,1 ,0)
    end
    
    
    function drop_loot(x,y,loot_type)
    local wp_num = 0
    for i in all(loot_type)do
        if i == "scroll" then
            add_scroll()
        end
        if i == "weapon" then
            wp_num +=1
        end
        
    end
    for i=1, wp_num,1 do
        generate_weapon(x+i*8,y)
    end
    
    end
    