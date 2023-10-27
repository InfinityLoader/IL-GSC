/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_utility.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 176
 * Decompile Time: 213 ms
 * Timestamp: 10/27/2023 3:05:15 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_createfx;
#include maps/mp/_utility;
#include maps/mp/gametypes/_hud_util;

//Function Number: 1
addcallback(event,func)
{
/#
	assert(IsDefined(event),"Trying to set a callback on an undefined event.");
#/
	if(!IsDefined(level._callbacks) || !IsDefined(level._callbacks[event]))
	{
		level._callbacks[event] = [];
	}

	level._callbacks[event] = add_to_array(level._callbacks[event],func,0);
}

//Function Number: 2
callback(event)
{
	if(IsDefined(level._callbacks) && IsDefined(level._callbacks[event]))
	{
		for(i = 0;i < level._callbacks[event].size;i++)
		{
			callback = level._callbacks[event][i];
			if(IsDefined(callback))
			{
				self thread [[ callback ]]();
			}
		}
	}
}

//Function Number: 3
onfinalizeinitialization_callback(func)
{
	addcallback("on_finalize_initialization",func);
}

//Function Number: 4
triggeroff()
{
	if(!(IsDefined(self.realorigin)))
	{
		self.realorigin = self.origin;
	}

	if(self.origin == self.realorigin)
	{
		self.origin = 10000 + VectorScale((0,0,-1));
	}
}

//Function Number: 5
triggeron()
{
	if(IsDefined(self.realorigin))
	{
		self.origin = self.realorigin;
	}
}

