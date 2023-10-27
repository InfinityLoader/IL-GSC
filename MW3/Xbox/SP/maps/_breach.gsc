/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_breach.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 24
 * Decompile Time: 437 ms
 * Timestamp: 10/27/2023 2:34:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["_breach_doorbreach_detpack"] = loadfx("explosions/exp_pack_doorbreach");
	level._effect["_breach_doorbreach_kick"] = loadfx("dust/door_kick");
	level.scr_sound["breach_wooden_door"] = "detpack_explo_main";
	level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
	common_scripts\utility::flag_init("begin_the_breach");
}

//Function Number: 2
func_3B14(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("breach_abort");
	if(isdefined(param_05) && param_05 == 0)
	{
		level.fire_notetrack_functions["scripted"] = ::func_3B36;
	}

	self.var_3B15 = 0;
	self.closestai = undefined;
	self.var_3B17 = undefined;
	self.breached = 0;
	self.var_3B19 = 0;
	self.var_3B1A = 0;
	self.var_3B1B = 0;
	self.readytobreach = 0;
	self.var_3B1D = 0;
	self.var_3B1E = 0;
	self.cleared = 0;
	self.var_3B20 = 1;
	self.var_3B21 = 0;
	self.hostilesspawned = 0;
	var_06 = getentarray(self.targetname,"targetname");
	var_07 = self.targetname;
	self.sbadplacename = "badplace_" + var_07;
	self.var_3B24 = getent("badplace_" + var_07,"targetname");
	if(isdefined(self.var_3B24))
	{
	}

	self.var_3B25 = getent("trigger_" + var_07,"targetname");
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(isdefined(self.var_3B25))
	{
		switch(self.var_3B25.classname)
		{
			case "trigger_use":
				self.triggerhintstring = param_02;
				break;

			case "trigger_use_touch":
				self.triggerhintstring = param_02;
				break;

			case "trigger_radius":
				break;

			case "trigger_multiple":
				break;

			default:
				break;
		}
	}

	switch(param_01)
	{
		case "explosive_breach_left":
			break;

		case "shotgunhinges_breach_left":
			break;

		case "flash_breach_no_door_right":
			self.var_3B20 = 0;
			self.var_3B21 = 1;
			break;

		default:
			break;
	}

	if(self.var_3B20 == 1)
	{
		self.edoor = getent(self.script_linkto,"script_linkname");
		if(self.edoor.classname == "script_model")
		{
			self.var_3B17 = spawn("script_origin",self.edoor.origin);
			self.var_3B17.angles = self.edoor.angles;
		}
		else if(self.edoor.classname == "script_brushmodel")
		{
			self.var_3B17 = getent(self.edoor.target,"targetname");
			self.edoor.vector = anglestoforward(self.var_3B17.angles);
		}

		self.var_3B17.type = "Cover Right";
		self.var_3B29 = getent(self.edoor.script_linkto,"script_linkname");
		self.iexplodernum = self.var_3B29.script_exploder;
	}
	else if(self.var_3B20 == 0)
	{
		self.var_3B17 = getent(self.script_linkto,"script_linkname");
	}

	if(self.var_3B21 == 1)
	{
		self.var_3B2B = getent("flashthrow_" + var_07,"targetname");
		self.var_3B2C = getent(self.var_3B2B.target,"targetname");
	}

	thread breach_abort(param_00);
	thread func_3B40(param_00);
	thread func_3B42(param_01,param_04);
	var_08 = 0;
	for(var_09 = 0;var_09 < param_00.size;var_09++)
	{
		if(isdefined(param_00[var_09].firstbreacher))
		{
			var_08++;
			self.closestai = param_00[var_09];
		}
	}

	if(var_08 > 0)
	{
	}
	else
	{
		self.closestai = maps\_utility::getclosest(self.var_3B17.origin,param_00);
	}

	if(param_00.size == 1)
	{
		self.var_3B1B = 1;
	}

	for(var_09 = 0;var_09 < param_00.size;var_09++)
	{
		param_00[var_09] thread func_3B30(self,param_01,param_05);
	}

	while(self.var_3B19 < param_00.size)
	{
		wait 0.05;
	}

	self notify("ready_to_breach");
	self.readytobreach = 1;
	if(isdefined(self.var_3B25))
	{
		self.var_3B25 thread breach_trigger_think(self);
		self waittill("execute_the_breach");
	}
	else
	{
		self notify("execute_the_breach");
	}

	common_scripts\utility::flag_set("begin_the_breach");
	self.var_3B1E = 1;
	if(isdefined(param_03) && param_03 == 1)
	{
		var_0A = getentarray("hostiles_" + var_07,"targetname");
		self waittill("spawn_hostiles");
		spawnbreachhostiles(var_0A);
		self.hostilesspawned = 1;
	}

	if(isdefined(self.var_3B24))
	{
		badplace_cylinder(self.sbadplacename,-1,self.var_3B24.origin,self.var_3B24.radius,200,"bad_guys");
	}

	var_0B = getaiarray("bad_guys");
	var_0C = [];
	var_09 = 0;
	while(var_09 < var_0B.size)
	{
		if(var_0B[var_09] istouching(self))
		{
		}

		var_0B++ = var_41[var_0C.size];
	}

	if(var_41.size > 0)
	{
		common_scripts\utility::array_thread(var_41,::func_3B39,self);
	}

	while(!self.var_3B1D)
	{
		wait 0.05;
	}

	self notify("breach_complete",var_0B[var_09]);
	if(!var_41.size)
	{
		return;
	}

	while(!self.cleared)
	{
		wait 0.05;
		for(var_0B = 0;var_0B < var_41.size;var_0B++)
		{
			if(!isalive(var_41[var_0B]))
			{
				var_41 = common_scripts\utility::array_remove(var_41,var_41[var_0B]);
			}

			if(var_41.size == 0)
			{
				self.cleared = 1;
			}
		}
	}
}

