/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_breach.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 24
 * Decompile Time: 375 ms
 * Timestamp: 10/27/2023 1:39:25 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level._effect["_breach_doorbreach_detpack"] = loadfx("fx/explosions/exp_pack_doorbreach");
	level._effect["_breach_doorbreach_kick"] = loadfx("fx/dust/door_kick");
	level.scr_sound["breach_wooden_door"] = "detpack_explo_main";
	level.scr_sound["breach_wood_door_kick"] = "wood_door_kick";
	common_scripts\utility::func_3385("begin_the_breach");
}

//Function Number: 2
breach_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("breach_abort");
	if(isdefined(param_05) && param_05 == 0)
	{
		level.var_32D4["scripted"] = ::breach_fire_straight;
	}

	self.var_3414 = 0;
	self.var_1D9F = undefined;
	self.var_DF8 = undefined;
	self.breached = 0;
	self.breachers = 0;
	self.var_17B0 = 0;
	self.var_7564 = 0;
	self.var_63D8 = 0;
	self.aiareintheroom = 0;
	self.abouttobebreached = 0;
	self.var_1D3A = 0;
	self.var_4009 = 1;
	self.var_400C = 0;
	self.hostilesspawned = 0;
	var_06 = getentarray(self.targetname,"targetname");
	var_07 = self.targetname;
	self.var_6AB6 = "badplace_" + var_07;
	self.badplace = getent("badplace_" + var_07,"targetname");
	if(isdefined(self.badplace))
	{
	}

	self.var_17B9 = getent("trigger_" + var_07,"targetname");
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(isdefined(self.var_17B9))
	{
		switch(self.var_17B9.classname)
		{
			case "trigger_use":
				self.var_83B9 = param_02;
				break;

			case "trigger_use_touch":
				self.var_83B9 = param_02;
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
			self.var_4009 = 0;
			self.var_400C = 1;
			break;

		default:
			break;
	}

	if(self.var_4009 == 1)
	{
		self.var_2BE8 = getent(self.script_linkto,"script_linkname");
		if(self.var_2BE8.classname == "script_model")
		{
			self.var_DF8 = spawn("script_origin",self.var_2BE8.origin);
			self.var_DF8.angles = self.var_2BE8.angles;
		}
		else if(self.var_2BE8.classname == "script_brushmodel")
		{
			self.var_DF8 = getent(self.var_2BE8.target,"targetname");
			self.var_2BE8.var_8875 = anglestoforward(self.var_DF8.angles);
		}

		self.var_DF8.type = "Cover Right";
		self.var_2BE9 = getent(self.var_2BE8.script_linkto,"script_linkname");
		self.var_43EF = self.var_2BE9.script_exploder;
	}
	else if(self.var_4009 == 0)
	{
		self.var_DF8 = getent(self.script_linkto,"script_linkname");
	}

	if(self.var_400C == 1)
	{
		self.grenadeorigin = getent("flashthrow_" + var_07,"targetname");
		self.var_3DAF = getent(self.grenadeorigin.target,"targetname");
	}

	thread breach_abort(param_00);
	thread breach_cleanup(param_00);
	thread func_1784(param_01,param_04);
	var_08 = 0;
	for(var_09 = 0;var_09 < param_00.size;var_09++)
	{
		if(isdefined(param_00[var_09].var_3363))
		{
			var_08++;
			self.var_1D9F = param_00[var_09];
		}
	}

	if(var_08 > 0)
	{
	}
	else
	{
		self.var_1D9F = common_scripts\utility::func_3A56(self.var_DF8.origin,param_00);
	}

	if(param_00.size == 1)
	{
		self.var_7564 = 1;
	}

	for(var_09 = 0;var_09 < param_00.size;var_09++)
	{
		param_00[var_09] thread breacher_think(self,param_01,param_05);
	}

	while(self.breachers < param_00.size)
	{
		wait(0.05);
	}

	self notify("ready_to_breach");
	self.var_63D8 = 1;
	if(isdefined(self.var_17B9))
	{
		self.var_17B9 thread func_17A0(self);
		self waittill("execute_the_breach");
	}
	else
	{
		self notify("execute_the_breach");
	}

	common_scripts\utility::flag_set("begin_the_breach");
	self.abouttobebreached = 1;
	if(isdefined(param_03) && param_03 == 1)
	{
		var_0A = getentarray("hostiles_" + var_07,"targetname");
		self waittill("spawn_hostiles");
		func_7864(var_0A);
		self.hostilesspawned = 1;
	}

	if(isdefined(self.badplace))
	{
		badplace_cylinder(self.var_6AB6,-1,self.badplace.origin,self.badplace.radius,200,"bad_guys");
	}

	var_0B = function_016B("bad_guys");
	var_0C = [];
	for(var_09 = 0;var_09 < var_0B.size;var_09++)
	{
		if(var_0B[var_09] istouching(self))
		{
			var_0C[var_0C.size] = var_0B[var_09];
		}
	}

	if(var_0C.size > 0)
	{
		common_scripts\utility::func_F1B(var_0C,::breach_enemies_stunned,self);
	}

	while(!self.aiareintheroom)
	{
		wait(0.05);
	}

	self notify("breach_complete");
	if(!var_0C.size)
	{
	}

	while(!self.var_1D3A)
	{
		wait(0.05);
		for(var_09 = 0;var_09 < var_0C.size;var_09++)
		{
			if(!isalive(var_0C[var_09]))
			{
				var_0C = common_scripts\utility::array_remove(var_0C,var_0C[var_09]);
			}

			if(var_0C.size == 0)
			{
				self.var_1D3A = 1;
			}
		}
	}
}