//Function Number: 6
error(msg)
{
/#
	println("^c*ERROR* ",msg);
	wait(0.05);
/#
	assertmsg("This is a forced error - attach the log file");
#/
GetDvar(#"F49A52C") != "1"
#/
}

//Function Number: 7
warning(msg)
{
/#
	println("^1WARNING: " + msg);
#/
}

//Function Number: 8
spawn_array_struct()
{
	s = spawnstruct();
	s.a = [];
	return s;
}

//Function Number: 9
within_fov(start_origin,start_angles,end_origin,fov)
{
	normal = vectornormalize(end_origin - start_origin);
	forward = AnglesToForward(start_angles);
	dot = vectordot(forward,normal);
	return dot >= fov;
}

//Function Number: 10
append_array_struct(dst_s,src_s)
{
	for(i = 0;i < src_s.a.size;i++)
	{
		dst_s.a[dst_s.a.size] = src_s.a[i];
	}
}

//Function Number: 11
exploder(num)
{
	[[ level.exploderfunction ]](num);
}

//Function Number: 12
exploder_stop(num)
{
	stop_exploder(num);
}

//Function Number: 13
exploder_sound()
{
	if(IsDefined(self.script_delay))
	{
		wait(self.script_delay);
	}

	self playsound(level.scr_sound[self.script_sound]);
}

//Function Number: 14
cannon_effect()
{
	if(IsDefined(self.v["repeat"]))
	{
		for(i = 0;i < self.v["repeat"];i++)
		{
			playfx(level._effect[self.v["fxid"]],self.v["origin"],self.v["forward"],self.v["up"]);
			self exploder_delay();
		}

		return;
	}

	self exploder_delay();
	if(IsDefined(self.looper))
	{
		self.looper delete();
	}

	self.looper = spawnfx(getfx(self.v["fxid"]),self.v["origin"],self.v["forward"],self.v["up"]);
	triggerfx(self.looper);
	exploder_playsound();
}

//Function Number: 15
exploder_delay()
{
	if(!(IsDefined(self.v["delay"])))
	{
		self.v["delay"] = 0;
	}

	min_delay = self.v["delay"];
	max_delay = self.v["delay"] + 0.001;
	if(IsDefined(self.v["delay_min"]))
	{
		min_delay = self.v["delay_min"];
	}

	if(IsDefined(self.v["delay_max"]))
	{
		max_delay = self.v["delay_max"];
	}

	if(min_delay > 0)
	{
		wait(randomfloatrange(min_delay,max_delay));
	}
}

//Function Number: 16
exploder_playsound()
{
	if(!IsDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil")
	{
		return;
	}

	play_sound_in_space(self.v["soundalias"],self.v["origin"]);
}

//Function Number: 17
brush_delete()
{
	num = self.v["exploder"];
	if(IsDefined(self.v["delay"]))
	{
		wait(self.v["delay"]);
	}
	else
	{
		wait(0.05);
	}

	if(!(IsDefined(self.model)))
	{
		return;
	}

/#
	assert(IsDefined(self.model));
#/
	if(level.createfx_enabled)
	{
		if(IsDefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		self.model hide();
		self.model notsolid();
		wait(3);
		self.exploded = undefined;
		self.model show();
		self.model solid();
		return;
	}

	if(!IsDefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
	{
		self.v["exploder"] = undefined;
	}

	waittillframeend;
	self.model delete();
}

//Function Number: 18
brush_show()
{
	if(IsDefined(self.v["delay"]))
	{
		wait(self.v["delay"]);
	}

/#
	assert(IsDefined(self.model));
#/
	self.model show();
	self.model solid();
	if(level.createfx_enabled)
	{
		if(IsDefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		wait(3);
		self.exploded = undefined;
		self.model hide();
		self.model notsolid();
	}
}

//Function Number: 19
brush_throw()
{
	if(IsDefined(self.v["delay"]))
	{
		wait(self.v["delay"]);
	}

	ent = undefined;
	if(IsDefined(self.v["target"]))
	{
		ent = getent(self.v["target"],"targetname");
	}

	if(!(IsDefined(ent)))
	{
		self.model delete();
		return;
	}

	self.model show();
	startorg = self.v["origin"];
	startang = self.v["angles"];
	org = ent.origin;
	temp_vec = org - self.v["origin"];
	x = temp_vec[0];
	y = temp_vec[1];
	z = temp_vec[2];
	self.model rotatevelocity((x,y,z),12);
	self.model movegravity((x,y,z),12);
	if(level.createfx_enabled)
	{
		if(IsDefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		wait(3);
		self.exploded = undefined;
		self.v["origin"] = startorg;
		self.v["angles"] = startang;
		self.model hide();
		return;
	}

	self.v["exploder"] = undefined;
	wait(6);
	self.model delete();
}

//Function Number: 20
getplant()
{
	start = 10 + VectorScale((0,0,1));
	range = 11;
	forward = AnglesToForward(self.angles);
	forward = VectorScale(forward);
	traceorigins[0] = start + forward;
	traceorigins[1] = start;
	trace = bullettrace(traceorigins[0],18 + VectorScale((0,0,-1)),traceorigins[0],0);
	if(trace["fraction"] < 1)
	{
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = orienttonormal(trace["normal"]);
		return temp;
	}

	trace = bullettrace(traceorigins[1],18 + VectorScale((0,0,-1)),traceorigins[1],0);
	if(trace["fraction"] < 1)
	{
		temp = spawnstruct();
		temp.origin = trace["position"];
		temp.angles = orienttonormal(trace["normal"]);
		return temp;
	}

	traceorigins[2] = 16 + VectorScale((1,1,0));
	traceorigins[3] = 16 + VectorScale((1,-1,0));
	traceorigins[4] = 16 + VectorScale((-1,-1,0));
	traceorigins[5] = 16 + VectorScale((-1,1,0));
	besttracefraction = undefined;
	besttraceposition = undefined;
	for(i = 0;i < traceorigins.size;i++)
	{
		trace = bullettrace(traceorigins[i],1000 + VectorScale((0,0,-1)),traceorigins[i],0);
		if(!IsDefined(besttracefraction) || trace["fraction"] < besttracefraction)
		{
			besttracefraction = trace["fraction"];
			besttraceposition = trace["position"];
		}
	}

	if(besttracefraction == 1)
	{
		besttraceposition = self.origin;
	}

	temp = spawnstruct();
	temp.origin = besttraceposition;
	temp.angles = orienttonormal(trace["normal"]);
	return temp;
}

//Function Number: 21
orienttonormal(normal)
{
	hor_normal = (normal[0],normal[1],0);
	hor_length = length(hor_normal);
	if(!(hor_length))
	{
		return (0,0,0);
	}

	hor_dir = vectornormalize(hor_normal);
	neg_height = normal[2] * -1;
	tangent = (hor_dir[0] * neg_height,hor_dir[1] * neg_height,hor_length);
	plant_angle = VectorToAngles(tangent);
	return plant_angle;
}

//Function Number: 22
array_levelthread(ents,process,var,excluders)
{
	exclude = [];
	for(i = 0;i < ents.size;i++)
	{
		exclude[i] = 0;
	}

	if(IsDefined(excluders))
	{
		for(i = 0;i < ents.size;i++)
		{
			for(p = 0;p < excluders.size;p++)
			{
				if(ents[i] == excluders[p])
				{
					exclude[i] = 1;
				}
			}
		}
	}

	for(i = 0;i < ents.size;i++)
	{
		if(!(exclude[i]))
		{
			if(IsDefined(var))
			{
				level thread [[ process ]](ents[i],var);
			}
			else
			{
				level thread [[ process ]](ents[i]);
			}
		}
	}
}

//Function Number: 23
deleteplacedentity(entity)
{
	entities = getentarray(entity,"classname");
	for(i = 0;i < entities.size;i++)
	{
		entities[i] delete();
	}
}

//Function Number: 24
playsoundonplayers(sound,team)
{
/#
	assert(IsDefined(level.players));
#/
	if(level.splitscreen)
	{
		if(IsDefined(level.players[0]))
		{
			level.players[0] playlocalsound(sound);
		}
	}
	else if(IsDefined(team))
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(IsDefined(player.pers["team"]) && player.pers["team"] == team)
			{
				player playlocalsound(sound);
			}
		}
	}
	else
	{
		for(i = 0;i < level.players.size;i++)
		{
			level.players[i] playlocalsound(sound);
		}
	}
}

//Function Number: 25
get_player_height()
{
	return 70;
}

//Function Number: 26
isbulletimpactmod(smeansofdeath)
{
	return issubstr(smeansofdeath,"BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

//Function Number: 27
get_team_alive_players_s(teamname)
{
	teamplayers_s = spawn_array_struct();
	if(IsDefined(teamname) && IsDefined(level.aliveplayers) && IsDefined(level.aliveplayers[teamname]))
	{
		for(i = 0;i < level.aliveplayers[teamname].size;i++)
		{
			teamplayers_s.a[teamplayers_s.a.size] = level.aliveplayers[teamname][i];
		}
	}

	return teamplayers_s;
}

//Function Number: 28
get_all_alive_players_s()
{
	allplayers_s = spawn_array_struct();
	if(IsDefined(level.aliveplayers))
	{
		keys = getarraykeys(level.aliveplayers);
		for(i = 0;i < keys.size;i++)
		{
			team = keys[i];
			for(j = 0;j < level.aliveplayers[team].size;j++)
			{
				allplayers_s.a[allplayers_s.a.size] = level.aliveplayers[team][j];
			}
		}
	}

	return allplayers_s;
}

//Function Number: 29
waitrespawnbutton()
{
	self endon("disconnect");
	self endon("end_respawn");
	while(self usebuttonpressed() != 1)
	{
		wait(0.05);
	}
}

//Function Number: 30
setlowermessage(text,time,combinemessageandtimer)
{
	if(!(IsDefined(self.lowermessage)))
	{
		return;
	}

	if(IsDefined(self.lowermessageoverride) && text != &"")
	{
		text = self.lowermessageoverride;
		time = undefined;
	}

	self notify("lower_message_set");
	self.lowermessage settext(text);
	if(IsDefined(time) && time > 0)
	{
		if(!IsDefined(combinemessageandtimer) || !combinemessageandtimer)
		{
			self.lowertimer.label = &"";
		}
		else
		{
			self.lowermessage settext("");
			self.lowertimer.label = text;
		}

		self.lowertimer settimer(time);
	}
	else
	{
		self.lowertimer settext("");
		self.lowertimer.label = &"";
	}

	if(self issplitscreen())
	{
		self.lowermessage.fontscale = 1.4;
	}

	self.lowermessage fadeovertime(0.05);
	self.lowermessage.alpha = 1;
	self.lowertimer fadeovertime(0.05);
	self.lowertimer.alpha = 1;
}

//Function Number: 31
setlowermessagevalue(text,value,combinemessage)
{
	if(!(IsDefined(self.lowermessage)))
	{
		return;
	}

	if(IsDefined(self.lowermessageoverride) && text != &"")
	{
		text = self.lowermessageoverride;
		time = undefined;
	}

	self notify("lower_message_set");
	if(!IsDefined(combinemessage) || !combinemessage)
	{
		self.lowermessage settext(text);
	}
	else
	{
		self.lowermessage settext("");
	}

	if(IsDefined(value) && value > 0)
	{
		if(!IsDefined(combinemessage) || !combinemessage)
		{
			self.lowertimer.label = &"";
		}
		else
		{
			self.lowertimer.label = text;
		}

		self.lowertimer setvalue(value);
	}
	else
	{
		self.lowertimer settext("");
		self.lowertimer.label = &"";
	}

	if(self issplitscreen())
	{
		self.lowermessage.fontscale = 1.4;
	}

	self.lowermessage fadeovertime(0.05);
	self.lowermessage.alpha = 1;
	self.lowertimer fadeovertime(0.05);
	self.lowertimer.alpha = 1;
}

//Function Number: 32
clearlowermessage(fadetime)
{
	if(!(IsDefined(self.lowermessage)))
	{
		return;
	}

	self notify("lower_message_set");
	if(!IsDefined(fadetime) || fadetime == 0)
	{
		setlowermessage(&"");
	}
	else
	{
		self endon("disconnect");
		self endon("lower_message_set");
		self.lowermessage fadeovertime(fadetime);
		self.lowermessage.alpha = 0;
		self.lowertimer fadeovertime(fadetime);
		self.lowertimer.alpha = 0;
		wait(fadetime);
		self setlowermessage("");
	}
}

//Function Number: 33
printonteam(text,team)
{
/#
	assert(IsDefined(level.players));
#/
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintln(text);
		}
	}
}

//Function Number: 34
printboldonteam(text,team)
{
/#
	assert(IsDefined(level.players));
#/
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintlnbold(text);
		}
	}
}

//Function Number: 35
printboldonteamarg(text,team,arg)
{
/#
	assert(IsDefined(level.players));
#/
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player iprintlnbold(text,arg);
		}
	}
}

//Function Number: 36
printonteamarg(text,team,arg)
{
}

//Function Number: 37
printonplayers(text,team)
{
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		if(IsDefined(team))
		{
			if(IsDefined(players[i].pers["team"]) && players[i].pers["team"] == team)
			{
				players[i] iprintln(text);
			}
		}
		else
		{
			players[i] iprintln(text);
		}
	}
}

