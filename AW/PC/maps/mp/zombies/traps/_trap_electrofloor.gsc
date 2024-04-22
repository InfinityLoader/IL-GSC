/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_electrofloor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 124 ms
 * Timestamp: 4/22/2024 2:13:18 AM
*******************************************************************/

//Function Number: 1
trap_electrofloor_player_watch(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = 0;
	var_02 = 0.25;
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
			if(!var_05 istouching(param_00))
			{
				continue;
			}

			var_05 thread electrofloorplayer();
		}
	}
}

//Function Number: 2
trap_electrofloor_trigger_watch(param_00)
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

			if(isplayer(var_05))
			{
				continue;
			}

			if(isdefined(var_05.inspawnanim) && var_05.inspawnanim == 1)
			{
				continue;
			}

			if(!var_05 istouching(param_00))
			{
				continue;
			}

			var_05 maps\mp\zombies\_zombies::addbuff("electroBuff",var_05 getelectrobuff(self.owner));
		}
	}
}

//Function Number: 3
getelectrobuff(param_00)
{
	var_01 = maps\mp\zombies\_zombies::getbuff("electroBuff");
	if(!isdefined(var_01))
	{
		var_01 = spawnelectrobuff();
	}

	var_01.lifespan = 0.2;
	var_01.player = param_00;
	return var_01;
}

//Function Number: 4
spawnelectrobuff()
{
	var_00 = spawnstruct();
	var_00.buffremove = ::removeelectrobuff;
	var_00.lifespan = 0.2;
	var_00.damageperstep = 60 * maps\mp\zombies\_zombies::getbufftimestep();
	var_00.speedmultiplier = 0.6;
	self notify("speed_debuffs_changed");
	return var_00;
}

//Function Number: 5
updateelectrobuff(param_00)
{
	var_01 = param_00.player;
	if(isremovedentity(var_01))
	{
		var_01 = undefined;
	}

	self dodamage(param_00.damageperstep,self.origin,var_01,undefined,"MOD_TRIGGER_HURT","trap_zm_mp","none");
}

//Function Number: 6
removeelectrobuff(param_00)
{
	self notify("speed_debuffs_changed");
}

//Function Number: 7
electrofloorplayer()
{
	if(isplayer(self) && maps\mp\_utility::isreallyalive(self))
	{
		if(isdefined(self.exosuitonline) && self.exosuitonline)
		{
			thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
			playfx(level._effect["mut_emz_attack_sm"],self.origin);
			self playlocalsound("zmb_emz_impact");
		}
	}
}