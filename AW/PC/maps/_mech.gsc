/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _mech.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 70
 * Decompile Time: 1037 ms
 * Timestamp: 4/22/2024 2:21:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.mech_initialized))
	{
		return;
	}

	level.mech_initialized = 1;
	level._mech_globals = spawnstruct();
	level._mech_globals.num_missile_attractors = 0;
	level._mech_globals.num_missile_repulsors = 0;
	if(!isdefined(level.subclass_spawn_functions))
	{
		level.subclass_spawn_functions = [];
	}

	level.subclass_spawn_functions["mech"] = ::subclass_mech;
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\_mech_aud::main();
	}

	precacheitem("mech_rocket");
	precacheitem("mech_rocket_deploy");
	precachemodel("npc_exo_armor_minigun_whole");
	precachemodel("npc_exo_armor_minigun_barrel");
	precachemodel("npc_exo_armor_minigun_handle");
	level.mech_fx["rocket_muzzle_flash"] = loadfx("vfx/muzzleflash/exo_armor_rocket_flash_wv");
	level.mech_fx["rocket_seperation"] = loadfx("vfx/muzzleflash/exo_armor_rocket_burst");
	level.mech_fx["bullet_hit_sparks"] = loadfx("vfx/weaponimpact/metal_spark_fountain_small");
	level.mech_fx["bullet_hit_sparks_large"] = loadfx("vfx/weaponimpact/metal_spark_fountain_large");
	level.mech_fx["rocket_trail_0"] = loadfx("vfx/trail/exo_armor_rocket_trail_a");
	level.mech_fx["rocket_trail_1"] = loadfx("vfx/trail/exo_armor_rocket_trail_b");
	level.mech_fx["rocket_trail_2"] = loadfx("vfx/trail/exo_armor_rocket_trail_c");
}

//Function Number: 2
subclass_mech()
{
	init_mech_animsets();
	self.mech = 1;
	self.rocketpodup = 0;
	self.emp = 0;
	self.targetattacker = 0;
	self.mechpainbuildup = 1;
	self.paindamagestart = 200;
	self.paindamagemin = 100;
	self.paindamageincrement = 4;
	self.paindamageincrementback = 1;
	self.paindamagetime = 0.2;
	self.animarchetype = "mech";
	self.script_animation = "mech";
	if(animscripts\utility::aihasweapon("exo_minigun"))
	{
		self attach("npc_exo_armor_minigun_barrel","TAG_BARREL");
		self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
		self setanim(%s1_mechgun,1,1,1);
	}

	if(animscripts\utility::aihasweapon("exo_minigun_scaled"))
	{
		self attach("npc_exo_armor_minigun_barrel","TAG_BARREL");
		self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
		self setanim(%s1_mechgun,1,1,1);
	}

	level.scr_anim["generic"]["patrol_idle_mech"] = %mech_unaware_idle;
	level.scr_anim["generic"]["patrol_walk_mech"] = %mech_unaware_walk;
	level.scr_anim["generic"]["patrol_stop_mech"] = %mech_unaware_walk_stop;
	level.scr_anim["generic"]["patrol_start_mech"] = %mech_unaware_walk_start;
	level.scr_anim["generic"]["patrol_walk_weights"] = %mech_unaware_walk;
	self allowedstances("stand");
	self.maxhealth = self.health;
	self.minpaindamage = 100;
	self.walkdist = 500;
	self.walkdistfacingmotion = self.walkdist;
	self.grenadeammo = 0;
	self.doorflashchance = 0.05;
	self.aggressivemode = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.norunngun = 1;
	self.disablebulletwhizbyreaction = 1;
	self.combatmode = "no_cover";
	self.neversprintforvariation = 1;
	self.noturnanims = undefined;
	self.canclimbladders = 0;
	self.flashbangimmunity = 1;
	self.var_849D = 0;
	self.noruntwitch = 1;
	self.usemuzzleforaim = 1;
	self.bdisabledefaultfacialanims = 1;
	self.aimfaryawtolerance = 20;
	self.disablereactionanims = 1;
	self.dontmelee = 1;
	self.meleechargedistsq = 9216;
	self actorusemodelcollisionbounds();
	self.standingturnrate = 0.2;
	self.walkingturnrate = 0.07;
	self.runingturnrate = 0.5;
	self.standingaimblendtime = 0.2;
	self.walkingaimblendtime = 0.6;
	self.runningaimblendtime = 0.4;
	self.aimsetupblendtime = 2;
	self.standingmechblendtime = 1.5;
	self.walkingmechblendtime = 1.5;
	self.runningmechblendtime = 0.2;
	self.standingaimlimits = [-25,35,45,-45];
	self.walkingaimlimits = [-25,35,45,-45];
	self.runningaimlimits = [-25,35,45,-45];
	if(!isdefined(self.attractornumber))
	{
		self.attractornumber = 6;
	}

	if(!isdefined(self.repulsornumber))
	{
		self.repulsornumber = 3;
	}

	self.largesparkdistance = 600;
	self setstompbreakthrough(0);
	self.scriptedarrivalententity = common_scripts\utility::spawn_tag_origin();
	self.scriptedarrivalententity.type = "scripted_arrival_ent";
	self.scriptedarrivalententity.arrivalstance = "stand";
	thread common_scripts\utility::delete_on_death(self.scriptedarrivalententity);
	maps\_utility::disable_surprise();
	maps\_utility::disable_danger_react();
	self.grenadeawareness = 0;
	self.norunreload = 1;
	maps\_utility::add_damage_function(::animscripts\pain::additive_pain);
	maps\_utility::add_damage_function(::maps\_spawner::pain_resistance);
	maps\_utility::add_damage_function(::mech_hit_vfx);
	maps\_utility::add_damage_function(::mech_pain_adder);
	maps\_utility::add_damage_function(::mech_incoming_damage_modifiers);
	thread maps\_shg_utility::make_emp_vulnerable();
	self.emp_death_function = ::mech_emp_function;
	thread mech_wait_for_drop();
	thread mech_minigun_loop();
	thread mech_melee_behavior();
	thread mech_turn_loop();
	thread mech_pain_loop();
	if(isdefined(level.mech_grapple_setup_function))
	{
		[[ level.mech_grapple_setup_function ]](self);
	}

	if(!self isbadguy())
	{
		return;
	}

	self.bullet_resistance = 40;
	maps\_utility::add_damage_function(::maps\_spawner::bullet_resistance);
	maps\_utility::add_damage_function(::mech_target_attacker);
	self.pathenemyfightdist = 64;
	self.pathenemylookahead = 128;
	level notify("mech_spawned");
	self waittill("death",var_00,var_01,var_02);
	mech_death_function();
	if(isdefined(self) && isdefined(self.nodrop))
	{
		var_03 = [];
		var_03[var_03.size] = "left";
		var_03[var_03.size] = "right";
		var_03[var_03.size] = "chest";
		var_03[var_03.size] = "back";
		animscripts\shared::detachallweaponmodels();
		foreach(var_05 in var_03)
		{
			var_02 = self.a.weaponpos[var_05];
			if(var_02 == "none")
			{
				continue;
			}

			self.weaponinfo[var_02].position = "none";
			self.a.weaponpos[var_05] = "none";
		}

		self.weapon = "none";
		animscripts\shared::updateattachedweaponmodels();
	}

	level notify("mech_died");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(!isplayer(var_00))
	{
	}
}