//Function Number: 38
printandsoundoneveryone(team,enemyteam,printfriendly,printenemy,soundfriendly,soundenemy,printarg)
{
	shoulddosounds = IsDefined(soundfriendly);
	shoulddoenemysounds = 0;
	if(IsDefined(soundenemy))
	{
/#
		assert(shoulddosounds);
#/
		shoulddoenemysounds = 1;
	}

	if(!(IsDefined(printarg)))
	{
		printarg = "";
	}

	if(level.splitscreen || !shoulddosounds)
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			playerteam = player.pers["team"];
			if(IsDefined(playerteam))
			{
				if(playerteam == team && IsDefined(printfriendly) && printfriendly != &"")
				{
					player iprintln(printfriendly,printarg);
				}
				else if(IsDefined(printenemy) && printenemy != &"")
				{
					if(IsDefined(enemyteam) && playerteam == enemyteam)
					{
						player iprintln(printenemy,printarg);
					}
					else if(!IsDefined(enemyteam) && playerteam != team)
					{
						player iprintln(printenemy,printarg);
					}
				}
			}
		}

		if(shoulddosounds)
		{
/#
			assert(level.splitscreen);
#/
			level.players[0] playlocalsound(soundfriendly);
		}
	}
	else
	{
/#
		assert(shoulddosounds);
#/
		if(shoulddoenemysounds)
		{
			for(i = 0;i < level.players.size;i++)
			{
				player = level.players[i];
				playerteam = player.pers["team"];
				if(IsDefined(playerteam))
				{
					if(playerteam == team)
					{
						if(IsDefined(printfriendly) && printfriendly != &"")
						{
							player iprintln(printfriendly,printarg);
						}

						player playlocalsound(soundfriendly);
					}
					else if((IsDefined(enemyteam) && playerteam == enemyteam) || !IsDefined(enemyteam) && playerteam != team)
					{
						if(IsDefined(printenemy) && printenemy != &"")
						{
							player iprintln(printenemy,printarg);
						}

						player playlocalsound(soundenemy);
					}
				}
			}
		}
		else
		{
			for(i = 0;i < level.players.size;i++)
			{
				player = level.players[i];
				playerteam = player.pers["team"];
				if(IsDefined(playerteam))
				{
					if(playerteam == team)
					{
						if(IsDefined(printfriendly) && printfriendly != &"")
						{
							player iprintln(printfriendly,printarg);
						}

						player playlocalsound(soundfriendly);
					}
					else if(IsDefined(printenemy) && printenemy != &"")
					{
						if(IsDefined(enemyteam) && playerteam == enemyteam)
						{
							player iprintln(printenemy,printarg);
						}
						else if(!IsDefined(enemyteam) && playerteam != team)
						{
							player iprintln(printenemy,printarg);
						}
					}
				}
			}
		}
	}
}

//Function Number: 39
_playlocalsound(soundalias)
{
	if(level.splitscreen && !self ishost())
	{
		return;
	}

	self playlocalsound(soundalias);
}

//Function Number: 40
dvarintvalue(dvar,defval,minval,maxval)
{
	dvar = "scr_" + level.gametype + "_" + dvar;
	if(GetDvar(dvar) == "")
	{
		setdvar(dvar,defval);
		return defval;
	}

	value = GetDvarInt(dvar);
	if(value > maxval)
	{
		value = maxval;
	}
	else if(value < minval)
	{
		value = minval;
	}
	else
	{
		return value;
	}

	setdvar(dvar,value);
	return value;
}

//Function Number: 41
dvarfloatvalue(dvar,defval,minval,maxval)
{
	dvar = "scr_" + level.gametype + "_" + dvar;
	if(GetDvar(dvar) == "")
	{
		setdvar(dvar,defval);
		return defval;
	}

	value = GetDvarFloat(dvar);
	if(value > maxval)
	{
		value = maxval;
	}
	else if(value < minval)
	{
		value = minval;
	}
	else
	{
		return value;
	}

	setdvar(dvar,value);
	return value;
}

//Function Number: 42
play_sound_on_tag(alias,tag)
{
	if(IsDefined(tag))
	{
		org = spawn("script_origin",self gettagorigin(tag));
		org linkto(self,tag,(0,0,0),(0,0,0));
	}
	else
	{
		org = spawn("script_origin",(0,0,0));
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}

	org playsound(alias);
	wait(5);
	org delete();
}

//Function Number: 43
createloopeffect(fxid)
{
	ent = maps/mp/_createfx::createeffect("loopfx",fxid);
	ent.v["delay"] = 0.5;
	return ent;
}

//Function Number: 44
createoneshoteffect(fxid)
{
	ent = maps/mp/_createfx::createeffect("oneshotfx",fxid);
	ent.v["delay"] = -15;
	return ent;
}

//Function Number: 45
loop_fx_sound(alias,origin,ender,timeout)
{
	org = spawn("script_origin",(0,0,0));
	if(IsDefined(ender))
	{
		thread loop_sound_delete(ender,org);
		self endon(ender);
	}

	org.origin = origin;
	org playloopsound(alias);
	if(!(IsDefined(timeout)))
	{
		return;
	}

	wait(timeout);
}

//Function Number: 46
exploder_damage()
{
	if(IsDefined(self.v["delay"]))
	{
		delay = self.v["delay"];
	}
	else
	{
		delay = 0;
	}

	if(IsDefined(self.v["damage_radius"]))
	{
		radius = self.v["damage_radius"];
	}
	else
	{
		radius = 128;
	}

	damage = self.v["damage"];
	origin = self.v["origin"];
	wait(delay);
	radiusdamage(origin,radius,damage,damage);
}

//Function Number: 47
exploder_before_load(num)
{
	waittillframeend;
	waittillframeend;
	activate_exploder(num);
}

//Function Number: 48
exploder_after_load(num)
{
	activate_exploder(num);
}

//Function Number: 49
getexploderid(ent)
{
	if(!(IsDefined(level._exploder_ids)))
	{
		level._exploder_ids = [];
		level._exploder_id = 1;
	}

	if(!(IsDefined(level._exploder_ids[ent.v["exploder"]])))
	{
		level._exploder_ids[ent.v["exploder"]] = level._exploder_id;
		level._exploder_id++;
	}

	return level._exploder_ids[ent.v["exploder"]];
}

//Function Number: 50
activate_exploder_on_clients(num)
{
	if(!(IsDefined(level._exploder_ids[num])))
	{
		return;
	}

	if(!(IsDefined(level._client_exploders[num])))
	{
		level._client_exploders[num] = 1;
	}

	if(!(IsDefined(level._client_exploder_ids[num])))
	{
		level._client_exploder_ids[num] = 1;
	}

	activateclientexploder(level._exploder_ids[num]);
}

//Function Number: 51
delete_exploder_on_clients(num)
{
	if(!(IsDefined(level._exploder_ids[num])))
	{
		return;
	}

	if(!(IsDefined(level._client_exploders[num])))
	{
		return;
	}

	level._client_exploders[num] = undefined;
	level._client_exploder_ids[num] = undefined;
	deactivateclientexploder(level._exploder_ids[num]);
}

