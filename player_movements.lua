function move_player()
		
    if (btnp(0)) then
     player.turn = false
        player.hs = player.hs-1*8
        player.facing = true
        //poision_cloud_eff(player.x,player.y,8)
    end 
    
    if (btnp(1)) then
        player.turn = false
     player.hs=player.hs + 1*8
     player.facing = false
     
    end
    
    
    if (btnp(⬇️)) then
        player.turn = false
           player.vs=player.vs-1*8
  
    end
    
    if (btnp(🅾️)) then
              local inv = count(player.scrolls_held)
              
              if player.curr_scroll+1 <= inv then
                  player.curr_scroll +=1
              else
                  player.curr_scroll = 1
              end
        //player.xp +=1
    end
    if (btnp(❎))then
    
    use_scroll()
          //	add_enemie(rnd(enemie_sprites),player.x+8,player.y,5*player.stage,(player.hp/20) + flr(rnd(2)),flr(rnd(32)))
   
    end
    if btnp(➡️) and btnp(⬅️) then
        dtb_disp(player.weapon_held.des)
  
    end
    
    if (btnp(2)) then
    player.turn = false
     player.vs=player.vs+1*8
        //dtb_disp("test")
        //random_bullet_storm(player.x,player.y,4,8)
    end
    
    if abs(player.hs) + abs(player.vs) >8 then
        player.hs =0
        player.vs = 0
    
    end
    
          if abs(player.hs) > 0 then 
          sfx(14)
              local obj = 	mget((player.x+player.hs)/8,player.y/8)
              inderactable((player.x+player.hs)/8,player.y/8)
              check_weapon((player.x+player.hs),player.y)
              check_attack((player.x+player.hs),player.y)
              for wall in all(walls) do
                  if wall == obj then
                      player.hs =0
                      break
                  end
              end
          
          end
          
          if abs(player.vs) > 0 then 
          sfx(14)
              local obj = 	mget(player.x/8,(player.y-player.vs)/8)
              inderactable(player.x/8,(player.y-player.vs)/8)
              check_weapon(player.x,(player.y-player.vs))
              check_attack(player.x,player.y-player.vs)
              for wall in all(walls) do
                  if wall == obj then
                      player.vs =0
  
                      break
                  end
              end
          
          end
          
    logDebug("player.x: "..player.x .." player.y: "..player.y)
    player.x = player.x + player.hs
    player.y = player.y - player.vs
  
    
          player.hs = 0
          player.vs = 0
          if not (player.facing) then
          torch_fire(player.x+7,player.y+4,1,1)
          else
          torch_fire(player.x+1,player.y+4,1,1)
          end
          
          
          if player.xp >= player.max_xp then
          level_up()
          end
          
          hp_handler()
          
          
          
  
  end
  
  function draw_player()
  spr(player.sprite, player.x,player.y,1,1, player.facing,false)
  end
  
  function level_up()
              sfx(4)
              
              lvl_up(player.x+4,player.y+4,0,8)
              player.xp =0
              player.lvl +=1
              player.dmg +=1
              player.max_xp = player.max_xp + player.lvl*5
              player.max_hp += 5
              player.hp = player.max_hp
              
  end
  
  
  function hp_handler()
  if player.hp > player.max_hp then
      player.hp = player.max_hp
  end
  if player.hp <=0 then
      player.game_state = "death"
  end
  
  end
  
  function use_scroll()
  local rng = flr(rnd(100))
  
  if rng ==1 then
      scroll_missfire()
      else
      if count(player.scroll_to_use) >0 then
      
      player.scroll_to_use[player.curr_scroll]()
   del(player.scrolls_held,player.scrolls_held[player.curr_scroll])
   del(player.scroll_to_use,player.scroll_to_use[player.curr_scroll])
   player.turn = false
   if player.curr_scroll -1 >=1 then
       player.curr_scroll -=1
   end
   end
   
  end
  
  end
  
  function scroll_missfire()
  player.turn = false
  //rnd(failed_scroll)
  del(scrolls_held,player.curr_scroll)
  end
  
  function status_handler()
      for i in all(player.status_eff) do
          if i.dur <=0 then
              if i.name == "berserk" then
               player.dmg -= 5
               player.hp -= 2
              elseif i.name == "defense" then
                  def -= 5
              elseif i.name == "blind" then
                  player.light_str =player.max_light_str
                  player.dmg -= 10
              end
              del(player.status_eff,i)
          
              
          elseif i.dur >0 then
              i.dur -=1
              //effects
              if i.name == "berserk" then
                  player.dmg += 1
              elseif i.name == "defense" then
                  def += 1
              elseif i.name == "posion" then
                  player.hp -= player.stage*2
                  poision(i.x,i.y-8,30)
              elseif i.name == "blind" then
                  player.light_str =0
                  player.dmg += 2
              elseif i.name =="regen" then
                  player.hp +=2
                  buff_effect(player.x,player.y,1,{11,3})
              end
          end
      end
  end
  