//Function Number: 3
breach_dont_fire()
{
	while(self.breaching == 1)
	{
		self waittillmatch("fire","single anim");
		self.a.lastshoottime = gettime();
	}
}

//Function Number: 4
breacher_think(param_00,param_01,param_02)
{
	self.breaching = 1;
	self.breachdonotfire = undefined;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	self method_8222(1);
	thread func_3CB2();
	param_00 endon("breach_abort");
	self.var_2D50 = "stop_idle_" + self getentitynumber();
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	if(self == param_00.var_1D9F)
	{
		var_03 = "01";
	}
	else
	{
		var_03 = "02";
	}

	if(param_00.var_7564 == 1 && param_01 == "explosive_breach_left")
	{
		var_03 = "02";
	}

	switch(param_01)
	{
		case "explosive_breach_left":
			if(isdefined(self.var_87A7) && self.var_87A7 == 0)
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
			if(param_00.var_7564 == 1)
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
	if(!isdefined(self.var_87A7) || self.var_87A7)
	{
		param_00.var_DF8 maps\_anim::anim_generic_reach(self,var_04);
	}
	else
	{
		self.scriptedarrivalent = param_00.var_DF8;
		param_00.var_DF8 maps\_anim::anim_generic_reach_and_arrive(self,var_04);
	}

	param_00.var_DF8 maps\_anim::func_D64(self,var_04);
	param_00.var_DF8 thread maps\_anim::anim_generic_loop(self,var_05,self.var_2D50);
	self.var_7043 = self.origin;
	param_00.breachers++;
	self.scriptedarrivalent = undefined;
	param_00 waittill("execute_the_breach");
	if(!param_00.var_3414 && isdefined(var_07))
	{
		param_00.var_DF8 notify(self.var_2D50);
		param_00.var_DF8 thread maps\_anim::func_D64(self,var_07);
		wait(1);
		if(var_03 == "02" || param_00.var_7564 == 1)
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

			if(param_00.var_7564 == 1 && var_03 == "01")
			{
				self waittillmatch("fire","single anim");
			}

			self method_8306(param_00.grenadeorigin.origin,param_00.var_3DAF.origin,level.iflashfuse);
			self detach("projectile_m84_flashbang_grenade",var_08);
			self.grenadeweapon = var_09;
			self.grenadeammo = 0;
		}

		self waittillmatch("end","single anim");
		param_00.var_DF8 thread maps\_anim::anim_generic_loop(self,var_05,self.var_2D50);
		wait(0.1);
	}

	param_00.var_DF8 notify(self.var_2D50);
	if(param_02 == 0)
	{
		self.breachdonotfire = 1;
	}

	param_00.var_DF8 thread maps\_anim::func_D64(self,var_06);
	if(param_01 == "explosive_breach_left")
	{
		if(var_03 == "02")
		{
			thread func_26BE(param_00);
			self waittillmatch("pull fuse","single anim");
			wait(1);
			param_00 notify("spawn_hostiles");
			param_00 notify("detpack_about_to_blow");
			self waittillmatch("explosion","single anim");
			param_00 notify("detpack_detonated");
			param_00.breached = 1;
			param_00.var_2BE8 thread func_29D0("explosive",param_00);
			param_00 notify("play_breach_fx");
		}
	}
	else if(param_01 == "shotgunhinges_breach_left")
	{
		if(var_03 == "01")
		{
			param_00 notify("spawn_hostiles");
			self waittillmatch("kick","single anim");
			param_00.var_2BE8 thread func_29D0("shotgun",param_00);
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
		self.breachdonotfire = undefined;
	}

	if(isdefined(level.friendly_breach_thread))
	{
		self thread [[ level.friendly_breach_thread ]](param_00);
	}

	param_00.aiareintheroom = 1;
	self method_8222(0);
	func_178D();
	while(!param_00.var_1D3A)
	{
		wait(0.05);
	}

	self.breaching = 0;
}

//Function Number: 5
breach_fire_straight()
{
	if(isdefined(self.breachdonotfire))
	{
	}

	animscripts/notetracks::func_32E8();
}

//Function Number: 6
func_26BE(param_00)
{
	thread func_7705(param_00);
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
func_7705(param_00)
{
	self waittillmatch("sound effect","single anim");
	thread common_scripts\utility::func_5D1F("detpack_plant_arming",param_00.var_DF8.origin);
}

//Function Number: 8
breach_enemies_stunned(param_00)
{
	self endon("death");
	param_00 endon("breach_aborted");
	param_00 waittill("detpack_detonated");
	if(distance(self.origin,param_00.var_DF8.origin) <= level.detpackstunradius)
	{
		level.var_7D1B++;
		if(level.var_7D1B > 2)
		{
			level.var_7D1B = 1;
		}

		var_01 = "exposed_flashbang_v" + level.var_7D1B;
		self.allowdeath = 1;
		maps\_anim::func_D65(self,"gravity",var_01);
		func_178D();
	}
}

//Function Number: 9
func_17A0(param_00)
{
	param_00 endon("execute_the_breach");
	param_00 endon("breach_aborted");
	thread breach_trigger_cleanup(param_00);
	self waittill("trigger");
	param_00 notify("execute_the_breach");
}

//Function Number: 10
breach_trigger_cleanup(param_00)
{
	param_00 waittill("execute_the_breach");
	common_scripts\utility::trigger_off();
	if(isdefined(param_00.ebreachmodel))
	{
		param_00.ebreachmodel delete();
	}
}

//Function Number: 11
breach_abort(param_00)
{
	self endon("breach_complete");
	self waittill("breach_abort");
	self.var_1D3A = 1;
	thread breach_cleanup(param_00);
}

//Function Number: 12
breach_cleanup(param_00)
{
	while(!self.var_1D3A)
	{
		wait(0.05);
	}

	if(isdefined(self.badplace))
	{
		badplace_delete(self.var_6AB6);
	}

	while(!self.var_1D3A)
	{
		wait(0.05);
	}

	common_scripts\utility::func_F1B(param_00,::func_171F,self);
}

//Function Number: 13
func_171F(param_00)
{
	self endon("death");
	func_178D();
	breach_reset_goaladius();
	param_00.var_DF8 notify(self.var_2D50);
	self notify("stop_infinite_ammo");
	self method_8222(0);
}

//Function Number: 14
func_1784(param_00,param_01)
{
	self endon("breach_aborted");
	self endon("breach_complete");
	switch(param_00)
	{
		case "explosive_breach_left":
			self waittill("play_breach_fx");
			common_scripts\utility::exploder(self.var_43EF);
			thread common_scripts\utility::func_5D1F(level.scr_sound["breach_wooden_door"],self.var_2BE9.origin);
			if(param_01)
			{
				playfx(level._effect["_breach_doorbreach_detpack"],self.var_2BE9.origin,anglestoforward(self.var_2BE9.angles));
			}
			break;

		case "shotgunhinges_breach_left":
			self waittill("play_breach_fx");
			common_scripts\utility::exploder(self.var_43EF);
			if(param_01)
			{
				playfx(level._effect["_breach_doorbreach_kick"],self.var_2BE9.origin,anglestoforward(self.var_2BE9.angles));
			}
			break;

		case "flash_breach_no_door_right":
			break;

		default:
			break;
	}
}

//Function Number: 15
func_78A6(param_00)
{
	var_01 = param_00 method_82CD();
	maps\_utility::func_77BE(var_01);
	return var_01;
}

//Function Number: 16
func_7864(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = func_78A6(param_00[var_02]);
		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 17
func_3CB2()
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
		wait(0.5);
	}
}

//Function Number: 18
func_29D0(param_00,param_01,param_02)
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
			thread door_fall_over(param_01.var_DF8);
			func_29C2();
			self playsound(level.scr_sound["breach_wooden_door"]);
			earthquake(0.4,1,self.origin,1000);
			radiusdamage(self.origin,56,level.maxdetpackdamage,level.mindetpackdamage);
			break;

		case "shotgun":
			thread door_fall_over(param_01.var_DF8);
			func_29C2();
			self playsound(level.scr_sound["breach_wooden_door"]);
			break;
	}
}