//Function Number: 3
breach_dont_fire()
{
	while(self.var_3B2F == 1)
	{
		self waittillmatch("fire","single anim");
		self.a.lastshoottime = gettime();
	}
}

//Function Number: 4
func_3B30(param_00,param_01,param_02)
{
	self.var_3B2F = 1;
	self.var_3B31 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	self pushplayer(1);
	thread func_3B45();
	param_00 endon("breach_abort");
	self.ender = "stop_idle_" + self getentitynumber();
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	if(self == param_00.closestai)
	{
		var_03 = "01";
	}
	else
	{
		var_03 = "02";
	}

	if(param_00.var_3B1B == 1 && param_01 == "explosive_breach_left")
	{
		var_03 = "02";
	}

	switch(param_01)
	{
		case "explosive_breach_left":
			if(isdefined(self.usebreachapproach) && self.usebreachapproach == 0)
			{
				var_04 = "detcord_stack_left_start_no_approach_" + var_03;
			}
			else
			{
				var_04 = "detcord_stack_left_start_" + var_03;
			}
	
			var_05 = "detcord_stack_leftidle_" + var_03;
			var_06 = "detcord_stack_leftbreach_" + var_03;
			break;

		case "shotgunhinges_breach_left":
			var_04 = "shotgunhinges_breach_left_stack_start_" + var_03;
			var_05 = "shotgunhinges_breach_left_stack_idle_" + var_03;
			var_06 = "shotgunhinges_breach_left_stack_breach_" + var_03;
			break;

		case "flash_breach_no_door_right":
			if(param_00.var_3B1B == 1)
			{
				var_04 = "flash_stack_right_start_single";
				var_05 = "flash_stack_right_idle_single";
				var_06 = "flash_stack_right_breach_single";
				var_07 = "flash_stack_right_flash_single";
			}
			else
			{
				var_04 = "flash_stack_right_start_" + var_03;
				var_05 = "flash_stack_right_idle_" + var_03;
				var_06 = "flash_stack_right_breach_" + var_03;
				var_07 = "flash_stack_right_flash_" + var_03;
			}
			break;

		default:
			break;
	}

	breach_set_goaladius(64);
	if(!isdefined(self.usebreachapproach) || self.usebreachapproach)
	{
		param_00.var_3B17 maps\_anim::anim_generic_reach(self,var_04);
	}
	else
	{
		self.scriptedarrivalent = param_00.var_3B17;
		param_00.var_3B17 maps\_anim::anim_generic_reach_and_arrive(self,var_04);
	}

	param_00.var_3B17 maps\_anim::anim_generic(self,var_04);
	param_00.var_3B17 thread maps\_anim::anim_generic_loop(self,var_05,self.ender);
	self.var_3B33 = self.origin;
	param_00.var_3B19++;
	self.scriptedarrivalent = undefined;
	param_00 waittill("execute_the_breach");
	if(!param_00.var_3B15 && isdefined(var_07))
	{
		param_00.var_3B17 notify(self.ender);
		param_00.var_3B17 thread maps\_anim::anim_generic(self,var_07);
		wait 1;
		if(var_03 == "02" || param_00.var_3B1B == 1)
		{
			var_08 = "J_Mid_LE_1";
			self attach("projectile_m84_flashbang_grenade",var_08);
			var_09 = self.grenadeweapon;
			self.grenadeweapon = "flash_grenade";
			self.grenadeammo++;
			if(var_03 == "02")
			{
				self waittillmatch("grenade_throw","single anim");
			}

			if(param_00.var_3B1B == 1 && var_03 == "01")
			{
				self waittillmatch("fire","single anim");
			}

			self magicgrenade(param_00.var_3B2B.origin,param_00.var_3B2C.origin,level.var_3B34);
			self detach("projectile_m84_flashbang_grenade",var_08);
			self.grenadeweapon = var_09;
			self.grenadeammo = 0;
		}

		self waittillmatch("end","single anim");
		param_00.var_3B17 thread maps\_anim::anim_generic_loop(self,var_05,self.ender);
		wait 0.1;
	}

	param_00.var_3B17 notify(self.ender);
	if(param_02 == 0)
	{
		self.var_3B31 = 1;
	}

	param_00.var_3B17 thread maps\_anim::anim_generic(self,var_06);
	if(param_01 == "explosive_breach_left")
	{
		if(var_03 == "02")
		{
			thread detcord_logic(param_00);
			self waittillmatch("pull fuse","single anim");
			wait 1;
			param_00 notify("spawn_hostiles");
			param_00 notify("detpack_about_to_blow");
			self waittillmatch("explosion","single anim");
			param_00 notify("detpack_detonated");
			param_00.breached = 1;
			param_00.edoor thread door_open("explosive",param_00);
			param_00 notify("play_breach_fx");
		}
	}
	else if(param_01 == "shotgunhinges_breach_left")
	{
		if(var_03 == "01")
		{
			param_00 notify("spawn_hostiles");
			self waittillmatch("kick","single anim");
			param_00.edoor thread door_open("shotgun",param_00);
			param_00 notify("play_breach_fx");
		}
	}
	else if(param_01 == "flash_breach_no_door_right")
	{
	}

	self waittillmatch("end","single anim");
	self notify("breach_complete");
	if(param_02 == 0)
	{
		self.var_3B31 = undefined;
	}

	if(isdefined(level.friendly_breach_thread))
	{
		self thread [[ level.friendly_breach_thread ]](param_00);
	}

	param_00.var_3B1D = 1;
	self pushplayer(0);
	breach_reset_animname();
	while(!param_00.cleared)
	{
		wait 0.05;
	}

	self.var_3B2F = 0;
}