//Function Number: 3
mech_set_goal_node(param_00)
{
	self setgoalnode(param_00);
	self.scriptedarrivalententity.origin = param_00.origin;
	self.scriptedarrivalententity.angles = param_00.angles;
	self.scriptedarrivalent = self.scriptedarrivalententity;
}

//Function Number: 4
process_melee_notetracks()
{
	self endon("death");
	self endon("melee_complete");
	for(;;)
	{
		self waittill("meleeAnim",var_00);
		if(!isdefined(var_00))
		{
			var_00 = "undefined";
		}

		if(var_00 == "fire")
		{
			if(isdefined(self.enemy))
			{
				var_01 = self melee();
				if(isai(var_01))
				{
					var_01 dodamage(999999999,self.origin,self,self,"MOD_MELEE");
				}
			}

			continue;
		}

		if(var_00 == "end" || var_00 == "stop")
		{
			return;
		}
		else
		{
			animscripts\notetracks::handlenotetrack(var_00,"meleeAnim");
		}
	}
}

//Function Number: 5
mech_do_melee()
{
	self animmode("zonly_physics");
	var_00 = vectortoyaw(self.enemy.origin - self.origin);
	var_01 = angleclamp180(self.angles[1] - var_00);
	if(var_01 < -90)
	{
		var_02 = self.origin + self.origin - self.enemy.origin;
		self orientmode("face point",var_02);
		var_03 = %mech_stand_melee_left;
	}
	else if(var_03 > 90)
	{
		var_02 = self.origin + self.origin - self.enemy.origin;
		self orientmode("face point",var_02);
		var_03 = %mech_stand_melee_right;
	}
	else
	{
		self orientmode("face point",self.enemy.origin);
		var_03 = %mech_stand_melee_front;
	}

	self setflaggedanimknoballrestart("meleeAnim",var_03,%body,1,0.5,1);
	var_04 = getanimlength(var_03);
	thread process_melee_notetracks();
	thread kill_clipping_enemy();
	wait(var_04);
	self notify("stop_kill_clipping_enemy");
}

//Function Number: 6
kill_clipping_enemy()
{
	self endon("stop_kill_clipping_enemy");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.enemy) && distance(self.origin,self.enemy.origin) < 32 && !isplayer(self.enemy))
		{
			self.enemy dodamage(999999999,self.origin,self,self,"MOD_MELEE");
		}

		wait 0.05;
	}
}

//Function Number: 7
mech_melee_endscript()
{
	self animmode("none");
	self clearanim(%body,0.2);
	self.a.movement = "stop";
	self orientmode("face default");
	var_00 = self getdroptofloorposition();
	if(isdefined(var_00))
	{
		self forceteleport(var_00,self.angles);
	}
	else
	{
	}

	self notify("melee_complete");
}

//Function Number: 8
mech_death_function()
{
	if(isdefined(self) && isdefined(self.mech) && self.mech)
	{
		self hidepart("TAG_BARREL","npc_exo_armor_minigun_barrel");
		self hidepart("TAG_HANDLE","npc_exo_armor_minigun_handle");
		self detach("npc_exo_armor_minigun_barrel","TAG_BARREL");
		self detach("npc_exo_armor_minigun_handle","TAG_HANDLE");
	}
}

//Function Number: 9
mech_minigun_loop()
{
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		if(animscripts\utility::isincombat() && !var_00)
		{
			var_00 = 1;
		}

		if(!animscripts\utility::isincombat() && var_00)
		{
			var_00 = 0;
		}

		wait(0.25);
	}
}

//Function Number: 10
mech_pain_loop()
{
	self endon("death");
	if(!isdefined(self.mechpainbuildup) || isdefined(self.mechpainbuildup) && !self.mechpainbuildup)
	{
		return;
	}

	if(isdefined(self.paindamagestart))
	{
		self.minpaindamage = self.paindamagestart;
	}

	for(;;)
	{
		if(self.minpaindamage < self.paindamagestart)
		{
			self.minpaindamage = self.minpaindamage + self.paindamageincrementback;
		}

		if(isdefined(self.mechpainbuildup) && !self.mechpainbuildup)
		{
			break;
		}

		if(isdefined(self.paindamagetime) && self.paindamagetime > 0)
		{
			wait(self.paindamagetime);
			continue;
		}

		wait(0.2);
	}
}

//Function Number: 11
mech_pain_adder(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(self.mechpainbuildup) && self.mechpainbuildup && param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET" && param_01 == level.player)
	{
		if(self.minpaindamage > self.paindamagemin)
		{
			self.minpaindamage = self.minpaindamage - self.paindamageincrement;
		}
	}
}

//Function Number: 12
mech_incoming_damage_modifiers(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	if(isdefined(self.bullet_resistance))
	{
		var_07 = self.bullet_resistance;
	}

	if(isdefined(self.reduced_nonplayer_damage) && self.reduced_nonplayer_damage > 0 && param_01 != level.player)
	{
		if(self.health > 0 && param_00 > var_07)
		{
			self.health = self.health + int(param_00 - var_07 * self.reduced_nonplayer_damage);
			return;
		}

		return;
	}

	if(self.damagelocation == "head")
	{
		if(self.health > 0)
		{
			self.health = self.health + int(param_00 - var_07 * 0.25);
			return;
		}
	}
}

//Function Number: 13
is_doing_scripted_anim()
{
	return isdefined(self.script) && self.script == "scripted";
}

//Function Number: 14
mech_turn_loop()
{
	self endon("stop_mech_turn_loop");
	var_00 = (1,0,0);
	var_01 = self.movemode;
	var_02 = animscripts\utility::isincombat();
	for(;;)
	{
		if(!isremovedentity(self) && isdefined(self))
		{
			if((isdefined(self.script) && self.script == "death") || !isalive(self))
			{
				self setanim(%idle_combat,0,1,1,1);
				self setanimlimited(%mech_combat_idle,0,0.2,1);
				break;
			}
		}
		else
		{
			break;
		}

		if(is_doing_scripted_anim())
		{
		}
		else if(self.movemode == "stop" || self.movemode == "stop soon" && isdefined(self.standingturnrate))
		{
			self.turnrate = self.standingturnrate;
			self.aimblendtime = self.standingaimblendtime;
			self.strafeblendtimes = self.standingmechblendtime;
			self.leftaimlimit = self.standingaimlimits[0];
			self.rightaimlimit = self.standingaimlimits[1];
			self.upaimlimit = self.standingaimlimits[2];
			self.downaimlimit = self.standingaimlimits[3];
		}
		else if(self.movemode == "walk" && isdefined(self.walkingturnrate))
		{
			self.turnrate = self.walkingturnrate;
			self.aimblendtime = self.walkingaimblendtime;
			self.strafeblendtimes = self.walkingmechblendtime;
			self.leftaimlimit = self.walkingaimlimits[0];
			self.rightaimlimit = self.walkingaimlimits[1];
			self.upaimlimit = self.walkingaimlimits[2];
			self.downaimlimit = self.walkingaimlimits[3];
		}
		else if(self.movemode == "run" && isdefined(self.runingturnrate))
		{
			self.turnrate = self.runingturnrate;
			self.aimblendtime = self.runningaimblendtime;
			self.strafeblendtimes = self.runningmechblendtime;
			self.leftaimlimit = self.runningaimlimits[0];
			self.rightaimlimit = self.runningaimlimits[1];
			self.upaimlimit = self.runningaimlimits[2];
			self.downaimlimit = self.runningaimlimits[3];
		}
		else
		{
		}

		if(var_02 != animscripts\utility::isincombat() || self.movemode != var_01)
		{
			if(self.movemode == "stop" && animscripts\utility::isincombat() && self.script != "scripted")
			{
				self setanim(%idle_combat,1,1,1,1);
				self setanimlimited(%mech_combat_idle,0.5,0.2,1);
			}
			else
			{
				self setanim(%idle_combat,0,1,1,1);
				self setanimlimited(%mech_combat_idle,0,0.2,1);
			}

			var_02 = animscripts\utility::isincombat();
			var_01 = self.movemode;
		}

		wait(0.05);
	}
}