//Function Number: 19
func_29C2()
{
	if(self.classname == "script_brushmodel")
	{
		self connectpaths();
	}

	var_00 = getent(self.target,"targetname");
	var_00 hide();
	var_00 notsolid();
	var_00 connectpaths();
}

//Function Number: 20
door_fall_over(param_00)
{
	var_01 = undefined;
	if(self.classname == "script_model")
	{
		var_01 = anglestoforward(self.angles);
	}
	else if(self.classname == "script_brushmodel")
	{
		var_01 = self.var_8875;
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
	wait(0.45);
	var_03 rotatepitch(-4,0.2,0,0.2);
	wait(0.2);
	var_03 rotatepitch(4,0.15,0.15);
	wait(0.15);
	self unlink();
	var_03 delete();
}

//Function Number: 21
breach_set_goaladius(param_00)
{
	if(!isdefined(self.var_5899))
	{
		self.var_5899 = self.goalradius;
	}

	self.goalradius = param_00;
}

//Function Number: 22
breach_reset_goaladius()
{
	if(isdefined(self.var_5899))
	{
		self.goalradius = self.var_5899;
	}

	self.var_5899 = undefined;
}

//Function Number: 23
func_1792(param_00)
{
	if(!isdefined(self.var_588D))
	{
		self.var_588D = self.animname;
	}

	self.animname = param_00;
}

//Function Number: 24
func_178D()
{
	if(isdefined(self.var_588D))
	{
		self.animname = self.var_588D;
	}

	self.var_588D = undefined;
}