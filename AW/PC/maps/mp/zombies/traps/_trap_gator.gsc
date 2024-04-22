/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_gator.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 257 ms
 * Timestamp: 4/22/2024 2:13:19 AM
*******************************************************************/

//Function Number: 1
trap_gator_enter(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	self.water_level = undefined;
	var_03 = common_scripts\utility::getstructarray(self.target,"targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.script_noteworthy))
		{
			continue;
		}

		if(var_05.script_noteworthy == "gator_enter")
		{
			var_01 = var_05;
		}

		if(var_05.script_noteworthy == "gator_water_level")
		{
			var_02 = var_05;
		}
	}

	self.water_level = var_02.origin[2];
	var_07 = (var_01.origin[0],var_01.origin[1],var_01.origin[2]);
	var_08 = spawn("script_model",var_07);
	var_08.angles = var_01.angles;
	var_08 setmodel("zom_king_croc_albino");
	if(isdefined(level.gator_kills_active) && level.gator_kills_active == 1)
	{
		var_08 thread trap_gator_gib_death();
		var_08 thread gator_collision_attach(param_00,0);
	}

	var_08 notsolid();
	var_08 playsoundonmovingent("gator_spawn_vox");
	var_08 scriptmodelplayanim("zom_alligator_trap_spawn");
	var_09 = var_02.origin;
	var_0A = (0,0,90);
	playfx(common_scripts\utility::getfx("trap_gator_enter_splash"),var_09,var_0A);
	playsoundatpos(var_09,"gator_spawn_splash");
	thread trap_gator_radius_damage(var_09);
	if(isdefined(self.usepitfallaudio) && self.usepitfallaudio == 1)
	{
		playsoundatpos(var_09,"ee_pitfall_swing");
	}

	earthquake(0.4,1,var_09,800);
	playrumbleonposition("artillery_rumble",var_09);
	wait(3);
	var_08 notify("delete");
	var_08 delete();
	var_08 thread gator_collision_reset(param_00);
	wait(randomfloatrange(3,5));
}

//Function Number: 2
trap_gator_trigger_watch(param_00,param_01)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	if(isdefined(param_01.gator_killed) && param_01.gator_killed)
	{
		self notify("deactivate");
	}

	self.gatorisattacking = 0;
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			continue;
		}
		else if(isdefined(var_02.inspawnanim) && var_02.inspawnanim == 1)
		{
			continue;
		}
		else if(isdefined(var_02.dismember_crawl) && var_02.dismember_crawl == 1)
		{
			continue;
		}
		else if(isdefined(var_02.agentteam) && var_02.agentteam == level.playerteam)
		{
			continue;
		}
		else if(var_02 maps\mp\zombies\_util::istrapresistant())
		{
			continue;
		}
		else if(var_02 isanyplayerinrange())
		{
			continue;
		}
		else if(self.gatorisattacking == 1)
		{
			continue;
		}
		else if(isdefined(var_02.gatorclaimed) && var_02.gatorclaimed == 1)
		{
			continue;
		}
		else
		{
			self.gatorisattacking = 1;
			var_02.gatorclaimed = 1;
			var_03 = trap_gator_spawn(var_02,param_01);
			trap_gator_attack(var_03,var_02,param_01);
			wait(randomfloatrange(3,5));
			self.gatorisattacking = 0;
		}
	}
}