//Function Number: 15
mech_wait_for_drop()
{
	self endon("wait_drop_end");
	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00) && var_00.classname == "weapon_exo_minigun")
	{
		var_00 setmodel("npc_exo_armor_minigun_whole");
		var_00 makeunusable();
	}
}

//Function Number: 16
mech_hit_vfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
	{
		if(isplayer(param_01) && isdefined(self.largesparkdistance) && common_scripts\utility::distance_2d_squared(self.origin,param_01.origin) > self.largesparkdistance * self.largesparkdistance)
		{
			playfx(level.mech_fx["bullet_hit_sparks_large"],param_03,param_02 * -1,(0,0,1));
			return;
		}

		playfx(level.mech_fx["bullet_hit_sparks"],param_03,param_02 * -1,(0,0,1));
	}
}

//Function Number: 17
mech_bullet_ricochet(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	param_01 = vectornormalize(param_01);
	var_03 = -2 * vectordot(param_01,var_02) * var_02 + param_01;
	playfx(level.mech_fx["bullet_ricochet"],param_00,var_03,(0,0,1));
}

//Function Number: 18
mech_vfx_loop()
{
	self endon("death");
	for(;;)
	{
		if(self.health < self.maxhealth / 2)
		{
			if(self gettagindex("tag_vfx_chest_light") != -1)
			{
			}
			else
			{
			}

			break;
		}

		wait(0.5);
	}

	for(;;)
	{
		if(self.health < self.maxhealth / 4)
		{
			if(self gettagindex("tag_vfx_chest_light") != -1)
			{
			}
			else
			{
			}

			break;
		}

		wait(0.5);
	}
}

//Function Number: 19
mech_is_shooting_rockets()
{
	if(isdefined(self.isshootingrockets) && self.isshootingrockets)
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
mech_start_target_attacker()
{
	self.targetattacker = 1;
}

//Function Number: 21
mech_stop_target_attacker()
{
	self.targetattacker = 0;
}

//Function Number: 22
mech_start_rockets(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	thread mech_rocket_launcher_behavior(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 23
mech_stop_rockets()
{
	self notify("stop_stop_rocket_launcher");
}

//Function Number: 24
mech_start_hunting()
{
	thread mech_hunt_immediately_behavior();
}

//Function Number: 25
mech_stop_hunting()
{
	self notify("stop_hunting");
}

//Function Number: 26
mech_badplace_behavior()
{
	self endon("death");
	self endon("stop_badplace_behavior");
	var_00 = 1;
	var_01 = 240;
	var_02 = 120;
	var_03 = "mech_bad_place" + self getentitynumber();
	for(;;)
	{
		badplace_cylinder(var_03,var_00 - 0.05,self.origin,var_01,var_02,"allies");
		wait(var_00);
	}
}

//Function Number: 27
mech_start_badplace_behavior()
{
	thread mech_badplace_behavior();
}

//Function Number: 28
mech_stop_badplace_behavior()
{
	self notify("stop_badplace_behavior");
}

//Function Number: 29
mech_start_generic_attacking()
{
	thread mech_generic_attacking_behavior();
}

//Function Number: 30
mech_stop_generic_attacking()
{
	self notify("stop_generic_attacking");
}

//Function Number: 31
mech_start_reduced_nonplayer_damage(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.9;
	}

	self.reduced_nonplayer_damage = param_00;
}

//Function Number: 32
mech_stop_reduced_nonplayer_damage()
{
	self.reduced_nonplayer_damage = undefined;
}

//Function Number: 33
mech_melee_is_valid()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) > self.meleechargedistsq)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(isdefined(self.emp) && self.emp)
	{
		return 0;
	}

	if(!isalive(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.enemy.dontattackme) || isdefined(self.enemy.ignoreme) && self.enemy.ignoreme)
	{
		return 0;
	}

	if(isai(self.enemy))
	{
		if(self.enemy isinscriptedstate())
		{
			return 0;
		}

		if(self.enemy maps\_utility::doinglongdeath() || self.enemy.delayeddeath)
		{
			return 0;
		}
	}

	if(!mech_melee_trace_passed(self.enemy))
	{
		return 0;
	}

	return 1;
}

