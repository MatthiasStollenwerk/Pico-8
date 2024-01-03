function main()

    logInfo(">> main")

    --player
    starter_weapon = {
        name="stick" ,
        dmg = 0,
        sprite = 195,
        curse = "",
        des = "a simple stick",
        x=0,
        y=0,
        class = 0 
    }
    def = 0
    player = {
        x = 3*8,
        y = 6*8,
        sprite = 1,
        hs = 0,
        vs = 0,
        facing = false,
        gridx = 3*8,
        gridy = 6*8,
        light_str = 16,
        max_light_str = 16,
        turn = true,
        scrolls_held ={},
        scroll_to_use = {},
        curr_scroll = 1,
        weapon_equipped = "",
        lvl =0,
        xp =0,
        max_xp =10,
        game_state = "intro",
        hp = 20,
        max_hp = 20,
        stage = 1,
        dmg = 1,
        weapon_held =starter_weapon, //{name= "stick",dmg = 2,sprite = 195,curse = "",x=0,y =0 },
        status_eff = {}
    }
    effects = {}
    -- dungeon generation
    walls = {247,48,119,181,180,93,109,110,125,99,64,96,97,84,85
            ,65,66,68,98,75,115,116,117,112,100,113,103,104,101,69,70,87,124,121,88,102,90}
    floor={2,3,4,108,127,123,122,106,107,111,126,127,111,126,127,111,126,127,76,78,79,94,95,92,91,71}

    decoration = {247,50,51,52,181,180,190,80,81,82,83,84,64,66,68,96,97,98,101,99,69,70,72,73,90,88,102,121,103,86,105}
    
    doors={75}
    size =6 //6
    floor_tiles = {}
    camx = player.x
    camy = player.y
    dtb_init(3)
    --enemie hosting
    enemies = {}
    enemie_sprites = {8,9,10,11,12,13,14,15,24,27,26,28,29,30,31,40,41,42,43,44,45,46,47,57,58,59,60,61,62,63,23,7,39,55,6,21,22}
    basic_enemies ={8,9,55,56,57,14,46,63,62,40,29,42}
    medium_enemies = {15,47,44,24,22,23,6,28,45,11,61}
    strong_enemies={30,31,41,7,12,13,60,43,58,27,26}
    bosses = {59,10,21,39}
    //turn counter
    turn_num = 0
    mines = {}
    //traps
    trap_tiles= {105,72,73}
   
    logInfo("<< main")	
end 


function _init()
-- Reset and Initialize the Log File
    resetLogFile()

    -- Example Usage
    setLogLevel(LogLevel.DEBUG)

    logDebug("This is a debug message.")
    logInfo("This is an info message.")
    logWarn("This is a warning message.")
    logError("This is an error message.")

    logInfo(">> init")	
    main()
    logInfo("<< init")

end