//Function Number: 3
isanyplayerinrange()
{
	var_00 = 4096;
	foreach(var_02 in level.players)
	{
		if(distance2dsquared(self.origin,var_02.origin) < var_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
trap_gator_spawn(param_00,param_01)
{
	var_02 = (param_00.origin[0],param_00.origin[1],self.water_level - 28);
	var_03 = (0,randomfloat(360),0);
	var_04 = spawn("script_model",var_02);
	var_04.angles = var_03;
	var_04 setmodel("zom_king_croc_albino");
	if(isdefined(level.gator_kills_active) && level.gator_kills_active == 1)
	{
		var_04 thread trap_gator_gib_death();
		var_04 thread gator_collision_attach(param_01,1);
	}

	return var_04;
}

//Function Number: 5
gator_collision_attach(param_00,param_01)
{
	param_00.origin = self.origin;
	param_00.angles = self.angles + (0,90,0);
	param_00 linkto(self,"J_MainRoot");
	if(param_01)
	{
		var_02 = "J_Head";
		var_03 = self gettagorigin(var_02);
		var_04 = self gettagangles(var_02);
		var_05 = spawn("script_model",var_03);
		var_05.angles = var_04;
		var_05 setmodel("dlc2_zom_gib_arm_pickup");
		var_05 linkto(self,var_02,(14,-20,-7),(0,0,0));
		waittill_gator_death();
		var_05 delete();
	}
}

//Function Number: 6
gator_collision_reset(param_00)
{
	if(isdefined(param_00.start_origin) && isdefined(param_00.start_angles))
	{
		param_00.origin = param_00.start_origin;
		param_00.angles = param_00.start_angles;
	}
}

//Function Number: 7
waittill_gator_death()
{
	self endon("delete");
	level waittill("gator_killed");
}

//Function Number: 8
arm_debug_draw()
{
	self endon("delete");
	while(isdefined(self))
	{
		thread maps\mp\_utility::drawsphere(self.origin,16,1,(1,0,0));
		wait(0.1);
	}
}

//Function Number: 9
trap_gator_gib_death()
{
	self endon("delete");
	level endon("arm_spawned");
	if(isdefined(level.sqarmspawned))
	{
		return;
	}

	var_00 = spawn("script_origin",self.origin);
	var_00 linkto(self,"J_MainRoot");
	level waittill("gator_killed");
	self hide();
	playfx(common_scripts\utility::getfx("dlc_gator_death"),var_00.origin + (0,0,32));
	playsoundatpos(var_00.origin,"sq_gator_death");
	var_00 thread maps\mp\mp_zombie_brg_sq::stage13_spawn_arm();
}

//Function Number: 10
trap_gator_attack(param_00,param_01,param_02)
{
	var_03 = randomint(2);
	if(isdefined(param_01.agent_type) && param_01.agent_type == "zombie_dog")
	{
		var_04 = "tag_mouth_fx";
		var_05 = "spine4_jnt";
	}
	else
	{
		var_04 = "jaw_jnt";
		var_05 = "j_mainroot";
	}

	var_06 = "zom_alligator_trap_attack_0" + var_03 + 1;
	param_01 scragentsetscripted(1);
	param_01 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"SynchronizedAnim");
	param_01 scragentsetphysicsmode("noclip");
	thread playsplash(param_00,param_01);
	param_00 scriptmodelplayanim(var_06,"dummy");
	param_01 scragentsynchronizeanims(0.2,0.1,param_00,var_04,var_05);
	param_01 maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("alligator_trap_victim",var_03,"scripted_anim");
	param_01 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"SynchronizedAnim");
	if(isdefined(param_01))
	{
		var_07 = param_01.health * 10;
		if(isdefined(param_01.maxhealth))
		{
			var_07 = param_01.maxhealth * 10;
		}

		param_01 dodamage(var_07,param_00.origin,self.owner,self.owner,"MOD_EXPLOSIVE","trap_zm_mp");
	}

	wait(1);
	param_00 notify("delete");
	param_00 delete();
	param_00 thread gator_collision_reset(param_02);
}

//Function Number: 11
playsplash(param_00,param_01)
{
	level endon("gator_killed");
	var_02 = (param_00.origin[0],param_00.origin[1],self.water_level);
	var_03 = (0,0,90);
	wait(0.1);
	thread trap_gator_radius_damage(var_02);
	earthquake(0.3,0.75,var_02,400);
	playrumbleonposition("artillery_rumble",var_02);
	playfx(common_scripts\utility::getfx("trap_gator_emerge_splash"),var_02,var_03);
	param_00 playsoundonmovingent("gator_attack_vox");
	wait(0.2);
	if(isdefined(param_01) && isalive(param_01))
	{
		var_04 = param_01 gettagorigin("J_Spine4");
		if(isdefined(var_04))
		{
			playfx(common_scripts\utility::getfx("trap_gator_blood_splat"),var_04);
		}
	}

	wait(0.5);
	playfx(common_scripts\utility::getfx("trap_gator_attack_splash"),var_02,var_03);
}

//Function Number: 12
trap_gator_radius_damage(param_00)
{
	wait(0.05);
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_01 = sortbydistance(var_01,param_00,128);
	foreach(var_03 in var_01)
	{
		if(isplayer(var_03))
		{
			if(!maps\mp\zombies\_util::isplayerinlaststand(var_03))
			{
				var_03 thread trap_gator_push_players(param_00);
			}

			continue;
		}
		else if(isdefined(var_03.gatorclaimed) && var_03.gatorclaimed == 1)
		{
			continue;
		}
		else if(isdefined(var_03.agentteam) && var_03.agentteam == level.playerteam)
		{
			continue;
		}
		else if(var_03 maps\mp\zombies\_util::istrapresistant())
		{
			continue;
		}

		if(common_scripts\utility::cointoss())
		{
			var_04 = var_03.health * 10;
			if(isdefined(var_03.maxhealth))
			{
				var_04 = var_03.maxhealth * 10;
			}
		}
		else
		{
			var_04 = var_03.health * 0.5;
			if(isdefined(var_03.maxhealth))
			{
				var_04 = var_03.maxhealth * 0.5;
			}
		}

		var_03 dodamage(var_04,param_00,self.owner,self.owner,"MOD_EXPLOSIVE","trap_zm_mp");
	}
}

//Function Number: 13
trap_gator_push_players(param_00)
{
	wait 0.05;
	var_01 = vectornormalize(self.origin - param_00 * (1,1,0));
	self setvelocity(var_01 * 100);
}

//Function Number: 14
trap_gator_pitfall_audio()
{
	self.usepitfallaudio = 1;
	foreach(var_01 in level.players)
	{
		thread trap_gator_pitfall_player_audio(var_01,"exo_boost","ee_pitfall_jump");
		thread trap_gator_pitfall_player_audio(var_01,"begin_last_stand","ee_pitfall_downed");
		thread trap_gator_pitfall_player_audio(var_01,"death","ee_pitfall_death");
	}
}

//Function Number: 15
trap_gator_pitfall_player_audio(param_00,param_01,param_02)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	param_00 endon("disconnect");
	if(param_01 != "death")
	{
		param_00 endon("death");
	}

	for(;;)
	{
		param_00 waittill(param_01);
		param_00 playsoundonmovingent(param_02);
		if(param_01 == "death")
		{
			break;
		}
	}
}