//Function Number: 34
mech_melee_trace_passed(param_00)
{
	var_01 = param_00.origin - self.origin;
	var_02 = vectortoangles(var_01);
	var_03 = anglestoforward(var_02);
	var_04 = anglestoright(var_02);
	var_05 = anglestoup(var_02);
	foreach(var_07 in [10,80])
	{
		foreach(var_09 in [-20,0,20])
		{
			var_0A = self.origin - 10 * var_03 + var_09 * var_04 + var_07 * var_05;
			var_0B = param_00.origin - 10 * var_03 + var_09 * var_04 + var_07 * var_05;
			var_0C = sighttracepassed(var_0A,var_0B,0,self);
			if(!var_0C)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 35
mech_melee_behavior()
{
	self endon("death");
	var_00 = 0.05;
	for(;;)
	{
		if(mech_melee_is_valid())
		{
			self animcustom(::mech_do_melee,::mech_melee_endscript);
			self waittill("melee_complete");
		}

		wait(var_00);
	}
}

//Function Number: 36
mech_rocket_launcher_behavior(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self endon("stop_rocket_launcher");
	var_07 = 0.25;
	self.isshootingrockets = 1;
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	if(!isdefined(param_01))
	{
		param_01 = 2048;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 3;
	}

	if(!isdefined(param_04))
	{
		param_04 = 50;
	}

	if(!isdefined(param_05))
	{
		param_05 = 4;
	}

	if(!isdefined(param_06))
	{
		param_06 = 117;
	}

	var_08 = param_00 * param_00;
	var_09 = param_01 * param_01;
	for(;;)
	{
		if(!isdefined(self.enemy) || !self canshootenemy())
		{
			wait(var_07);
			continue;
		}

		if(isdefined(self.underwater) && self.underwater)
		{
			wait(var_07);
			continue;
		}

		if(getdvar("debug_mech_rocket") == "on")
		{
			self.mechrocketdebug = 1;
		}
		else
		{
			self.mechrocketdebug = 0;
		}

		var_0A = self gettagorigin("tag_eye");
		var_0B = self.enemy getshootatpos() - var_0A;
		var_0C = vectornormalize(anglestoforward(self gettagangles("tag_eye")));
		var_0D = vectornormalize(var_0B);
		var_0E = vectordot(var_0C,var_0D);
		if(var_0E < param_02)
		{
			wait(var_07);
			continue;
		}

		if((isdefined(self.emp) && self.emp) || animscripts\utility::isdoingpain())
		{
			wait(var_07);
			continue;
		}

		if(isdefined(self.team) && self.team == "allies")
		{
			var_10 = pointonsegmentnearesttopoint(self.enemy getshootatpos(),var_0A,level.player.origin);
			if(distance(level.player.origin,var_10) < param_06)
			{
				wait(var_07);
				continue;
			}
		}

		var_11 = distancesquared(self.origin,self.enemy.origin);
		if(var_11 >= var_08 && var_11 <= var_09)
		{
			if(!isdefined(self.rocketpodup) || !self.rocketpodup)
			{
				mech_raise_rocket_pod(1);
			}

			thread mech_random_missile_attractors(self.enemy);
			var_12 = 0;
			while(var_12 < param_03)
			{
				mech_fire_rockets();
				var_12++;
				wait(0.5);
				if((isdefined(self.emp) && self.emp) || animscripts\utility::isdoingpain())
				{
					break;
				}
			}

			thread mech_random_missile_attractor_cleanup(1);
			if((isdefined(self.emp) && self.emp) || animscripts\utility::isdoingpain())
			{
				mech_lower_rocket_pod(1);
			}
			else if(randomfloatrange(0,100) < param_04)
			{
				mech_lower_rocket_pod(1);
			}

			wait(0.5 * param_05 + randomfloatrange(0,param_05));
		}

		wait(var_07);
	}

	self.isshootingrockets = 0;
}

//Function Number: 37
mech_random_missile_attractors(param_00)
{
	if(!isdefined(self.attractornumber))
	{
		self.attractornumber = 6;
	}

	if(!isdefined(self.repulsornumber))
	{
		self.repulsornumber = 3;
	}

	var_01 = 130;
	var_02 = 130;
	var_03 = 200;
	var_04 = mech_precise_target_position(self,param_00);
	var_05 = var_04 + self.origin / 2;
	var_06 = 1500;
	var_07 = 2000;
	var_08 = 3000;
	var_09 = 128;
	var_0A = 256;
	var_0B = 1200;
	self.mechmissileattractors = [];
	self.mechmissilerepulsors = [];
	if(level._mech_globals.num_missile_attractors + self.attractornumber <= 10)
	{
		for(var_0C = 0;var_0C < self.attractornumber;var_0C++)
		{
			var_0D = randomintrange(-1 * var_01,var_01);
			var_0E = randomintrange(-1 * var_02,var_02);
			var_0F = randomintrange(0,var_03);
			var_10 = var_05 + (var_0D,var_0E,var_0F);
			self.mechmissileattractors[var_0C] = missile_createattractororigin(var_10,var_07,var_0A);
			level._mech_globals.num_missile_attractors++;
		}
	}

	if(level._mech_globals.num_missile_repulsors + self.repulsornumber <= 10)
	{
		for(var_0C = 0;var_0C < self.repulsornumber;var_0C++)
		{
			var_0D = randomintrange(-1 * var_01,var_01);
			var_0E = randomintrange(-1 * var_02,var_02);
			var_0F = randomintrange(0,var_03);
			var_10 = var_05 + (var_0D,var_0E,var_0F);
			self.mechmissilerepulsors[var_0C] = missile_createrepulsororigin(var_10,var_06,var_09);
			level._mech_globals.num_missile_repulsors++;
		}
	}

	if(!isdefined(param_00))
	{
		self.mechmissileattractors[self.attractornumber] = undefined;
		return;
	}

	if(level._mech_globals.num_missile_attractors + 1 <= 10)
	{
		self.mechmissileattractors[self.attractornumber] = missile_createattractorent(param_00,var_08,var_0B);
		level._mech_globals.num_missile_attractors++;
	}

	thread mech_rocket_fire_timeout(param_00);
}

//Function Number: 38
mech_random_missile_attractor_cleanup(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		if(isdefined(self.mechmissileattractors))
		{
			for(var_01 = 0;var_01 < self.attractornumber + 1;var_01++)
			{
				if(isdefined(self.mechmissileattractors[var_01]))
				{
					missile_deleteattractor(self.mechmissileattractors[var_01]);
					level._mech_globals.num_missile_attractors--;
				}
			}
		}

		if(isdefined(self.mechmissilerepulsors))
		{
			for(var_01 = 0;var_01 < self.repulsornumber;var_01++)
			{
				if(isdefined(self.mechmissilerepulsors[var_01]))
				{
					missile_deleteattractor(self.mechmissilerepulsors[var_01]);
					level._mech_globals.num_missile_repulsors--;
				}
			}
		}

		self.mechmissileattractors = [];
		self.mechmissilerepulsors = [];
	}
}

//Function Number: 39
mech_fire_rockets()
{
	self endon("death");
	var_00 = 48;
	var_01 = 64;
	var_02 = 3;
	var_03 = 6;
	var_04 = 100;
	var_05 = 24;
	var_06 = 0.1;
	var_07 = 0.4;
	var_08 = 12;
	var_09 = "tag_rocket";
	var_0A = 0.2;
	var_0B = randomintrange(var_02 + 1,var_03 + 1);
	var_0C = 20;
	var_0D = 20;
	var_0E = 16;
	for(var_0F = 1;var_0F < var_0B;var_0F++)
	{
		var_10 = var_09 + var_0F;
		var_11 = self gettagorigin(var_10);
		var_12 = self gettagangles(var_10);
		var_13 = anglestoforward(var_12);
		var_13 = vectornormalize(var_13);
		var_14 = randomintrange(-1 * var_0C,var_0C);
		var_15 = randomintrange(-1 * var_0D,var_0D);
		var_16 = randomintrange(-1 * var_0E,var_0E);
		var_17 = var_11 + var_13 * var_05;
		var_18 = var_11 + var_13 * var_04 + (var_14,var_15,var_16);
		var_19 = magicbullet("mech_rocket_deploy",var_17,var_18);
		playfx(level.mech_fx["rocket_muzzle_flash"],var_11,var_13,(0,0,1));
		if(isdefined(var_19))
		{
			var_1A = randomfloatrange(var_06,var_07);
			var_19 thread mech_rocket_deploy_projectile_think(self,self.enemy,var_1A);
		}

		wait(0.05);
	}

	wait(0.25);
}

//Function Number: 40
mech_precise_target_position(param_00,param_01)
{
	if(isdefined(param_01))
	{
		return param_01.origin;
	}

	return 400 * anglestoforward(param_00.angles);
}

//Function Number: 41
mech_rocket_deploy_projectile_think(param_00,param_01,param_02)
{
	var_03 = 32;
	var_04 = self.origin;
	wait(param_02);
	if(isdefined(self))
	{
		var_05 = (randomintrange(-1 * var_03,var_03),randomintrange(-1 * var_03,var_03),randomintrange(-1 * var_03,var_03));
		var_06 = mech_precise_target_position(self,param_01) + var_05;
		var_07 = magicbullet("mech_rocket",self.origin,var_06);
		playfx(level.mech_fx["rocket_seperation"],self.origin,anglestoforward(self.angles),(0,0,1));
		var_07 thread mech_rocket_projectile_think(param_01,var_06,param_00);
		var_07.owner = param_00;
		self delete();
	}
}

//Function Number: 42
mech_rocket_fire_timeout(param_00)
{
	wait(1);
	if(isdefined(self.mechmissileattractors) && isdefined(self.mechmissileattractors[self.attractornumber]))
	{
		missile_deleteattractor(self.mechmissileattractors[self.attractornumber]);
		var_01 = mech_precise_target_position(self,param_00);
		self.mechmissileattractors[self.attractornumber] = missile_createattractororigin(var_01,5000,256);
	}
}

//Function Number: 43
mech_rocket_projectile_think(param_00,param_01,param_02)
{
	self endon("death");
	if(isdefined(self))
	{
		if(isdefined(param_00))
		{
			self missile_settargetent(param_00,(0,0,32));
		}
		else
		{
			self missile_settargetpos(param_01);
		}

		self hide();
		var_03 = randomintrange(0,3);
		playfxontag(level.mech_fx["rocket_trail_" + var_03],self,"tag_origin");
	}

	var_04 = self.origin;
	for(;;)
	{
		var_04 = self.origin;
		wait(0.1);
	}
}

//Function Number: 44
mech_raise_rocket_pod(param_00)
{
	var_01 = 0.2;
	var_02 = %mech_add_rocketpack_raise;
	self setanimknobrestart(var_02,1,var_01);
	soundscripts\_snd::snd_message("snd_mech_add_rocketpack_raise");
	if(isdefined(param_00) && param_00)
	{
		wait(getanimlength(var_02));
	}

	self.rocketpodup = 1;
}

//Function Number: 45
mech_lower_rocket_pod(param_00)
{
	var_01 = 0.2;
	var_02 = %mech_add_rocketpack_lower;
	self setanimknobrestart(var_02,1,var_01);
	soundscripts\_snd::snd_message("snd_mech_add_rocketpack_lower");
	if(isdefined(param_00) && param_00)
	{
		wait(getanimlength(var_02));
	}

	self.rocketpodup = 0;
}

//Function Number: 46
mech_generic_attacking_behavior()
{
	self endon("death");
	self endon("stop_generic_attacking");
	for(;;)
	{
		wait(0.2);
		animscripts\combat::tryexposedreacquire();
		if(isdefined(self.enemy))
		{
			self.goalradius = 200;
			self.goalheight = 81;
			animscripts\combat_utility::tryrunningtoenemy(1);
		}
	}
}

//Function Number: 47
mech_target_attacker(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(self.targetattacker) && self.targetattacker)
	{
		self.usechokepoints = 0;
		if(isdefined(param_01) && self cansee(param_01))
		{
			self setgoalpos(param_01.origin);
		}
	}
}

//Function Number: 48
mech_hunt_stealth_behavior()
{
	self endon("death");
	self endon("stop_hunting");
	self endon("_stealth_enemy_alert_level_change");
	self.usechokepoints = 1;
	var_00 = 0;
	var_01 = randomfloatrange(3,4);
	for(;;)
	{
		wait(0.5);
		if(isdefined(self.enemy) && isdefined(level.player) && self.enemy == level.player)
		{
			if(isdefined(level._cloaked_stealth_settings) && isdefined(level._cloaked_stealth_settings.cloak_on) && level._cloaked_stealth_settings.cloak_on)
			{
				wait(randomfloatrange(0.3,3));
				continue;
			}
		}

		if(isdefined(self.enemy))
		{
			self setgoalpos(self lastknownpos(self.enemy));
			self.goalradius = 400;
			self.goalheight = 81;
		}
		else
		{
			var_00++;
		}

		if(0.5 * var_00 > var_01)
		{
			break;
		}
	}
}

//Function Number: 49
mech_hunt_immediately_behavior()
{
	self endon("death");
	self endon("stop_hunting");
	self.usechokepoints = 0;
	for(;;)
	{
		wait(0.5);
		if(isdefined(self.enemy))
		{
			self setgoalpos(self.enemy.origin);
			self.goalradius = 200;
			self.goalheight = 81;
		}
	}
}

//Function Number: 50
mech_emp_function()
{
	mech_emp_loop(%mech_emp_react,6);
}

//Function Number: 51
mech_emp_loop(param_00,param_01)
{
	self endon("death");
	if((isdefined(self.emp) && self.emp) || common_scripts\utility::isflashed())
	{
		return;
	}

	self.a.pose = "stand";
	self.allowdeath = 1;
	var_02 = self.flashbangimmunity;
	self.flashbangimmunity = 0;
	self.emp = 1;
	maps\_utility::flashbangstart(param_01);
	self.flashbangimmunity = var_02;
	thread empanim(param_01);
}

//Function Number: 52
empanim(param_00)
{
	self endon("death");
	if((isdefined(self.emp) && !self.emp) || !common_scripts\utility::isflashed())
	{
		return;
	}

	self notify("start_emp_effect");
	var_01 = self.minpaindamage;
	self.minpaindamage = 20000;
	maps\_utility::disable_pain();
	var_02 = getanimlength(%mech_emp_react);
	wait(var_02);
	self setanimknob(%mech_emp_idle,1,0.2,1);
	var_03 = getanimlength(%mech_emp_restart);
	wait(param_00 - var_03 + var_02);
	if(common_scripts\utility::isflashed())
	{
		self setanimknob(%mech_emp_restart,1,1,1);
		soundscripts\_snd::snd_message("snd_mech_emp_restart");
	}

	wait(var_03);
	maps\_utility::enable_pain();
	self.minpaindamage = var_01;
	self.emp = 0;
}

//Function Number: 53
init_mech_animsets()
{
	if(isdefined(level.archetypes["mech"]))
	{
		return;
	}

	level.archetypes["mech"] = [];
	init_animset_mech_default_stand();
	init_animset_mech_walk_move();
	init_animset_mech_run_move();
	init_animset_mech_cqb_move();
	init_animset_mech_shoot_moving();
	init_mech_turn_animations();
	init_animset_mech_death();
	init_animset_mech_pain();
	init_animset_mech_flashed();
	init_animset_mech_grenade_animations();
	init_animset_mech_stop();
	init_animset_mech_addpain();
	level.archetypes["mech"]["combat"]["surprise_stop"] = %mech_unaware_walk_stop;
	level.archetypes["mech"]["combat"]["trans_to_combat"] = %mech_walk_start;
	init_amimset_mech_transition();
}

//Function Number: 54
init_animset_mech_addpain()
{
	anim.initanimset = [];
	level.initanimset["default"] = [%mech_flinch_back,%mech_flinch_chest];
	level.initanimset["left_arm"] = %mech_flinch_lshoulder_down;
	level.initanimset["right_arm"] = %mech_flinch_rshoulder_down;
	level.initanimset["left_leg"] = %mech_flinch_lshoulder_up;
	level.initanimset["right_leg"] = %mech_flinch_rshoulder_up;
	level.archetypes["mech"]["additive_pain"] = level.initanimset;
}

//Function Number: 55
init_animset_mech_stop()
{
	var_00 = [];
	var_00["stand"][0] = [%mech_stand_idle];
	var_00["stand"][1] = [%mech_stand_idle];
	var_00["stand_cqb"][0] = [%mech_stand_idle];
	var_00["crouch"][0] = [%mech_stand_idle];
	level.archetypes["mech"]["idle"] = var_00;
	var_00 = [];
	var_00["stand"][0] = [1];
	var_00["stand"][1] = [1];
	var_00["stand_cqb"][0] = [1];
	var_00["crouch"][0] = [1];
	level.archetypes["mech"]["idle_weights"] = var_00;
	var_00 = [];
	var_00["stand"] = %mech_stand_idle;
	var_00["crouch"] = %mech_stand_idle;
	var_00["stand_smg"] = %mech_stand_idle;
	level.archetypes["mech"]["idle_transitions"] = var_00;
}

//Function Number: 56
init_amimset_mech_transition()
{
	var_00 = [];
	var_00["exposed"] = [];
	var_00["exposed"][1] = %mech_walk_stop_1;
	var_00["exposed"][2] = %mech_walk_stop_2;
	var_00["exposed"][3] = %mech_walk_stop_3;
	var_00["exposed"][4] = %mech_walk_stop_4;
	var_00["exposed"][6] = %mech_walk_stop_6;
	var_00["exposed"][7] = %mech_walk_stop_7;
	var_00["exposed"][8] = %mech_walk_stop_8;
	var_00["exposed"][9] = %mech_walk_stop_9;
	var_00["exposed_cqb"] = [];
	var_00["exposed_cqb"][1] = %mech_walk_stop_1;
	var_00["exposed_cqb"][2] = %mech_walk_stop_2;
	var_00["exposed_cqb"][3] = %mech_walk_stop_3;
	var_00["exposed_cqb"][4] = %mech_walk_stop_4;
	var_00["exposed_cqb"][6] = %mech_walk_stop_6;
	var_00["exposed_cqb"][7] = %mech_walk_stop_7;
	var_00["exposed_cqb"][8] = %mech_walk_stop_8;
	var_00["exposed_cqb"][9] = %mech_walk_stop_9;
	level.archetypes["mech"]["cover_trans"] = var_00;
	var_00 = [];
	var_00["exposed"] = [];
	var_00["exposed"][1] = %mech_walk_start_1;
	var_00["exposed"][2] = %mech_walk_start_2;
	var_00["exposed"][3] = %mech_walk_start_3;
	var_00["exposed"][4] = %mech_walk_start_4;
	var_00["exposed"][6] = %mech_walk_start_6;
	var_00["exposed"][7] = %mech_walk_start_7;
	var_00["exposed"][8] = %mech_walk_start_8;
	var_00["exposed"][9] = %mech_walk_start_9;
	var_00["exposed_cqb"] = [];
	var_00["exposed_cqb"][1] = %mech_walk_start_1;
	var_00["exposed_cqb"][2] = %mech_walk_start_2;
	var_00["exposed_cqb"][3] = %mech_walk_start_3;
	var_00["exposed_cqb"][4] = %mech_walk_start_4;
	var_00["exposed_cqb"][6] = %mech_walk_start_6;
	var_00["exposed_cqb"][7] = %mech_walk_start_7;
	var_00["exposed_cqb"][8] = %mech_walk_start_8;
	var_00["exposed_cqb"][9] = %mech_walk_start_9;
	level.archetypes["mech"]["cover_exit"] = var_00;
	animscripts\init_move_transitions::inittransdistandanglesforarchetype("mech");
	initmechsplittimes();
	animscripts\init_move_transitions::getsplittimes("mech");
}

//Function Number: 57
initmechsplittimes()
{
}

//Function Number: 58
init_animset_mech_shoot_moving()
{
	var_00 = [];
	var_00["fire"] = %mech_walking_fire_auto;
	var_00["single"] = [%mech_walking_fire_auto];
	level.archetypes["mech"]["shoot_while_moving"] = var_00;
}

//Function Number: 59
init_mech_turn_animations()
{
	anim.initanimset = [];
	level.initanimset[0] = %mech_run_turn_180;
	level.initanimset[1] = %mech_run_turn_l135;
	level.initanimset[2] = %mech_run_turn_l90;
	level.initanimset[3] = %mech_run_turn_l45;
	level.initanimset[5] = %mech_run_turn_r45;
	level.initanimset[6] = %mech_run_turn_r90;
	level.initanimset[7] = %mech_run_turn_r135;
	level.initanimset[8] = %mech_run_turn_180;
	level.archetypes["mech"]["run_turn"] = level.initanimset;
	level.archetypes["mech"]["cqb_run_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %mech_walk_turn_2;
	level.initanimset[1] = %mech_walk_turn_1;
	level.initanimset[2] = %mech_walk_turn_4;
	level.initanimset[3] = %mech_walk_turn_7;
	level.initanimset[5] = %mech_walk_turn_9;
	level.initanimset[6] = %mech_walk_turn_6;
	level.initanimset[7] = %mech_walk_turn_3;
	level.initanimset[8] = %mech_walk_turn_2;
	level.archetypes["mech"]["cqb_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %mech_turn_45_l;
	level.initanimset["turn_left_90"] = %mech_turn_90_l;
	level.initanimset["turn_left_135"] = %mech_turn_135_l;
	level.initanimset["turn_left_180"] = %mech_turn_180_l;
	level.initanimset["turn_right_45"] = %mech_turn_45_r;
	level.initanimset["turn_right_90"] = %mech_turn_90_r;
	level.initanimset["turn_right_135"] = %mech_turn_135_r;
	level.initanimset["turn_right_180"] = %mech_turn_180_r;
	level.archetypes["mech"]["exposed_turn"] = level.initanimset;
}

//Function Number: 60
init_animset_mech_grenade_animations()
{
	anim.initanimset = [];
	level.initanimset["cower_squat"] = %mech_exposed_squat_down_mech_grenade_f;
	level.initanimset["cower_dive_back"] = %mech_exposed_dive_grenade_b;
	level.initanimset["cower_dive_front"] = %mech_exposed_dive_grenade_f;
	level.initanimset["return_throw_short"] = [%mech_grenade_return_running_throw_forward,%mech_grenade_return_standing_throw_overhand_forward];
	level.initanimset["return_throw_long"] = [%mech_grenade_return_standing_throw_overhand_forward];
	level.initanimset["return_throw_default"] = [%mech_grenade_return_running_throw_forward,%mech_grenade_return_standing_throw_overhand_forward];
	level.archetypes["mech"]["grenade"] = level.initanimset;
}

//Function Number: 61
init_animset_mech_pain()
{
	anim.initanimset = [];
	level.initanimset["torso_upper"] = [%mech_stand_exposed_extendedpain_neck];
	level.initanimset["torso_upper_extended"] = [%mech_stand_exposed_extendedpain_gut,%mech_stand_exposed_extendedpain_stomach];
	level.initanimset["torso_lower"] = [%mech_exposed_pain_groin,%mech_stand_exposed_extendedpain_hip];
	level.initanimset["torso_lower_extended"] = [%mech_stand_exposed_extendedpain_gut,%mech_stand_exposed_extendedpain_stomach];
	level.initanimset["head"] = [%mech_exposed_pain_face,%mech_stand_exposed_extendedpain_neck];
	level.initanimset["head_extended"] = [%mech_exposed_pain_face,%mech_stand_exposed_extendedpain_neck];
	level.initanimset["right_arm"] = [%mech_exposed_pain_right_arm];
	level.initanimset["right_arm_extended"] = [%mech_exposed_pain_right_arm];
	level.initanimset["left_arm"] = [%mech_stand_exposed_extendedpain_shoulderswing];
	level.initanimset["left_arm_extended"] = [%mech_stand_exposed_extendedpain_shoulderswing];
	level.initanimset["leg"] = [%mech_exposed_pain_groin];
	level.initanimset["leg_extended"] = [%mech_stand_exposed_extendedpain_stomach];
	level.initanimset["foot"] = [%mech_stand_exposed_extendedpain_thigh];
	level.initanimset["foot_extended"] = [%mech_stand_exposed_extendedpain_thigh];
	level.initanimset["default_long"] = [%mech_stand_extendedpainc,%mech_stand_exposed_extendedpain_chest,%mech_stand_exposed_extendedpain_stomach];
	level.initanimset["default_short"] = [%mech_exposed_pain_right_arm,%mech_exposed_pain_face,%mech_exposed_pain_groin];
	level.initanimset["default_extended"] = [%mech_stand_extendedpainb,%mech_stand_exposed_extendedpain_chest,%mech_stand_extendedpainc];
	level.initanimset["damage_shield_pain_array"] = [%mech_stand_exposed_extendedpain_gut,%mech_stand_exposed_extendedpain_stomach,%mech_stand_exposed_extendedpain_chest];
	level.initanimset["run_long"] = [%mech_stand_extendedpainc,%mech_stand_extendedpainb,%mech_stand_exposed_extendedpain_chest];
	level.initanimset["run_medium"] = [%mech_stand_extendedpainc,%mech_stand_extendedpainb,%mech_stand_exposed_extendedpain_chest];
	level.initanimset["run_short"] = [%mech_stand_extendedpainc,%mech_stand_extendedpainb,%mech_stand_exposed_extendedpain_chest];
	level.initanimset["back"] = %mech_stand_extendedpainb;
	level.archetypes["mech"]["pain"] = level.initanimset;
}

//Function Number: 62
init_animset_mech_death()
{
	var_00 = [];
	var_00["directed_energy_stand_front_head"] = [%mech_stand_death_headshot_slowfall];
	var_00["directed_energy_stand_front_legs"] = [%mech_stand_death_leg];
	var_00["directed_energy_stand_front_default"] = [%mech_stand_death_tumbleforward];
	var_00["directed_energy_stand_back_default"] = [%mech_stand_death_tumbleback];
	var_00["strong_legs"] = [%mech_stand_death_leg];
	var_00["strong_torso_lower"] = [%mech_stand_death_guts];
	var_00["strong_default"] = [%mech_stand_death_stumbleforward,%mech_stand_death_tumbleforward];
	var_00["strong_right"] = [%mech_stand_death_shoulder_spin,%mech_stand_death_fallside];
	var_00["strong_left"] = [%mech_stand_death_shoulder_spin,%mech_stand_death_fallside];
	var_00["running_forward"] = [%mech_stand_death_tumbleforward,%mech_exposed_death_flop];
	var_00["running_forward_f"] = [%mech_stand_death_tumbleback];
	var_00["stand_lower_body"] = [%mech_stand_death_crotch,%mech_stand_death_leg];
	var_00["stand_lower_body_extended"] = [%mech_stand_death_crotch,%mech_stand_death_guts];
	var_00["stand_head"] = [%mech_stand_death_face,%mech_stand_death_headshot_slowfall];
	var_00["stand_neck"] = [%mech_exposed_death_neckgrab];
	var_00["stand_left_shoulder"] = [%mech_stand_death_shoulder_spin];
	var_00["stand_torso_upper"] = [%mech_stand_death_tumbleforward];
	var_00["stand_torso_upper_extended"] = [%mech_stand_death_fallside];
	var_00["stand_front_head"] = [%mech_stand_death_face,%mech_stand_death_headshot_slowfall];
	var_00["stand_front_head_extended"] = [%mech_stand_death_head_straight_back];
	var_00["stand_front_torso"] = [%mech_stand_death_tumbleback];
	var_00["stand_front_torso_extended"] = [%mech_stand_death_chest_stunned];
	var_00["stand_back"] = [%mech_exposed_death_flop];
	var_00["stand_default"] = [%mech_exposed_death_flop];
	var_00["stand_default_firing"] = [%mech_exposed_death_flop];
	var_00["stand_backup_default"] = %mech_exposed_death_flop;
	var_00["melee_standing_front"] = [%mech_exposed_death_neckgrab];
	var_00["melee_standing_back"] = [%mech_exposed_death_flop];
	var_00["melee_standing_left"] = [%mech_exposed_death_flop];
	var_00["melee_standing_right"] = [%mech_exposed_death_flop];
	var_00["melee_crouching_front"] = [%mech_exposed_death_flop];
	var_00["melee_crouching_back"] = [%mech_exposed_death_flop];
	var_00["melee_crouching_left"] = [%mech_exposed_death_flop];
	var_00["melee_crouching_right"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_stand_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_stand_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_stand_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_stand_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_stand_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_stand_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_stand_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_stand_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_stand_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_stand_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_stand_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_stand_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_crouch_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_crouch_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_crouch_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_crouch_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_crouch_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_crouch_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_crouch_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_crouch_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_crouch_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_crouch_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_crouch_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_crouch_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_prone_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_prone_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_prone_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_prone_stand"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_prone_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_prone_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_prone_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_prone_crouch"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_prone_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_back_prone_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_left_prone_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_right_prone_prone"] = [%mech_exposed_death_flop];
	var_00["melee_exo_stand_front_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_stand_back_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_stand_left_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_stand_right_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_crouch_front_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_crouch_back_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_crouch_left_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_crouch_right_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_prone_front_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_prone_back_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_prone_left_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_prone_right_head"] = [%mech_exposed_death_flop];
	var_00["melee_exo_front_lower"] = [%mech_exposed_death_flop];
	var_00["emp"] = [%mech_emp_death];
	level.archetypes["mech"]["death"] = var_00;
}

//Function Number: 63
init_animset_mech_cqb_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %mech_runf;
	level.initanimset["sprint_short"] = %mech_sprint;
	level.initanimset["straight"] = %mech_walkf;
	level.initanimset["fire"] = %mech_walking_fire_auto;
	level.initanimset["single"] = [%mech_walking_fire_auto];
	level.initanimset["move_f"] = %mech_walkf;
	level.initanimset["move_l"] = %mech_stand_walk_left;
	level.initanimset["move_r"] = %mech_stand_walk_right;
	level.initanimset["move_b"] = %mech_stand_walk_back;
	level.initanimset["stairs_up"] = %mech_run_stairs_up;
	level.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
	level.initanimset["stairs_down_out"] = %mech_run_stairs_down_2_run;
	level.initanimset["stairs_down"] = %mech_run_stairs_down;
	level.initanimset["aim_2"] = %mech_walking_aim_low;
	level.initanimset["aim_4"] = %mech_walking_aim_left;
	level.initanimset["aim_6"] = %mech_walking_aim_right;
	level.initanimset["aim_8"] = %mech_walking_aim_high;
	level.initanimset["aim_5"] = %mech_walking_aim5;
	level.archetypes["mech"]["cqb"] = level.initanimset;
}

//Function Number: 64
init_animset_mech_default_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %mech_aim_high;
	level.initanimset["add_aim_down"] = %mech_aim_low;
	level.initanimset["add_aim_left"] = %mech_aim_left;
	level.initanimset["add_aim_right"] = %mech_aim_right;
	level.initanimset["straight_level"] = %mech_aim5;
	level.initanimset["aim_2"] = %mech_aim_low;
	level.initanimset["aim_4"] = %mech_aim_left;
	level.initanimset["aim_6"] = %mech_aim_right;
	level.initanimset["aim_8"] = %mech_aim_high;
	level.initanimset["aim_5"] = %mech_aim5;
	level.initanimset["fire"] = %mech_walking_fire_auto;
	level.initanimset["single"] = animscripts\utility::array(%mech_stand_fire_burst_semi);
	set_animarray_mech_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts\utility::array(%mech_combat_idle);
	level.initanimset["reload"] = animscripts\utility::array(%mech_stand_reload);
	level.initanimset["reload_crouchhide"] = animscripts\utility::array(%mech_stand_reload);
	set_animarray_mech_standing_turns();
	level.archetypes["mech"]["default_stand"] = level.initanimset;
	level.archetypes["mech"]["cqb_stand"] = level.initanimset;
}

//Function Number: 65
init_animset_mech_run_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %mech_sprint;
	level.initanimset["sprint_short"] = %mech_sprint;
	level.initanimset["fire"] = %mech_walking_fire_auto;
	level.initanimset["single"] = [%mech_walking_fire_auto];
	level.initanimset["straight"] = %mech_runf;
	level.initanimset["smg_straight"] = %mech_runf;
	level.initanimset["aim_2"] = %mech_walking_aim_low;
	level.initanimset["aim_4"] = %mech_walking_aim_left;
	level.initanimset["aim_6"] = %mech_walking_aim_right;
	level.initanimset["aim_8"] = %mech_walking_aim_high;
	level.initanimset["aim_5"] = %mech_walking_aim5;
	level.initanimset["move_f"] = %mech_runf;
	level.initanimset["move_l"] = %mech_stand_walk_left;
	level.initanimset["move_r"] = %mech_stand_walk_right;
	level.initanimset["move_b"] = %mech_stand_walk_back;
	level.initanimset["stairs_up"] = %mech_run_stairs_up;
	level.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
	level.initanimset["stairs_up_out"] = %mech_run_stairs_up_2_run;
	level.initanimset["stairs_down"] = %mech_run_stairs_down;
	set_animarray_mech_burst_and_semi_fire_walk();
	level.archetypes["mech"]["run"] = level.initanimset;
}

//Function Number: 66
init_animset_mech_walk_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %mech_sprint;
	level.initanimset["straight"] = %mech_walkf;
	level.initanimset["fire"] = %mech_walking_fire_auto;
	level.initanimset["single"] = [%mech_walking_fire_auto];
	level.initanimset["move_f"] = %mech_walkf;
	level.initanimset["move_l"] = %mech_stand_walk_left;
	level.initanimset["move_r"] = %mech_stand_walk_right;
	level.initanimset["move_b"] = %mech_stand_walk_back;
	level.initanimset["aim_2"] = %mech_walking_aim_low;
	level.initanimset["aim_4"] = %mech_walking_aim_left;
	level.initanimset["aim_6"] = %mech_walking_aim_right;
	level.initanimset["aim_8"] = %mech_walking_aim_high;
	level.initanimset["aim_5"] = %mech_walking_aim5;
	level.initanimset["stairs_up"] = %mech_run_stairs_up;
	level.initanimset["stairs_down"] = %mech_run_stairs_down;
	level.initanimset["stairs_up_in"] = %mech_run_stairs_up_2_run;
	level.initanimset["stairs_up_out"] = %mech_run_stairs_up_2_run;
	set_animarray_mech_burst_and_semi_fire_walk();
	level.archetypes["mech"]["walk"] = level.initanimset;
}