//Function Number: 5
func_3B36()
{
	if(isdefined(self.var_3B31))
	{
		return;
	}

	animscripts/notetracks::fire_straight();
}

//Function Number: 6
detcord_logic(param_00)
{
	thread sound_effect_play(param_00);
	self waittillmatch("attach prop right","single anim");
	var_01 = "TAG_INHAND";
	self attach("weapon_detcord",var_01);
	self waittillmatch("detach prop right","single anim");
	var_02 = self gettagorigin(var_01);
	var_03 = self gettagangles(var_01);
	self detach("weapon_detcord",var_01);
	var_04 = spawn("script_model",var_02);
	var_04 setmodel("weapon_detcord");
	var_04.angles = var_03;
	param_00 waittill("detpack_detonated");
	radiusdamage(var_04.origin,64,50,25);
	var_04 delete();
}

//Function Number: 7
sound_effect_play(param_00)
{
	self waittillmatch("sound effect","single anim");
	thread common_scripts\utility::play_sound_in_space("detpack_plant_arming",param_00.var_3B17.origin);
}

//Function Number: 8
func_3B39(param_00)
{
	self endon("death");
	param_00 endon("breach_aborted");
	param_00 waittill("detpack_detonated");
	if(distance(self.origin,param_00.var_3B17.origin) <= level.detpackstunradius)
	{
		level.stunnedanimnumber++;
		if(level.stunnedanimnumber > 2)
		{
			level.stunnedanimnumber = 1;
		}

		var_01 = "exposed_flashbang_v" + level.stunnedanimnumber;
		self.allowdeath = 1;
		maps\_anim::anim_generic_custom_animmode(self,"gravity",var_01);
		breach_reset_animname();
	}
}

//Function Number: 9
breach_trigger_think(param_00)
{
	param_00 endon("execute_the_breach");
	param_00 endon("breach_aborted");
	thread func_3B3D(param_00);
	self waittill("trigger");
	param_00 notify("execute_the_breach");
}

//Function Number: 10
func_3B3D(param_00)
{
	param_00 waittill("execute_the_breach");
	common_scripts\utility::trigger_off();
	if(isdefined(param_00.var_3B3E))
	{
		param_00.var_3B3E delete();
	}
}

//Function Number: 11
breach_abort(param_00)
{
	self endon("breach_complete");
	self waittill("breach_abort");
	self.cleared = 1;
	thread func_3B40(param_00);
}

