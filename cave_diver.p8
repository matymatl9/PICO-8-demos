pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	game_over=false
	make_cave()
	make_player()
end

function _update()
	if (not game_over) then
		update_cave()
		move_player()
		check_hit()
	else
		if (btnp(5)) _init()
	end
end

function _draw()
	cls()
	draw_cave()
	draw_player()
	
	if (game_over) then
		print("game over!",44,44,7)
		print("your score:"..player.score,34,54,7)
		print("press ❎ to play again!",18,72,6)
	else
		print("score:"..player.score,2,2,7)
	end
end

-->8
function make_player()
	player = {}
	player.x = 24
	player.y = 60
	player.dy = 0
	player.rise = 1
	player.fall = 2
	player.dead = 3
	player.speed = 2
	player.score = 0
end

function draw_player()
	if(game_over) then
		spr(player.dead,player.x,player.y)
	elseif(player.dy<0) then
		spr(player.fall,player.x,player.y)
	else
		spr(player.fall,player.x,player.y)
 end
end
	 
function move_player()
	gravity=0.2
	player.dy+=gravity
	
	if(btnp(2)) then
		player.dy-=4
		sfx(0)
	end
	
	player.y+=player.dy
	
	player.score+=player.speed
end				

function check_hit()
	for i=player.x,player.x+7 do
		if (cave[i+1].top>player.y
			or cave[i+1].btm<player.y+7) then
			game_over=true
			sfx(1)
		end
	end
end
-->8
function make_cave()
cave={{["top"]=5,["btm"]=119}}
top=45 
btm=85 
end

function update_cave()
if (#cave>player.speed) then
for i=1,player.speed do
del(cave,cave[1]) 
end
end
	
	while (#cave<128) do
		local col={}
		local up=flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top=mid(3,cave[#cave].top+up,top)
		col.btm=mid(btm,cave[#cave].btm+dwn,124)
		add(cave,col)
	end
end

function draw_cave()
	top_color=5 
	btm_color=5
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm,btm_color)
	end
end
__gfx__
0099990000cccc000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
099999900cccccc00888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99799799cc8cc8cc8858858800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999cccccccc8888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99000099c000000c8888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99099099cc0000cc8800008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
099999900cccccc00888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0099990000cccc000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c0500f050000500005000050000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00002f0500000026050000501c050000000804008030080300803008020080200802008010080100801000050000000000000000000000000000000000000000000000000000000000000000000000000000
