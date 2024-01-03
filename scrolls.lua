weapond_types ={"spear","hammer","sword","club","dagger","weapon","mace", "destroyer","bonk","gayness","uzrac", "akbon", "living weapon","rapier"}

curses = {"lvampire","frenzy","cowardice","poision","healing_kill","defense","exploding_enemies","gambler","chance","hat trick"}

scrolls={"shockwave","boom","defense","path of berserker","posion cloud","holy_sacrifice","heal","teleport","blind rage","regeneration","land mine","bad necromancy"}
scroll_use={shockwave,boom,defense,berserker,poision_,holy_sacrifice,heal,teleport,blind_rage,regeneration,mine,necromancy}
no_scroll_atk = {"spin","block",""}

weapon_des={"forged in the fires of the deep","given form by the dreamer","this weapon was made by the faith of the old gods","when the world came into beeing the material used to craft this weapon came into beeing from the thoughs of the past","void given form","reknown for its lethality in battle this weapon was banished to the depths of the dream","even inside a dream this weapon can cut you",". . . . . .","a dark urge fillys your mind","kill the unbelivers and drink their blood","gobgobgobgobgobgobgobgob","the blood o former victims still remains on this weapon","just an ordinary weapon forged by a blacksmith","deep inside the dream wonders will reveal themselves"}

weapon_name_pool = {" of aznak", " of slaying"," for stabbing", " esyleps blessing", " powers of the forsaken",
 " infused with voidflame", " with strengh of widsom",
 " ", "...",
 " (weird)", " that bonks",
	" of godslayer", " from death",
	" of darkness", " of azlap", 
	" of geylep"," (broken)",
	" (gay)"," the goblin slayer",
	" the witchhunter"," the life drainer",
	" of modesty", " of courage",
	" of lust", " of want",
	" of anger", " of energy" ," infused with rock",
	" of bonking"," out of steel"," infused with blood"," embedded with the sould of a god",
	" forgotten"," of undying(not really)",
	"☉", "★", "♥", "🐱"}
	
smol_weaponds ={225,226,224,195,227,201,212,229,208,210,213,211,214}
medium_weaponds ={194,196,198,202,205,206,207,209,215,231,230}
big_weaponds ={192,193,199,200,197,228,203,204}

global_weapons = {}

function generate_weapon(x,y)

if flr(rnd(10)) ==1 then
	apply_curse = rnd(curses)
else
	apply_curse = ""
end

local class = flr(rnd(9))
if class <5 then
dmg = flr(rnd(2))+player.stage
sprit = rnd(smol_weaponds)
elseif class >= 5 and class <8 then
dmg = flr(rnd(4))+player.stage
sprit = rnd(medium_weaponds)
elseif class >=8 then
dmg = flr(rnd(6))+player.stage+1
sprit = rnd(big_weaponds)
end

local weap = {
name = (rnd(weapond_types) .. rnd(weapon_name_pool)),
dmg =dmg ,
sprite = sprit, 
curse = apply_curse,
des= rnd(weapon_des),
x =x,
y =y,
class =class
}

add(global_weapons, weap)
end

function curse_handler(e)
local effect = player.weapon_held.curse
if not(effect == "") then
	if effect =="lvampire" then
	 player.hp += 1
	elseif effect =="frenzy" then
		add_status_eff("berserk",5)
		player.hp -= player.stage*2
	elseif effect =="cowardice" then
		if player.hp - e.dmg <= player.hp-player.hp+5 then
			teleport()
		end
	elseif effect =="poision" then
		add_enemie_effect(e,"posion",5)
			
	elseif effect =="healing_kill" then
		if player.dmg*2 > e.hp then
			player.hp += flr(e.hp/2)
		end	
	elseif effect =="exploding_enemies" then
		if player.dmg*2 > e.hp then
			boom()
		end
		//"gambler","chance","hat trick"
	elseif effect == "gambler" then
	
	local rng =flr(rnd(2))
	if rng ==1 then
		add_status_eff("berserk",5)
	elseif rng ==2 then
		player.hp -= flr(rnd(player.stage+4))
	elseif rng ==0 then
		player.weapon_held.dmg = flr(rnd(player.stage*2+player.stage+3))+2
	end
	elseif effect =="chance" then
		player.weapon_held.dmg = flr(rnd(player.stage*2+player.stage+3))
	elseif effect =="hat trick" then
		local point = rnd(floor_tiles)
		local rng = flr(rnd(9))
		if rng ==1 then
			e.x = point.x*8
			e.y = point.y*8
			sfx(7)			
		end
	end
end
end

function add_scroll()
sfx(16)
local scroll_num = count(scrolls)
local random_scroll = flr(rnd(scroll_num))
add(player.scrolls_held, scrolls[random_scroll])
add(player.scroll_to_use,scroll_use[random_scroll])
end