//Function Number: 12
func_3B40(param_00)
{
	while(!self.cleared)
	{
		wait 0.05;
	}

	if(isdefined(self.var_3B24))
	{
		badplace_delete(self.sbadplacename);
	}

	while(!self.cleared)
	{
		wait 0.05;
	}

	common_scripts\utility::array_thread(param_00,::func_3B41,self);
}

//Function Number: 13
func_3B41(param_00)
{
	self endon("death");
	breach_reset_animname();
	func_3B4D();
	param_00.var_3B17 notify(self.ender);
	self notify("stop_infinite_ammo");
	self pushplayer(0);
}

//Function Number: 14
func_3B42(param_00,param_01)
{
	self endon("breach_aborted");
	self endon("breach_complete");
	switch(param_00)
	{
		case "explosive_breach_left":
			self waittill("play_breach_fx");
			common_scripts\utility::exploder(self.iexplodernum);
			thread common_scripts\utility::play_sound_in_space(level.scr_sound["breach_wooden_door"],self.var_3B29.origin);
			if(param_01)
			{
				playfx(level._effect["_breach_doorbreach_detpack"],self.var_3B29.origin,anglestoforward(self.var_3B29.angles));
			}
			break;

		case "shotgunhinges_breach_left":
			self waittill("play_breach_fx");
			common_scripts\utility::exploder(self.iexplodernum);
			if(param_01)
			{
				playfx(level._effect["_breach_doorbreach_kick"],self.var_3B29.origin,anglestoforward(self.var_3B29.angles));
			}
			break;

		case "flash_breach_no_door_right":
			break;

		default:
			break;
	}
}

//Function Number: 15
func_3B43(param_00)
{
	var_01 = param_00 dospawn();
	maps\_utility::func_F77(var_01);
	return var_01;
}

//Function Number: 16
spawnbreachhostiles(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = func_3B43(param_00[var_02]);
		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 17
func_3B45()
{
	self endon("death");
	self endon("stop_infinite_ammo");
	while(isdefined(self.weapon))
	{
		if(isdefined(self.weapon) && self.weapon == "none")
		{
			break;
		}

		self.bulletsinclip = weaponclipsize(self.weapon);
		wait 0.5;
	}
}

//Function Number: 18
door_open(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 == 1)
	{
		self playsound(level.scr_sound["breach_wood_door_kick"]);
	}

	switch(param_00)
	{
		case "explosive":
			thread func_3B4A(param_01.var_3B17);
			func_3B49();
			self playsound(level.scr_sound["breach_wooden_door"]);
			earthquake(0.4,1,self.origin,1000);
			radiusdamage(self.origin,56,level.maxdetpackdamage,level.var_3B47);
			break;

		case "shotgun":
			thread func_3B4A(param_01.var_3B17);
			func_3B49();
			self playsound(level.scr_sound["breach_wooden_door"]);
			break;
	}
}

//Function Number: 19
func_3B49()
{
	if(self.classname == "script_brushmodel")
	{
		self connectpaths();
		return;
	}

	var_00 = getent(self.target,"targetname");
	var_00 hide();
	var_00 notsolid();
	var_00 connectpaths();
}

//Function Number: 20
func_3B4A(param_00)
{
	var_01 = undefined;
	if(self.classname == "script_model")
	{
		var_01 = anglestoforward(self.angles);
	}
	else if(self.classname == "script_brushmodel")
	{
		var_01 = self.vector;
	}
	else
	{
	}

	var_02 = (var_01[0] * 20,var_01[1] * 20,var_01[2] * 20);
	self moveto(self.origin + var_02,0.5,0,0.5);
	var_03 = spawn("script_origin",(0,0,0));
	var_03.angles = param_00.angles;
	var_03.origin = (self.origin[0],self.origin[1],param_00.origin[2]);
	self linkto(var_03);
	var_03 rotatepitch(90,0.45,0.4);
	wait 0.45;
	var_03 rotatepitch(-4,0.2,0,0.2);
	wait 0.2;
	var_03 rotatepitch(4,0.15,0.15);
	wait 0.15;
	self unlink();
	var_03 delete();
}

//Function Number: 21
breach_set_goaladius(param_00)
{
	if(!isdefined(self.var_3B4C))
	{
		self.var_3B4C = self.goalradius;
	}

	self.goalradius = param_00;
}

//Function Number: 22
func_3B4D()
{
	if(isdefined(self.var_3B4C))
	{
		self.goalradius = self.var_3B4C;
	}

	self.var_3B4C = undefined;
}

//Function Number: 23
breach_set_animname(param_00)
{
	if(!isdefined(self.old_animname))
	{
		self.old_animname = self.animname;
	}

	self.animname = param_00;
}

//Function Number: 24
breach_reset_animname()
{
	if(isdefined(self.old_animname))
	{
		self.animname = self.old_animname;
	}

	self.old_animname = undefined;
}