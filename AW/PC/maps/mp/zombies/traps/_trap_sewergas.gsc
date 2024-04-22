/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_sewergas.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 144 ms
 * Timestamp: 4/22/2024 2:13:19 AM
*******************************************************************/

//Function Number: 1
trap_sewergas_player_watch(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = 0;
	var_02 = 0.15;
	if(isdefined(self.script_duration))
	{
		var_03 = self.script_duration;
	}
	else
	{
		var_03 = 20;
	}

	while(var_01 < var_03)
	{
		wait(var_02);
		var_01 = var_01 + var_02;
		foreach(var_05 in level.players)
		{
			if(!isalive(var_05))
			{
				continue;
			}

			if(!var_05 istouching(param_00))
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerinlaststand(var_05))
			{
				continue;
			}

			if(!isplayercamouflaged(var_05))
			{
				var_05 thread playersewergascamo();
			}
		}
	}
}

//Function Number: 2
isplayercamouflaged(param_00)
{
	return isdefined(param_00.ignoreme) && param_00.ignoreme;
}

//Function Number: 3
trap_sewergas_trigger_watch(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = 0;
	var_02 = 0.15;
	if(isdefined(self.script_duration))
	{
		var_03 = self.script_duration;
	}
	else
	{
		var_03 = 20;
	}

	while(var_01 < var_03)
	{
		wait(var_02);
		var_01 = var_01 + var_02;
		if(!isdefined(level.agentarray))
		{
			continue;
		}

		foreach(var_05 in level.agentarray)
		{
			if(!isdefined(var_05) || !isalive(var_05))
			{
				continue;
			}

			if(!var_05 istouching(param_00))
			{
				continue;
			}

			if(isplayer(var_05))
			{
				continue;
			}

			if(isdefined(var_05.inspawnanim) && var_05.inspawnanim == 1)
			{
				continue;
			}

			if(isdefined(var_05.agentteam) && var_05.agentteam == level.playerteam)
			{
				if(!isdefined(var_05.civiscamouflaged))
				{
					var_05 thread sewergasciv();
				}

				continue;
			}

			if(!isdefined(var_05.zomisconfused))
			{
				var_05 thread sewergaszombie();
			}
		}
	}
}

//Function Number: 4
sewergaszombie()
{
	self endon("death");
	if(!threatbiasgroupexists("zombie_confused"))
	{
		createthreatbiasgroup("zombie_confused");
		setthreatbias("zombies","zombie_confused",1000);
		setthreatbias("zombie_confused","zombies",1000);
	}

	self.zomisconfused = 1;
	if(maps\mp\zombies\_util::istrapresistant() || isdefined(self.agent_type) && self.agent_type == "zombie_host")
	{
		return;
	}

	if(common_scripts\utility::cointoss())
	{
		self setthreatbiasgroup("zombie_confused");
		maps\mp\agents\_agent_utility::set_agent_team(level.playerteam);
		thread sewergaszombiecleanup();
	}
}

//Function Number: 5
sewergaszombiecleanup()
{
	self endon("death");
	level endon("game_ended");
	var_00 = randomfloatrange(1,2);
	var_01 = 10 * var_00;
	wait(var_01);
	self setthreatbiasgroup("zombies");
	maps\mp\agents\_agent_utility::set_agent_team(level.enemyteam);
}

//Function Number: 6
sewergasciv()
{
	self endon("death");
	level endon("game_ended");
	self.civiscamouflaged = 1;
	self.ignoreme = 1;
	var_00 = randomfloatrange(1,2);
	wait(10 * var_00);
	self.civiscamouflaged = undefined;
	self.ignoreme = 0;
}

//Function Number: 7
playersewergascamo()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(10);
	self allowsprint(0);
	var_00 = ["center","right","left"];
	foreach(var_02 in var_00)
	{
		thread sewergasoverlay(var_02);
	}

	wait(1);
	if(!maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		self allowsprint(1);
	}

	wait(2);
	self notify("remove_gas_overlay");
}

//Function Number: 8
sewergasoverlay(param_00)
{
	var_01 = newclienthudelem(self);
	var_01.x = 0;
	var_01.y = 0;
	var_01.alignx = "left";
	var_01.aligny = "top";
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("screen_blood_directional_" + param_00 + "_yellow",640,480);
	var_01.sort = -10;
	var_01.archived = 1;
	var_01.hidein3rdperson = 1;
	var_01.alpha = 0;
	_fadehudalpha(var_01,1,1);
	self waittill("remove_gas_overlay");
	_fadehudalpha(var_01,0,1);
	wait(1);
	var_01 destroy();
}

//Function Number: 9
_fadehudalpha(param_00,param_01,param_02)
{
	param_00 fadeovertime(param_02);
	param_00.alpha = param_01;
}