//Function Number: 52
activate_individual_exploder()
{
	level notify("exploder" + self.v["exploder"]);
	if(level.createfx_enabled || !level.clientscripts || !IsDefined(level._exploder_ids[int(self.v["exploder"])]) || IsDefined(self.v["exploder_server"]))
	{
/#
		println("Exploder " + self.v["exploder"] + " created on server.");
#/
		if(IsDefined(self.v["firefx"]))
		{
			self thread fire_effect();
		}

		if(IsDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
		{
			self thread cannon_effect();
		}
		else if(IsDefined(self.v["soundalias"]))
		{
			self thread sound_effect();
		}
	}

	if(IsDefined(self.v["trailfx"]))
	{
		self thread trail_effect();
	}

	if(IsDefined(self.v["damage"]))
	{
		self thread exploder_damage();
	}

	if(self.v["exploder_type"] == "exploder")
	{
		self thread brush_show();
	}
	else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
	{
		self thread brush_throw();
	}
	else
	{
		self thread brush_delete();
	}
}

//Function Number: 53
trail_effect()
{
	self exploder_delay();
	if(!(IsDefined(self.v["trailfxtag"])))
	{
		self.v["trailfxtag"] = "tag_origin";
	}

	temp_ent = undefined;
	if(self.v["trailfxtag"] == "tag_origin")
	{
		playfxontag(level._effect[self.v["trailfx"]],self.model,self.v["trailfxtag"]);
	}
	else
	{
		temp_ent = spawn("script_model",self.model.origin);
		temp_ent setmodel("tag_origin");
		temp_ent linkto(self.model,self.v["trailfxtag"]);
		playfxontag(level._effect[self.v["trailfx"]],temp_ent,"tag_origin");
	}

	if(IsDefined(self.v["trailfxsound"]))
	{
		if(!(IsDefined(temp_ent)))
		{
			self.model playloopsound(self.v["trailfxsound"]);
		}
		else
		{
			temp_ent playloopsound(self.v["trailfxsound"]);
		}
	}

	if(IsDefined(self.v["ender"]) && IsDefined(temp_ent))
	{
		level thread trail_effect_ender(temp_ent,self.v["ender"]);
	}

	if(!(IsDefined(self.v["trailfxtimeout"])))
	{
		return;
	}

	wait(self.v["trailfxtimeout"]);
	if(IsDefined(temp_ent))
	{
		temp_ent delete();
	}
}

//Function Number: 54
trail_effect_ender(ent,ender)
{
	ent endon("death");
	self waittill(ender);
	ent delete();
}

//Function Number: 55
activate_exploder(num)
{
	num = int(num);
/#
	i = 0;
	for(;;)
	{
		ent = level.createfxent[i];
		client_send = 0;
		ent activate_individual_exploder();
		i++;
	}
Stack-Empty ? Stack-Empty : ((level.createfx_enabled) ? i < level.createfxent.size : (IsDefined(ent) ? ent.v["type"] != "exploder" : ((IsDefined(ent.v["exploder"])) ? ent.v["exploder"] != num : IsDefined(ent.v["exploder_server"]))))
#/
	client_send = 1;
	if(IsDefined(level.createfxexploders[num]))
	{
		for(i = 0;i < level.createfxexploders[num].size;i++)
		{
			if(client_send && IsDefined(level.createfxexploders[num][i].v["exploder_server"]))
			{
				client_send = 0;
			}

			level.createfxexploders[num][i] activate_individual_exploder();
		}
	}

	if(level.clientscripts)
	{
		if(!level.createfx_enabled && client_send == 1)
		{
			activate_exploder_on_clients(num);
		}
	}
}

//Function Number: 56
stop_exploder(num)
{
	num = int(num);
	if(level.clientscripts)
	{
		if(!(level.createfx_enabled))
		{
			delete_exploder_on_clients(num);
		}
	}

	if(IsDefined(level.createfxexploders[num]))
	{
		for(i = 0;i < level.createfxexploders[num].size;i++)
		{
			if(!(IsDefined(level.createfxexploders[num][i].looper)))
			{
			}
			else
			{
				level.createfxexploders[num][i].looper delete();
			}
		}
	}
}

//Function Number: 57
sound_effect()
{
	self effect_soundalias();
}

//Function Number: 58
effect_soundalias()
{
	if(!(IsDefined(self.v["delay"])))
	{
		self.v["delay"] = 0;
	}

	origin = self.v["origin"];
	alias = self.v["soundalias"];
	wait(self.v["delay"]);
	play_sound_in_space(alias,origin);
}

//Function Number: 59
play_sound_in_space(alias,origin,master)
{
	org = spawn("script_origin",(0,0,1));
	if(!(IsDefined(origin)))
	{
		origin = self.origin;
	}

	org.origin = origin;
	if(IsDefined(master) && master)
	{
		org playsoundasmaster(alias);
	}
	else
	{
		org playsound(alias);
	}

	wait(10);
	org delete();
}

//Function Number: 60
loop_sound_in_space(alias,origin,ender)
{
	org = spawn("script_origin",(0,0,1));
	if(!(IsDefined(origin)))
	{
		origin = self.origin;
	}

	org.origin = origin;
	org playloopsound(alias);
	level waittill(ender);
	org stoploopsound();
	wait(0.1);
	org delete();
}

//Function Number: 61
fire_effect()
{
	if(!(IsDefined(self.v["delay"])))
	{
		self.v["delay"] = 0;
	}

	delay = self.v["delay"];
	if(IsDefined(self.v["delay_min"]) && IsDefined(self.v["delay_max"]))
	{
		delay = self.v["delay_min"] + randomfloat(self.v["delay_max"] - self.v["delay_min"]);
	}

	forward = self.v["forward"];
	up = self.v["up"];
	org = undefined;
	firefxsound = self.v["firefxsound"];
	origin = self.v["origin"];
	firefx = self.v["firefx"];
	ender = self.v["ender"];
	if(!(IsDefined(ender)))
	{
		ender = "createfx_effectStopper";
	}

	timeout = self.v["firefxtimeout"];
	firefxdelay = 0.5;
	if(IsDefined(self.v["firefxdelay"]))
	{
		firefxdelay = self.v["firefxdelay"];
	}

	wait(delay);
	if(IsDefined(firefxsound))
	{
		level thread loop_fx_sound(firefxsound,origin,ender,timeout);
	}

	playfx(level._effect[firefx],self.v["origin"],forward,up);
}

//Function Number: 62
loop_sound_delete(ender,ent)
{
	ent endon("death");
	self waittill(ender);
	ent delete();
}

//Function Number: 63
createexploder(fxid)
{
	ent = maps/mp/_createfx::createeffect("exploder",fxid);
	ent.v["delay"] = 0;
	ent.v["exploder"] = 1;
	ent.v["exploder_type"] = "normal";
	return ent;
}

//Function Number: 64
getotherteam(team)
{
	if(team == "allies")
	{
		return "axis";
	}
	else if(team == "axis")
	{
		return "allies";
	}
	else
	{
		return "allies";
	}

/#
	assertmsg("getOtherTeam: invalid team " + team);
#/
}

//Function Number: 65
getteammask(team)
{
	if(!level.teambased || !IsDefined(team) || !IsDefined(level.spawnsystem.ispawn_teammask[team]))
	{
		return level.spawnsystem.ispawn_teammask_free;
	}

	return level.spawnsystem.ispawn_teammask[team];
}

//Function Number: 66
getotherteamsmask(skip_team)
{
	mask = 0;
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else
		{
			mask = mask | getteammask(team);
		}
	}

	return mask;
}

//Function Number: 67
wait_endon(waittime,endonstring,endonstring2,endonstring3,endonstring4)
{
	self endon(endonstring);
	if(IsDefined(endonstring2))
	{
		self endon(endonstring2);
	}

	if(IsDefined(endonstring3))
	{
		self endon(endonstring3);
	}

	if(IsDefined(endonstring4))
	{
		self endon(endonstring4);
	}

	wait(waittime);
	return 1;
}

//Function Number: 68
ismg(weapon)
{
	return issubstr(weapon,"_bipod_");
}

//Function Number: 69
plot_points(plotpoints,r,g,b,timer)
{
/#
	lastpoint = plotpoints[0];
	r = 1;
	g = 1;
	b = 1;
	timer = 0.05;
	i = 1;
	for(;;)
	{
		line(lastpoint,plotpoints[i],(r,g,b),1,timer);
		lastpoint = plotpoints[i];
		i++;
	}
i < plotpoints.size
IsDefined(timer)
IsDefined(b)
IsDefined(g)
IsDefined(r)
#/
}

//Function Number: 70
player_flag_wait(msg)
{
	while(!(self.flag[msg]))
	{
		self waittill(msg);
	}
}

//Function Number: 71
player_flag_wait_either(flag1,flag2)
{
	for(;;)
	{
		if(flag(flag1))
		{
			return;
		}

		if(flag(flag2))
		{
			return;
		}

		self waittill_either(flag1,flag2);
	}
}

//Function Number: 72
player_flag_waitopen(msg)
{
	while(self.flag[msg])
	{
		self waittill(msg);
	}
}

//Function Number: 73
player_flag_init(message,trigger)
{
	if(!(IsDefined(self.flag)))
	{
		self.flag = [];
		self.flags_lock = [];
	}

/#
	assert(!IsDefined(self.flag[message]),"Attempt to reinitialize existing message: " + message);
#/
	self.flag[message] = 0;
/#
	self.flags_lock[message] = 0;
#/
}

//Function Number: 74
player_flag_set_delayed(message,delay)
{
	wait(delay);
	player_flag_set(message);
}

//Function Number: 75
player_flag_set(message)
{
/#
/#
	assert(IsDefined(self.flag[message]),"Attempt to set a flag before calling flag_init: " + message);
#/
/#
	assert(self.flag[message] == self.flags_lock[message]);
#/
	self.flags_lock[message] = 1;
#/
	self.flag[message] = 1;
	self notify(message);
}