//Function Number: 67
set_animarray_mech_standing_turns()
{
	level.initanimset["turn_left_45"] = %mech_turn_45_l;
	level.initanimset["turn_left_90"] = %mech_turn_90_l;
	level.initanimset["turn_left_135"] = %mech_turn_135_l;
	level.initanimset["turn_left_180"] = %mech_turn_180_l;
	level.initanimset["turn_right_45"] = %mech_turn_45_r;
	level.initanimset["turn_right_90"] = %mech_turn_90_r;
	level.initanimset["turn_right_135"] = %mech_turn_135_r;
	level.initanimset["turn_right_180"] = %mech_turn_180_r;
}

//Function Number: 68
set_animarray_mech_burst_and_semi_fire_stand()
{
	level.initanimset["burst2"] = %mech_stand_fire_burst;
	level.initanimset["burst3"] = %mech_stand_fire_burst;
	level.initanimset["burst4"] = %mech_stand_fire_burst;
	level.initanimset["burst5"] = %mech_stand_fire_burst;
	level.initanimset["burst6"] = %mech_stand_fire_burst;
	level.initanimset["semi1"] = %mech_stand_fire_burst_semi;
	level.initanimset["semi3"] = %mech_stand_fire_burst_semi;
	level.initanimset["semi4"] = %mech_stand_fire_burst_semi;
	level.initanimset["semi5"] = %mech_stand_fire_burst_semi;
}

//Function Number: 69
set_animarray_mech_burst_and_semi_fire_walk()
{
	level.initanimset["burst2"] = %mech_walk_fire_burst;
	level.initanimset["burst3"] = %mech_walk_fire_burst;
	level.initanimset["burst4"] = %mech_walk_fire_burst;
	level.initanimset["burst5"] = %mech_walk_fire_burst;
	level.initanimset["burst6"] = %mech_walk_fire_burst;
	level.initanimset["semi1"] = %mech_walk_fire_burst_semi;
	level.initanimset["semi3"] = %mech_walk_fire_burst_semi;
	level.initanimset["semi4"] = %mech_walk_fire_burst_semi;
	level.initanimset["semi5"] = %mech_walk_fire_burst_semi;
}

//Function Number: 70
init_animset_mech_flashed()
{
	var_00 = [];
	var_00["flashed"] = [%mech_emp_react];
	level.archetypes["mech"]["flashed"] = var_00;
	level.flashanimindex["mech"] = 0;
}