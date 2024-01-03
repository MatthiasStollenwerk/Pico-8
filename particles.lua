
function add_fx(x,y,die,dx,dy,grav,grow,shrink,r,c_table)
    local fx={
        x=x,
        y=y,
        t=0,
        die=die,
        dx=dx,
        dy=dy,
        grav=grav,
        grow=grow,
        shrink=shrink,
        r=r,
        c=0,
        c_table=c_table,                
    }
    if count(effects) <= 600 then
    	add(effects,fx)
    end
end

function update_fx()
    for fx in all(effects) do
        --lifetime
        fx.t+=1
								if fx.t>fx.die then del(effects,fx) end
        --color depends on lifetime
								if fx.t/fx.die < 1/#fx.c_table then
								    fx.c=fx.c_table[1]								
								elseif fx.t/fx.die < 2/#fx.c_table then
								    fx.c=fx.c_table[2]								
								elseif fx.t/fx.die < 3/#fx.c_table then
								    fx.c=fx.c_table[3]								
								else
								    fx.c=fx.c_table[4]
								end
        --physics
   					if fx.grav then fx.dy+=.5 end
								if fx.grow then fx.r+=.1 end
								if fx.shrink then fx.r-=.1 end     		
        --move
        fx.x+=fx.dx
								fx.y+=fx.dy        
    end
end
function draw_fx()
    for fx in all(effects) do
        --draw pixel for size 1, draw circle for larger
        if fx.r<=1 then
            pset(fx.x,fx.y,fx.c)
        else
            circfill(fx.x,fx.y,fx.r,fx.c)
        end
    end
end
function random_bullet_storm(x,y,spd,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x,  -- x
            y,  -- y
            30,  -- die
           	(rnd(2)-1)*spd, -- dx
            (rnd(2)-1)*spd, -- dy
            false,     -- gravity
            false,     -- grow
            false,     -- shrink
            2,         -- radius
            {2,1,7}    -- color_table
            
        )
    end
end
function torch_fire(x,y,spd,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+rnd(2)-1,  -- x
            y,  -- y
            rnd(5),  -- die
           	0, -- dx
           	-(rnd(1)), -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            rnd(0.5),         -- radius
            {10,9,8,4}    -- color_table
            
        )
    end
end
function lvl_up(x,y,spd,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+rnd(flr(x))-(x/2),  -- x
            y+rnd(flr(y))-(y/2),  -- y
            rnd(30),  -- die
           	rnd(flr(2))-1, -- dx
            -(rnd(2)), -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            2,         -- radius
            {6,7,10}    -- color_table
            
        )
    end
end

function poision(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+rnd(4)-2,  -- x
            y,  -- y
            rnd(10),  -- die
           	0, -- dx
           	(rnd(1)), -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            rnd(2),         -- radius
            {11,3,1}    -- color_table
            
        )
    end
end

function poision_cloud_eff(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+flr(rnd(20)-10),  -- x
            y+4+flr(rnd(20)-10),  -- y
            rnd(32)+i,  -- die
           	0, -- dx
            0, -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            3,         -- radius
            {11,3}    -- color_table
            
        )
    end
end


function atk_eff(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+rnd(8)-4,  -- x
            y+4+rnd(8)-4,  -- y
            rnd(7),  -- die
           	rnd(2)-1, -- dx
           	rnd(2)-1, -- dy
            false,     -- gravity
            false,     -- grow
            false,     -- shrink
            rnd(2),         -- radius
            {8,2}    -- color_table
            
        )
    end
end

function shockwave_eff(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+rnd(4)-2,  -- x
            y+4+rnd(4)-2,  -- y
            rnd(30),  -- die
           	rnd(2)-1, -- dx
           	rnd(2)-1, -- dy
            false,     -- gravity
            true,     -- grow
            false,     -- shrink
            3,         -- radius
            {7,6,5}    -- color_table
            
        )
    end
end
function explosion(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+flr(rnd(20)-10),  -- x
            y+4+flr(rnd(20)-10),  -- y
            rnd(32)+i,  -- die
           	0, -- dx
            0, -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            3,         -- radius
            {8,9,10,5}    -- color_table
            
        )
    end
end

function holy_boom(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        
            x+4+flr(rnd(20)-10),  -- x
            y+4+flr(rnd(20)-10),  -- y
            rnd(32)+i,  -- die
           	rnd(2)-1, -- dx
            rnd(2)-1, -- dy
            false,     -- gravity
            false,     -- grow
            true,     -- shrink
            3,         -- radius
            {9,10,7}    -- color_table
            
        )
    end
end


function buff_effect(x,y,num,color_table)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+rnd(4)-2,  -- x
            y+4+rnd(4)-2,  -- y
            rnd(30),  -- die
           	rnd(flr(2))-1, -- dx
            -(rnd(2)), -- dy
            false,     -- gravity
            false,     -- grow
            false,     -- shrink
            flr(rnd(4)),         -- radius
            color_table    -- color_table
            )
    end
end

function enemie_death(x,y,num)
    for i=0, num do
        --settings
        add_fx(
        //random_bullet_storm(player.x,player.y+40,2,6)
            x+4+rnd(8)-4,  -- x
            y+4+rnd(8)-4,  -- y
            rnd(7),  -- die
           	0, -- dx
           	rnd(2), -- dy
            false,     -- gravity
            false,     -- grow
            false,     -- shrink
            rnd(2),         -- radius
            {1}    -- color_table
            
        )
    end
end