//Function Number: 76
player_flag_clear(message)
{
/#
/#
	assert(IsDefined(self.flag[message]),"Attempt to set a flag before calling flag_init: " + message);
#/
/#
	assert(self.flag[message] == self.flags_lock[message]);
#/
	self.flags_lock[message] = 0;
#/
	self.flag[message] = 0;
	self notify(message);
}

//Function Number: 77
player_flag(message)
{
/#
	assert(IsDefined(message),"Tried to check flag but the flag was not defined.");
#/
	if(!(self.flag[message]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 78
registerclientsys(ssysname)
{
	if(!(IsDefined(level._clientsys)))
	{
		level._clientsys = [];
	}

	if(level._clientsys.size >= 32)
	{
/#
		error("Max num client systems exceeded.");
#/
		return;
	}

	if(IsDefined(level._clientsys[ssysname]))
	{
/#
		error("Attempt to re-register client system : " + ssysname);
#/
		return;
	}
	else
	{
		level._clientsys[ssysname] = spawnstruct();
		level._clientsys[ssysname].sysid = clientsysregister(ssysname);
	}
}

//Function Number: 79
setclientsysstate(ssysname,ssysstate,player)
{
	if(!(IsDefined(level._clientsys)))
	{
/#
		error("setClientSysState called before registration of any systems.");
#/
		return;
	}

	if(!(IsDefined(level._clientsys[ssysname])))
	{
/#
		error("setClientSysState called on unregistered system " + ssysname);
#/
		return;
	}

	if(IsDefined(player))
	{
		player clientsyssetstate(level._clientsys[ssysname].sysid,ssysstate);
	}
	else
	{
		clientsyssetstate(level._clientsys[ssysname].sysid,ssysstate);
		level._clientsys[ssysname].sysstate = ssysstate;
	}
}

//Function Number: 80
getclientsysstate(ssysname)
{
	if(!(IsDefined(level._clientsys)))
	{
/#
		error("Cannot getClientSysState before registering any client systems.");
#/
		return "";
	}

	if(!(IsDefined(level._clientsys[ssysname])))
	{
/#
		error("Client system " + ssysname + " cannot return state, as it is unregistered.");
#/
		return "";
	}

	if(IsDefined(level._clientsys[ssysname].sysstate))
	{
		return level._clientsys[ssysname].sysstate;
	}

	return "";
}

//Function Number: 81
clientnotify(event)
{
	if(level.clientscripts)
	{
		if(isplayer(self))
		{
			maps/mp/_utility::setclientsysstate("levelNotify",event,self);
		}
		else
		{
			maps/mp/_utility::setclientsysstate("levelNotify",event);
		}
	}
}

//Function Number: 82
alphabet_compare(a,b)
{
	list = [];
	val = 1;
	list["0"] = val;
	val++;
	list["1"] = val;
	val++;
	list["2"] = val;
	val++;
	list["3"] = val;
	val++;
	list["4"] = val;
	val++;
	list["5"] = val;
	val++;
	list["6"] = val;
	val++;
	list["7"] = val;
	val++;
	list["8"] = val;
	val++;
	list["9"] = val;
	val++;
	list["_"] = val;
	val++;
	list["a"] = val;
	val++;
	list["b"] = val;
	val++;
	list["c"] = val;
	val++;
	list["d"] = val;
	val++;
	list["e"] = val;
	val++;
	list["f"] = val;
	val++;
	list["g"] = val;
	val++;
	list["h"] = val;
	val++;
	list["i"] = val;
	val++;
	list["j"] = val;
	val++;
	list["k"] = val;
	val++;
	list["l"] = val;
	val++;
	list["m"] = val;
	val++;
	list["n"] = val;
	val++;
	list["o"] = val;
	val++;
	list["p"] = val;
	val++;
	list["q"] = val;
	val++;
	list["r"] = val;
	val++;
	list["s"] = val;
	val++;
	list["t"] = val;
	val++;
	list["u"] = val;
	val++;
	list["v"] = val;
	val++;
	list["w"] = val;
	val++;
	list["x"] = val;
	val++;
	list["y"] = val;
	val++;
	list["z"] = val;
	val++;
	a = tolower(a);
	b = tolower(b);
	val1 = 0;
	if(IsDefined(list[a]))
	{
		val1 = list[a];
	}

	val2 = 0;
	if(IsDefined(list[b]))
	{
		val2 = list[b];
	}

	if(val1 > val2)
	{
		return "1st";
	}

	if(val1 < val2)
	{
		return "2nd";
	}

	return "same";
}

//Function Number: 83
is_later_in_alphabet(string1,string2)
{
	count = string1.size;
	if(count >= string2.size)
	{
		count = string2.size;
	}

	for(i = 0;i < count;i++)
	{
		val = alphabet_compare(string1[i],string2[i]);
		if(val == "1st")
		{
			return 1;
		}

		if(val == "2nd")
		{
			return 0;
		}
	}

	return string1.size > string2.size;
}

//Function Number: 84
alphabetize(array)
{
	if(array.size <= 1)
	{
		return array;
	}

	count = 0;
	for(;;)
	{
		changed = 0;
		for(i = 0;i < array.size - 1;i++)
		{
			if(is_later_in_alphabet(array[i],array[i + 1]))
			{
				val = array[i];
				array[i] = array[i + 1];
				array[i + 1] = val;
				changed = 1;
				count++;
				if(count >= 9)
				{
					count = 0;
					wait(0.05);
				}
			}
		}

		if(!(changed))
		{
			return array;
		}
	}

	return array;
}

//Function Number: 85
get_players()
{
	players = getplayers();
	return players;
}

//Function Number: 86
getfx(fx)
{
/#
	assert(IsDefined(level._effect[fx]),"Fx " + fx + " is not defined in level._effect.");
#/
	return level._effect[fx];
}

//Function Number: 87
struct_arrayspawn()
{
	struct = spawnstruct();
	struct.array = [];
	struct.lastindex = 0;
	return struct;
}

//Function Number: 88
structarray_add(struct,object)
{
/#
	assert(!IsDefined(object.struct_array_index));
#/
	struct.array[struct.lastindex] = object;
	object.struct_array_index = struct.lastindex;
	struct.lastindex++;
}

//Function Number: 89
structarray_remove(struct,object)
{
	structarray_swaptolast(struct,object);
	struct.array[struct.lastindex - 1] = undefined;
	struct.lastindex--;
}

//Function Number: 90
structarray_swaptolast(struct,object)
{
	struct structarray_swap(struct.array[struct.lastindex - 1],object);
}

//Function Number: 91
structarray_shuffle(struct,shuffle)
{
	for(i = 0;i < shuffle;i++)
	{
		struct structarray_swap(struct.array[i],struct.array[randomint(struct.lastindex)]);
	}
}

//Function Number: 92
structarray_swap(object1,object2)
{
	index1 = object1.struct_array_index;
	index2 = object2.struct_array_index;
	self.array[index2] = object1;
	self.array[index1] = object2;
	self.array[index1].struct_array_index = index1;
	self.array[index2].struct_array_index = index2;
}

//Function Number: 93
waittill_either(msg1,msg2)
{
	self endon(msg1);
	self waittill(msg2);
}

//Function Number: 94
combinearrays(array1,array2)
{
/#
	assert(IsDefined(array1) || IsDefined(array2));
#/
	if(!IsDefined(array1) && IsDefined(array2))
	{
		return array2;
	}

	if(!IsDefined(array2) && IsDefined(array1))
	{
		return array1;
	}

	foreach(elem in array2)
	{
		array1[array1.size] = elem;
	}

	return array1;
}

//Function Number: 95
getclosest(org,array,dist)
{
	return comparesizes(org,array,dist,::closerfunc);
}

//Function Number: 96
getclosestfx(org,fxarray,dist)
{
	return comparesizesfx(org,fxarray,dist,::closerfunc);
}

//Function Number: 97
getfarthest(org,array,dist)
{
	return comparesizes(org,array,dist,::fartherfunc);
}

//Function Number: 98
comparesizesfx(org,array,dist,comparefunc)
{
	if(!(array.size))
	{
		return undefined;
	}

	if(IsDefined(dist))
	{
		distsqr = dist * dist;
		struct = undefined;
		keys = getarraykeys(array);
		for(i = 0;i < keys.size;i++)
		{
			newdistsqr = distancesquared(array[keys[i]].v["origin"],org);
			if([[ comparefunc ]](newdistsqr,distsqr))
			{
			}
			else
			{
				distsqr = newdistsqr;
				struct = array[keys[i]];
			}
		}

		return struct;
	}

	keys = getarraykeys(array);
	struct = array[keys[0]];
	distsqr = distancesquared(struct.v["origin"],org);
	for(i = 1;i < keys.size;i++)
	{
		newdistsqr = distancesquared(array[keys[i]].v["origin"],org);
		if([[ comparefunc ]](newdistsqr,distsqr))
		{
		}
		else
		{
			distsqr = newdistsqr;
			struct = array[keys[i]];
		}
	}

	return struct;
}

//Function Number: 99
comparesizes(org,array,dist,comparefunc)
{
	if(!(array.size))
	{
		return undefined;
	}

	if(IsDefined(dist))
	{
		distsqr = dist * dist;
		ent = undefined;
		keys = getarraykeys(array);
		for(i = 0;i < keys.size;i++)
		{
			if(!(IsDefined(array[keys[i]])))
			{
			}
			else
			{
				newdistsqr = distancesquared(array[keys[i]].origin,org);
				if([[ comparefunc ]](newdistsqr,distsqr))
				{
				}
				else
				{
					distsqr = newdistsqr;
					ent = array[keys[i]];
				}
			}
		}

		return ent;
	}

	keys = getarraykeys(array);
	ent = array[keys[0]];
	distsqr = distancesquared(ent.origin,org);
	for(i = 1;i < keys.size;i++)
	{
		if(!(IsDefined(array[keys[i]])))
		{
		}
		else
		{
			newdistsqr = distancesquared(array[keys[i]].origin,org);
			if([[ comparefunc ]](newdistsqr,distsqr))
			{
			}
			else
			{
				distsqr = newdistsqr;
				ent = array[keys[i]];
			}
		}
	}

	return ent;
}

//Function Number: 100
closerfunc(dist1,dist2)
{
	return dist1 >= dist2;
}

//Function Number: 101
fartherfunc(dist1,dist2)
{
	return dist1 <= dist2;
}

//Function Number: 102
get_array_of_closest(org,array,excluders,max,maxdist)
{
	if(!(IsDefined(max)))
	{
		max = array.size;
	}

	if(!(IsDefined(excluders)))
	{
		excluders = [];
	}

	maxdists2rd = undefined;
	if(IsDefined(maxdist))
	{
		maxdists2rd = maxdist * maxdist;
	}

	dist = [];
	index = [];
	for(i = 0;i < array.size;i++)
	{
		if(!(IsDefined(array[i])))
		{
		}
		else
		{
			excluded = 0;
			for(p = 0;p < excluders.size;p++)
			{
				if(array[i] != excluders[p])
				{
				}
				else
				{
					excluded = 1;
					break;
				}
			}

			if(excluded)
			{
			}
			else
			{
				length = distancesquared(org,array[i].origin);
				if(IsDefined(maxdists2rd) && maxdists2rd < length)
				{
				}
				else
				{
					dist[dist.size] = length;
					index[index.size] = i;
				}
			}
		}
	}

	for(;;)
	{
		change = 0;
		for(i = 0;i < dist.size - 1;i++)
		{
			if(dist[i] <= dist[i + 1])
			{
			}
			else
			{
				change = 1;
				temp = dist[i];
				dist[i] = dist[i + 1];
				dist[i + 1] = temp;
				temp = index[i];
				index[i] = index[i + 1];
				index[i + 1] = temp;
			}
		}

		if(!(change))
		{
			break;
		}
	}

	newarray = [];
	if(max > dist.size)
	{
		max = dist.size;
	}

	for(i = 0;i < max;i++)
	{
		newarray[i] = array[index[i]];
	}

	return newarray;
}

//Function Number: 103
set_dvar_if_unset(dvar,value,reset)
{
	if(!(IsDefined(reset)))
	{
		reset = 0;
	}

	if(reset || GetDvar(dvar) == "")
	{
		setdvar(dvar,value);
		return value;
	}
}

//Function Number: 104
set_dvar_float_if_unset(dvar,value,reset)
{
	if(!(IsDefined(reset)))
	{
		reset = 0;
	}

	if(reset || GetDvar(dvar) == "")
	{
		setdvar(dvar,value);
	}

	return GetDvarFloat(dvar);
}

//Function Number: 105
set_dvar_int_if_unset(dvar,value,reset)
{
	if(!(IsDefined(reset)))
	{
		reset = 0;
	}

	if(reset || GetDvar(dvar) == "")
	{
		setdvar(dvar,value);
		return int(value);
	}

	return GetDvarInt(dvar);
}

//Function Number: 106
drawcylinder(pos,rad,height,duration,stop_notify)
{
/#
	duration = 0;
	level thread drawcylinder_think(pos,rad,height,duration,stop_notify);
IsDefined(duration)
#/
}

//Function Number: 107
drawcylinder_think(pos,rad,height,seconds,stop_notify)
{
/#
	level endon(stop_notify,IsDefined(stop_notify));
	stop_time = GetTime() + seconds * 1000;
	currad = rad;
	curheight = height;
	for(;;)
	{
		return;
		r = 0;
		for(;;)
		{
			theta = r / 20 * 360;
			theta2 = r + 1 / 20 * 360;
			line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta2) * currad,sin(theta2) * currad,0));
			line(pos + (cos(theta) * currad,sin(theta) * currad,curheight),pos + (cos(theta2) * currad,sin(theta2) * currad,curheight));
			line(pos + (cos(theta) * currad,sin(theta) * currad,0),pos + (cos(theta) * currad,sin(theta) * currad,curheight));
			r++;
		}
		wait(0.05);
	}
r < 20
seconds > 0 && stop_time <= GetTime()
#/
}

