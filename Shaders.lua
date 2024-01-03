function can_see(x1,y1,x2,y2)
    --x1 and y1 are the point of view
        local xvec=0
        local yvec=0
        local len=0
        local ret=true   
        local tx=x1
        local ty=y1
        xvec=x2-x1
        yvec=y2-y1
        len=sqrt(xvec^2+yvec^2)
        if len==0 then
            ret=true
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
                                        
    function bad_shader()
    for i=player.x-40, player.x+40,8 do
        for j=player.y-40, player.y+40,8 do
            if not(can_see(player.x+4,player.y+4,i,j)) then
                rectfill(i,j,i+7,j-7,0)
            end
    end
    end
    
    end
    