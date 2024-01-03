//loot_tabels


loot_for_the_loot_goblins={
{"scroll"},
{"scroll", "scroll"},
{"scroll"},
{"scroll"},
{"weapon"},
{"scroll","weapon"},
{"scroll"},
{"scroll"},
{"scroll"},
{},
{"weapon"},
{},
{},
{},
{},
{},
{},
{},
{},
{},
{},
}



function add_enemie(sprite,x,y,hp,dmg,range)
	local enemie ={
		hp = hp,
		max_hp =hp,
		range =range,
		eff ={}, 
		dmg =dmg,
		loot_table =rnd(loot_for_the_loot_goblins),
		sprite = sprite,
		x = x,
		y = y,
		hs =0,
		vs =0,
		state=0,
		face = false,
		}
	
	add(enemies,enemie)
end

function add_boss(sprite,x,y,hp,dmg,range)
	local enemie ={
		hp = hp,
		max_hp =hp,
		range =range,
		eff ={}, 
		dmg =dmg,
		loot_table ={"weapon","scroll","scroll"},
		sprite = sprite,
		boss=true,
		x = x,
		y = y,
		hs =0,
		vs =0,
		state=0,
		face = false,
		}
	
	add(enemies,enemie)
end



----------------------------

function draw_enemies()
	for i in all(enemies) do
		spr(i.sprite,i.x,i.y,1,1,i.face,false)
		pal()
	end
end


function update_enemies()
if count(enemies) > 0 then
	for i in all(enemies) do
	 //effect update
	 if count(i.eff) >0 then
	 	for j in all(i.eff) do
	 		j.dur -=1
	 		if j.dur <=0 then
	 			del(i.eff,j)
	 		end 
	 		if j.name =="posion" then
	 			i.hp -=1*player.stage
	 			poision(i.x,i.y-8,30) 
	 		end
	 		//other effects
	 	end
	 
	 end
	 
	 //check if enemie can attack
	 if player.x == i.x then
	 	if player.y == i.y+8 or player.y == i.y-8 then
	 	 i.state = 3
	 	end
	 end
	 
	 if player.y == i.y then
	 	if player.x == i.x +8 or player.x == i.x-8 then
	 		i.state = 3
	 	end
	 end
		enemie_hp_check(i)
		
	end
	end

end


function enemie_hp_check(e)
if e.state ==0 then
	if e.hp < e.max_hp then
		e.state = 1
	end
end

//space for low hp buffs

if e.hp <=0 then
		kill_enemies(e)
		del(enemies,e)
else
		enemie_movement(e)
end
end

function kill_enemies(e)
sfx(15)
player.xp += 2*player.stage
enemie_death(e.x,e.y,rnd(2))
drop_loot(e.x,e.y,e.loot_table)

end


function add_enemie_effect(enemie,name,dur)
local effect ={
dur = dur,
name = name,
}
add(enemie.eff,effect)

end