//Function Number: 108
is_bot()
{
	return isplayer(self) && IsDefined(self.pers["isBot"]) && self.pers["isBot"] != 0;
}

//Function Number: 109
add_trigger_to_ent(ent)
{
	if(!(IsDefined(ent._triggers)))
	{
		ent._triggers = [];
	}

	ent._triggers[self getentitynumber()] = 1;
}

//Function Number: 110
remove_trigger_from_ent(ent)
{
	if(!(IsDefined(ent)))
	{
		return;
	}

	if(!(IsDefined(ent._triggers)))
	{
		return;
	}

	if(!(IsDefined(ent._triggers[self getentitynumber()])))
	{
		return;
	}

	ent._triggers[self getentitynumber()] = 0;
}

//Function Number: 111
ent_already_in_trigger(trig)
{
	if(!(IsDefined(self._triggers)))
	{
		return 0;
	}

	if(!(IsDefined(self._triggers[trig getentitynumber()])))
	{
		return 0;
	}

	if(!(self._triggers[trig getentitynumber()]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 112
trigger_thread_death_monitor(ent,ender)
{
	ent waittill("death");
	self endon(ender);
	self remove_trigger_from_ent(ent);
}

//Function Number: 113
trigger_thread(ent,on_enter_payload,on_exit_payload)
{
	ent endon("entityshutdown");
	ent endon("death");
	if(ent ent_already_in_trigger(self))
	{
		return;
	}

	self add_trigger_to_ent(ent);
	ender = "end_trig_death_monitor" + self getentitynumber() + " " + ent getentitynumber();
	self thread trigger_thread_death_monitor(ent,ender);
	endon_condition = "leave_trigger_" + self getentitynumber();
	if(IsDefined(on_enter_payload))
	{
		self thread [[ on_enter_payload ]](ent,endon_condition);
	}

	while(IsDefined(ent) && ent istouching(self))
	{
		wait(0.01);
	}

	ent notify(endon_condition);
	if(IsDefined(ent) && IsDefined(on_exit_payload))
	{
		self thread [[ on_exit_payload ]](ent);
	}

	if(IsDefined(ent))
	{
		self remove_trigger_from_ent(ent);
	}

	self notify(ender);
}

//Function Number: 114
isoneround()
{
	if(level.roundlimit == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 115
isfirstround()
{
	if(level.roundlimit > 1 && game["roundsplayed"] == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 116
islastround()
{
	if(level.roundlimit > 1 && game["roundsplayed"] >= level.roundlimit - 1)
	{
		return 1;
	}
}

//Function Number: 117
waslastround()
{
	if(level.forcedend)
	{
		return 1;
	}

	if(IsDefined(level.shouldplayovertimeround))
	{
		if([[ level.shouldplayovertimeround ]]())
		{
			level.nextroundisovertime = 1;
			return 0;
		}
		else if(IsDefined(game["overtime_round"]))
		{
			return 1;
		}
	}

	if(hitroundlimit() || hitscorelimit() || hitroundwinlimit())
	{
		return 1;
	}

	return 0;
}

//Function Number: 118
hitroundlimit()
{
	if(level.roundlimit <= 0)
	{
		return 0;
	}

	return getroundsplayed() >= level.roundlimit;
}

//Function Number: 119
anyteamhitroundwinlimit()
{
	foreach(team in level.teams)
	{
		if(getroundswon(team) >= level.roundwinlimit)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 120
anyteamhitroundlimitwithdraws()
{
	tie_wins = game["roundswon"]["tie"];
	foreach(team in level.teams)
	{
		if(getroundswon(team) + tie_wins >= level.roundwinlimit)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 121
getroundwinlimitwinningteam()
{
	max_wins = 0;
	winning_team = undefined;
	foreach(team in level.teams)
	{
		wins = getroundswon(team);
		if(!(IsDefined(winning_team)))
		{
			max_wins = wins;
			winning_team = team;
		}
		else if(wins == max_wins)
		{
			winning_team = "tie";
		}
		else if(wins > max_wins)
		{
			max_wins = wins;
			winning_team = team;
		}
	}

	return winning_team;
}

//Function Number: 122
hitroundwinlimit()
{
	if(!IsDefined(level.roundwinlimit) || level.roundwinlimit <= 0)
	{
		return 0;
	}

	if(anyteamhitroundwinlimit())
	{
		return 1;
	}

	if(anyteamhitroundlimitwithdraws())
	{
		if(getroundwinlimitwinningteam() != "tie")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 123
anyteamhitscorelimit()
{
	foreach(team in level.teams)
	{
		if(game["teamScores"][team] >= level.scorelimit)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 124
hitscorelimit()
{
	if(isscoreroundbased())
	{
		return 0;
	}

	if(level.scorelimit <= 0)
	{
		return 0;
	}

	if(level.teambased)
	{
		if(anyteamhitscorelimit())
		{
			return 1;
		}
	}
	else
	{
		for(i = 0;i < level.players.size;i++)
		{
			player = level.players[i];
			if(IsDefined(player.pointstowin) && player.pointstowin >= level.scorelimit)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 125
getroundswon(team)
{
	return game["roundswon"][team];
}

//Function Number: 126
getotherteamsroundswon(skip_team)
{
	roundswon = 0;
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else
		{
			roundswon = roundswon + game["roundswon"][team];
		}
	}

	return roundswon;
}

//Function Number: 127
getroundsplayed()
{
	return game["roundsplayed"];
}

//Function Number: 128
isscoreroundbased()
{
	return level.scoreroundbased;
}

//Function Number: 129
isroundbased()
{
	if(level.roundlimit != 1 && level.roundwinlimit != 1)
	{
		return 1;
	}
}

//Function Number: 130
waittillnotmoving()
{
	if(self ishacked())
	{
		wait(0.05);
		return;
	}

	if(self.classname == "grenade")
	{
		self waittill("stationary");
	}
	else
	{
		prevorigin = self.origin;
		while(1)
		{
			wait(0.15);
			if(self.origin == prevorigin)
			{
				break;
			}

			prevorigin = self.origin;
		}
	}
}

//Function Number: 131
mayapplyscreeneffect()
{
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
	return !IsDefined(self.viewlockedentity);
}

//Function Number: 132
getdvarfloatdefault(dvarname,defaultvalue)
{
	value = GetDvar(dvarname);
	if(value != "")
	{
		return float(value);
	}
}

//Function Number: 133
getdvarintdefault(dvarname,defaultvalue)
{
	value = GetDvar(dvarname);
	if(value != "")
	{
		return int(value);
	}
}

//Function Number: 134
closestpointonline(point,linestart,lineend)
{
	linemagsqrd = lengthsquared(lineend - linestart);
	t = point[0] - linestart[0] * lineend[0] - linestart[0] + point[1] - linestart[1] * lineend[1] - linestart[1] + point[2] - linestart[2] * lineend[2] - linestart[2] / linemagsqrd;
	if(t < 0)
	{
		return linestart;
	}
	else if(t > 1)
	{
		return lineend;
	}

	start_x = linestart[0] + t * lineend[0] - linestart[0];
	start_y = linestart[1] + t * lineend[1] - linestart[1];
	start_z = linestart[2] + t * lineend[2] - linestart[2];
	return (start_x,start_y,start_z);
}

//Function Number: 135
isstrstart(string1,substr)
{
	return getsubstr(string1,0,substr.size) == substr;
}

//Function Number: 136
spread_array_thread(entities,process,var1,var2,var3)
{
	keys = getarraykeys(entities);
	if(IsDefined(var3))
	{
		for(i = 0;i < keys.size;i++)
		{
			entities[keys[i]] thread [[ process ]](var1,var2,var3);
			wait(0.1);
		}

		return;
	}

	if(IsDefined(var2))
	{
		for(i = 0;i < keys.size;i++)
		{
			entities[keys[i]] thread [[ process ]](var1,var2);
			wait(0.1);
		}

		return;
	}

	if(IsDefined(var1))
	{
		for(i = 0;i < keys.size;i++)
		{
			entities[keys[i]] thread [[ process ]](var1);
			wait(0.1);
		}

		return;
	}

	for(i = 0;i < keys.size;i++)
	{
		entities[keys[i]] thread [[ process ]]();
		wait(0.1);
	}
}

//Function Number: 137
freeze_player_controls(boolean)
{
/#
	assert(IsDefined(boolean),"\'freeze_player_controls()\' has not been passed an argument properly.");
#/
	if(boolean && IsDefined(self))
	{
		self freezecontrols(boolean);
	}
	else if(!boolean && IsDefined(self) && !level.gameended)
	{
		self freezecontrols(boolean);
	}
}

//Function Number: 138
gethostplayer()
{
	players = get_players();
	for(index = 0;index < players.size;index++)
	{
		if(players[index] ishost())
		{
			return players[index];
		}
	}
}

//Function Number: 139
gethostplayerforbots()
{
	players = get_players();
	for(index = 0;index < players.size;index++)
	{
		if(players[index] ishostforbots())
		{
			return players[index];
		}
	}
}

//Function Number: 140
ispregame()
{
	return IsDefined(level.pregame) && level.pregame;
}

//Function Number: 141
iskillstreaksenabled()
{
	return IsDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

//Function Number: 142
isrankenabled()
{
	return IsDefined(level.rankenabled) && level.rankenabled;
}

//Function Number: 143
playsmokesound(position,duration,startsound,stopsound,loopsound)
{
	smokesound = spawn("script_origin",(0,0,1));
	smokesound.origin = position;
	smokesound playsound(startsound);
	smokesound playloopsound(loopsound);
	if(duration > 0.5)
	{
		wait(duration - 0.5);
	}

	thread playsoundinspace(stopsound,position);
	smokesound stoploopsound(0.5);
	wait(0.5);
	smokesound delete();
}

//Function Number: 144
playsoundinspace(alias,origin,master)
{
	org = spawn("script_origin",(0,0,1));
	if(!(IsDefined(origin)))
	{
		origin = self.origin;
	}

	org.origin = origin;
	if(IsDefined(master) && master)
	{
		org playsoundasmaster(alias);
	}
	else
	{
		org playsound(alias);
	}

	wait(10);
	org delete();
}

//Function Number: 145
get2dyaw(start,end)
{
	yaw = 0;
	vector = (end[0] - start[0],end[1] - start[1],0);
	return vectoangles(vector);
}

//Function Number: 146
vectoangles(vector)
{
	yaw = 0;
	vecx = vector[0];
	vecy = vector[1];
	if(vecx == 0 && vecy == 0)
	{
		return 0;
	}

	if(vecy < 0.001 && vecy > -0.001)
	{
		vecy = 0.001;
	}

	yaw = atan(vecx / vecy);
	if(vecy < 0)
	{
		yaw = yaw + 180;
	}

	return 90 - yaw;
}

//Function Number: 147
deleteaftertime(time)
{
/#
	assert(IsDefined(self));
#/
/#
	assert(IsDefined(time));
#/
/#
	assert(time >= 0.05);
#/
	self thread deleteaftertimethread(time);
}

//Function Number: 148
deleteaftertimethread(time)
{
	self endon("death");
	wait(time);
	self delete();
}

//Function Number: 149
setusingremote(remotename)
{
	if(IsDefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}

/#
	assert(!self isusingremote());
#/
	self.usingremote = remotename;
	self disableoffhandweapons();
	self notify("using_remote");
}

//Function Number: 150
getremotename()
{
/#
	assert(self isusingremote());
#/
	return self.usingremote;
}

//Function Number: 151
isusingremote()
{
	return IsDefined(self.usingremote);
}

//Function Number: 152
getlastweapon()
{
	last_weapon = undefined;
	if(self hasweapon(self.lastnonkillstreakweapon))
	{
		last_weapon = self.lastnonkillstreakweapon;
	}
	else if(self hasweapon(self.lastdroppableweapon))
	{
		last_weapon = self.lastdroppableweapon;
	}

/#
	assert(IsDefined(last_weapon));
#/
	return last_weapon;
}

//Function Number: 153
freezecontrolswrapper(frozen)
{
	if(IsDefined(level.hostmigrationtimer))
	{
		self freeze_player_controls(1);
		return;
	}

	self freeze_player_controls(frozen);
}

//Function Number: 154
setobjectivetext(team,text)
{
	game["strings"]["objective_" + team] = text;
	precachestring(text);
}

//Function Number: 155
setobjectivescoretext(team,text)
{
	game["strings"]["objective_score_" + team] = text;
	precachestring(text);
}

//Function Number: 156
setobjectivehinttext(team,text)
{
	game["strings"]["objective_hint_" + team] = text;
	precachestring(text);
}

//Function Number: 157
getobjectivetext(team)
{
	return game["strings"]["objective_" + team];
}

//Function Number: 158
getobjectivescoretext(team)
{
	return game["strings"]["objective_score_" + team];
}

//Function Number: 159
getobjectivehinttext(team)
{
	return game["strings"]["objective_hint_" + team];
}

//Function Number: 160
registerroundswitch(minvalue,maxvalue)
{
	level.roundswitch = clamp(getgametypesetting("roundSwitch"),minvalue,maxvalue);
	level.roundswitchmin = minvalue;
	level.roundswitchmax = maxvalue;
}

//Function Number: 161
registerroundlimit(minvalue,maxvalue)
{
	level.roundlimit = clamp(getgametypesetting("roundLimit"),minvalue,maxvalue);
	level.roundlimitmin = minvalue;
	level.roundlimitmax = maxvalue;
}

//Function Number: 162
registerroundwinlimit(minvalue,maxvalue)
{
	level.roundwinlimit = clamp(getgametypesetting("roundWinLimit"),minvalue,maxvalue);
	level.roundwinlimitmin = minvalue;
	level.roundwinlimitmax = maxvalue;
}

//Function Number: 163
registerscorelimit(minvalue,maxvalue)
{
	level.scorelimit = clamp(getgametypesetting("scoreLimit"),minvalue,maxvalue);
	level.scorelimitmin = minvalue;
	level.scorelimitmax = maxvalue;
	setdvar("ui_scorelimit",level.scorelimit);
}

//Function Number: 164
registertimelimit(minvalue,maxvalue)
{
	level.timelimit = clamp(getgametypesetting("timeLimit"),minvalue,maxvalue);
	level.timelimitmin = minvalue;
	level.timelimitmax = maxvalue;
	setdvar("ui_timelimit",level.timelimit);
}

//Function Number: 165
registernumlives(minvalue,maxvalue)
{
	level.numlives = clamp(getgametypesetting("playerNumLives"),minvalue,maxvalue);
	level.numlivesmin = minvalue;
	level.numlivesmax = maxvalue;
}

//Function Number: 166
getplayerfromclientnum(clientnum)
{
	if(clientnum < 0)
	{
		return undefined;
	}

	for(i = 0;i < level.players.size;i++)
	{
		if(level.players[i] getentitynumber() == clientnum)
		{
			return level.players[i];
		}
	}

	return undefined;
}

//Function Number: 167
setclientfield(field_name,value)
{
	if(self == level)
	{
		codesetworldclientfield(field_name,value);
	}
	else
	{
		codesetclientfield(self,field_name,value);
	}
}

//Function Number: 168
setclientfieldtoplayer(field_name,value)
{
	codesetplayerstateclientfield(self,field_name,value);
}

//Function Number: 169
getclientfield(field_name)
{
	if(self == level)
	{
		return codegetworldclientfield(field_name);
	}
	else
	{
		return codegetclientfield(self,field_name);
	}
}

//Function Number: 170
getclientfieldtoplayer(field_name)
{
	return codegetplayerstateclientfield(self,field_name);
}

//Function Number: 171
isenemyplayer(player)
{
/#
	assert(IsDefined(player));
#/
	if(!(isplayer(player)))
	{
		return 0;
	}

	if(level.teambased)
	{
		if(player.team == self.team)
		{
			return 0;
		}
	}
	else if(player == self)
	{
		return 0;
	}
}

//Function Number: 172
getweaponclass(weapon)
{
/#
	assert(IsDefined(weapon));
#/
	if(!(IsDefined(weapon)))
	{
		return undefined;
	}

	if(!(IsDefined(level.weaponclassarray)))
	{
		level.weaponclassarray = [];
	}

	if(IsDefined(level.weaponclassarray[weapon]))
	{
		return level.weaponclassarray[weapon];
	}

	baseweaponindex = getbaseweaponitemindex(weapon) + 1;
	weaponclass = tablelookupcolumnforrow("mp/statstable.csv",baseweaponindex,2);
	level.weaponclassarray[weapon] = weaponclass;
	return weaponclass;
}

//Function Number: 173
ispressbuild()
{
	buildtype = GetDvar(#"19B966D7");
	if(IsDefined(buildtype) && buildtype == "press")
	{
		return 1;
	}

	return 0;
}

//Function Number: 174
isflashbanged()
{
	return IsDefined(self.flashendtime) && GetTime() < self.flashendtime;
}

//Function Number: 175
ishacked()
{
	return IsDefined(self.hacked) && self.hacked;
}

//Function Number: 176
domaxdamage(origin,attacker,inflictor,headshot,mod)
{
	if(IsDefined(self.damagedtodeath) && self.damagedtodeath)
	{
		return;
	}

	if(IsDefined(self.maxhealth))
	{
		damage = self.maxhealth + 1;
	}
	else
	{
		damage = self.health + 1;
	}

	self.damagedtodeath = 1;
	self dodamage(damage,origin,attacker,inflictor,headshot,mod);
}