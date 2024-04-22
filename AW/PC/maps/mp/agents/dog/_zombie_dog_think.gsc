/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_zombie_dog_think.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 166 ms
 * Timestamp: 4/22/2024 2:08:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	setupdogstate();
	thread think();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread waitforpathset();
}

//Function Number: 2
setupdogstate()
{
	self.attackoffset = 40 + self.radius;
	self.meleesectortype = "normal";
	self.meleesectorupdatetime = 50;
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.damagedradiussq = 2250000;
	self.ignoreclosefoliage = 1;
	self.moveratescale = 1;
	self.nonmoveratescale = 1;
	self.traverseratescale = 1;
	self.generalspeedratescale = 1;
	self.bhasbadpath = 0;
	self.bhasnopath = 0;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self.meleecheckheight = 30;
	self.meleeradiusbase = 80;
	self.meleeradiusbasesq = squared(self.meleeradiusbase);
	maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
	self.defaultgoalradius = self.radius + 5;
	self scragentsetgoalradius(self.defaultgoalradius);
	self.meleedot = 0.85;
	self.lastmeleefinishtime = 0;
	self.meleedebouncetime = 1;
	self.played_damage_for_threshold = [];
}

//Function Number: 3
init()
{
	self.animcbs = spawnstruct();
	self.animcbs.onenter = [];
	self.animcbs.onenter["idle"] = ::maps\mp\agents\dog\_zombie_dog_idle::main;
	self.animcbs.onenter["move"] = ::maps\mp\agents\dog\_zombie_dog_move::main;
	self.animcbs.onenter["traverse"] = ::maps\mp\agents\dog\_zombie_dog_traverse::main;
	self.animcbs.onenter["melee"] = ::maps\mp\agents\dog\_zombie_dog_melee::main;
	self.animcbs.onexit = [];
	self.animcbs.onexit["idle"] = ::maps\mp\agents\dog\_zombie_dog_idle::end_script;
	self.animcbs.onexit["move"] = ::maps\mp\agents\dog\_zombie_dog_move::end_script;
	self.animcbs.onexit["melee"] = ::maps\mp\agents\dog\_zombie_dog_melee::end_script;
	self.animcbs.onexit["traverse"] = ::maps\mp\agents\dog\_zombie_dog_traverse::end_script;
	self.animcbs.ondamage = [];
	self.animcbs.ondamage["move"] = ::maps\mp\agents\dog\_zombie_dog_move::ondamage;
	self.aistate = "idle";
	self.movemode = "run";
	self.radius = 18;
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
	{
		self.radius = 17;
	}

	self.height = 41;
}

//Function Number: 4
think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
	thread zombie_dog_moan();
	thread zombie_dog_audio_monitor();
	thread maps\mp\zombies\_zombies::updatebuffs();
	self.sharpturnnotifydist = 125;
	for(;;)
	{
		wait(0.05);
		if(maps\mp\zombies\_behavior::humanoid_begin_melee())
		{
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee())
		{
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known())
		{
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_random_loc())
		{
			continue;
		}
	}
}

//Function Number: 5
zombie_dog_moan()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		while(!isdefined(self.curmeleetarget))
		{
			wait(0.25);
		}

		while(isdefined(self.curmeleetarget) && distancesquared(self.origin,self.curmeleetarget.origin) > 40000)
		{
			wait(randomfloatrange(0,2));
			maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle",self.agent_type);
		}

		wait(0.05);
	}
}

//Function Number: 6
zombie_dog_audio_monitor()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_parms("attack_hit","attack_miss");
		switch(var_00[0])
		{
			case "attack_hit":
				var_01 = var_00[1];
				if(isdefined(var_01) && isplayer(var_01))
				{
					if(isalive(var_01))
					{
						var_01 playlocalsound("zmb_dog_bite_wound");
					}
					else
					{
						var_01 playsoundtoplayer("zmb_dog_bite_wound",var_01);
					}
				}
				break;
	
			case "attack_miss":
				maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack",self.agent_type);
				break;
		}
	}
}

//Function Number: 7
waitforpathset()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("path_set");
		self.bhasbadpath = 0;
	}
}

//Function Number: 8
ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self.timeoflastdamage = gettime();
	if(isdefined(self.owner))
	{
		self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
	}

	if(isdefined(self.animcbs.ondamage[self.aistate]) && shouldplaystophitreaction(param_02,param_05,param_04,param_08))
	{
		self [[ self.animcbs.ondamage[self.aistate] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
}

//Function Number: 9
shouldplaystophitreaction(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && maps\mp\zombies\_util::iszombiednagrenade(param_01))
	{
		return 0;
	}

	if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return 0;
	}

	if(isdefined(param_01) && param_01 == "zombie_water_trap_mp")
	{
		return 1;
	}

	var_04 = self.health - param_00;
	var_05 = [self.maxhealth * 0.6];
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		if(!isdefined(self.played_damage_for_threshold[var_06]) && var_04 < var_05[var_06])
		{
			self.played_damage_for_threshold[var_06] = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
monitorflash()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03,var_04,var_05);
		if(isdefined(var_03) && var_03 == self.owner)
		{
			continue;
		}

		if(!maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			maps\mp\agents\dog\_zombie_dog_move::onflashbanged();
		}
	}
}