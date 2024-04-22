/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators_acid.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 158 ms
 * Timestamp: 4/22/2024 2:13:45 AM
*******************************************************************/

//Function Number: 1
initacidmutator()
{
	level.activeacidzombies = 0;
	if(level.nextgen)
	{
		level.maxacidzombies = 4;
	}
	else
	{
		level.maxacidzombies = 2;
	}

	level._effect["mut_acid_pool"] = loadfx("vfx/blood/dlc_mutator_acid_pool_yllw_sm");
	level._effect["mut_acid_head"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
	level._effect["mut_acid_arm_l"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
	level._effect["mut_acid_arm_r"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
	level._effect["mut_acid_back"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
	level._effect["mut_acid_eye"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_acid");
	maps\mp\zombies\_mutators::addmutatortotable("acid",::mutatoracid,"zmb_mut_acid_spawn");
	maps\mp\zombies\_mutators::disablemutatorfortypes("acid",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
	precacheshader("screen_blood_directional_center_yellow");
	precacheshader("screen_blood_directional_right_yellow");
	precacheshader("screen_blood_directional_left_yellow");
	level.acidscreenoverlayshaders = ["center","right","left"];
}

//Function Number: 2
mutatoracid()
{
	level.activeacidzombies++;
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	thread maps\mp\zombies\_mutators::mutatorspawnsound("acid");
	self.acidpools = 0;
	maps\mp\zombies\_util::zombie_set_eyes("mut_acid_eye");
	maps\mp\zombies\_mutators::torso_effects_apply("mut_acid");
	self playloopsound("zmb_mut_acid_drip_loop");
	thread mutatoraciddotzonespawner();
	self waittill("death");
	level.activeacidzombies--;
}

//Function Number: 3
mutatoraciddotzonespawner()
{
	self endon("death");
	for(;;)
	{
		wait(randomfloatrange(1.5,2));
		if(self.aistate == "traverse" || !isdefined(self.ismoving) || isdefined(self.inwater) && self.acidpools < 10)
		{
			continue;
		}

		var_00 = bullettrace(self.origin,self.origin - (0,0,32),0,self);
		if(!isdefined(var_00["normal"]))
		{
			continue;
		}

		if(common_scripts\utility::cointoss())
		{
			continue;
		}

		self.acidpools++;
		var_01 = spawn("script_model",var_00["position"] + (0,0,8));
		var_01 setmodel("tag_origin");
		var_01.angles = vectortoangles(var_00["normal"]);
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("mut_acid_pool"),var_01,"tag_origin");
		if(level.nextgen)
		{
			var_02 = spawn("trigger_radius",var_00["position"],0,48,16);
			thread mutatoracidtriggerthink(var_02);
			thread mutatoracidzonecleanup(var_02,var_01);
			level notify("acid_zone_created",var_02);
			continue;
		}

		thread mutatoracidtriggerthink_cg(var_00["position"]);
		thread mutatoracidzonecleanup_cg(var_01);
		level notify("acid_zone_created",var_00["position"]);
	}
}

//Function Number: 4
mutatoracidtriggerthink(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isplayer(var_01) && !maps\mp\zombies\_util::isplayerinlaststand(var_01))
		{
			var_01 thread mutatoracidplayereffects();
			var_01 dodamage(clamp(20 * level.wavecounter / 6,20,60),var_01.origin);
			var_01 playlocalsound("zmb_mut_acid_damage");
			wait(1);
		}
	}
}

//Function Number: 5
mutatoracidtriggerthink_cg(param_00)
{
	var_01 = 0;
	for(;;)
	{
		if(var_01 >= 15)
		{
			return;
		}

		foreach(var_03 in level.players)
		{
			if(!maps\mp\zombies\_util::isplayerinlaststand(var_03) && distance(var_03.origin,param_00) < 48)
			{
				var_03 thread mutatoracidplayereffects();
				var_03 dodamage(clamp(20 * level.wavecounter / 6,20,60),var_03.origin);
				var_03 playlocalsound("zmb_mut_acid_damage");
				var_01 = var_01 + 0.8;
				wait(0.8);
				break;
			}
		}

		var_01 = var_01 + 0.2;
		wait(0.2);
	}
}

//Function Number: 6
mutatoracidplayereffects()
{
	self endon("death");
	self notify("remove_acid_debuff");
	self endon("remove_acid_debuff");
	self allowsprint(0);
	foreach(var_01 in level.acidscreenoverlayshaders)
	{
		thread mutatoracidoverlay(var_01);
	}

	wait(1.25);
	if(!maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		self allowsprint(1);
	}

	self notify("remove_acid_overlay");
}

//Function Number: 7
mutatoracidzonecleanup(param_00,param_01)
{
	wait(15);
	if(isdefined(self) && isalive(self) && isdefined(self.acidpools))
	{
		self.acidpools--;
	}

	param_00 delete();
	param_01 delete();
}

//Function Number: 8
mutatoracidzonecleanup_cg(param_00)
{
	wait(15);
	if(isdefined(self) && isalive(self) && isdefined(self.acidpools))
	{
		self.acidpools--;
	}

	param_00 delete();
}

//Function Number: 9
mutatoracidoverlay(param_00)
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
	self waittill("remove_acid_overlay");
	_fadehudalpha(var_01,0,1);
	wait(1);
	var_01 destroy();
}

//Function Number: 10
_fadehudalpha(param_00,param_01,param_02)
{
	param_00 fadeovertime(param_02);
	param_00.alpha = param_01;
}