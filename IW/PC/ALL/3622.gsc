/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3622.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 12:30:57 AM
*******************************************************************/

//Function Number: 1
func_972B()
{
	setdvarifuninitialized("debug_seeker",0);
	level.var_F10A = spawnstruct();
	level.var_F10A.var_1157E = [];
	level.var_F10A.var_1633 = [];
	level.var_F10A.var_162D = [];
	level.var_F10A.var_A8C6 = undefined;
	level.player.var_F179 = spawnstruct();
	level.player.var_F179.var_45BF = 0;
	level.player.var_F179.var_9076 = 0;
	level.var_F10A.var_4D19 = 128;
	level.var_F10A.var_4D0C = 200;
	level.var_F10A.var_4D02 = 550;
	level.var_F10A.var_B41A = 4;
	scripts\common\utility::flag_init("seeker_force_delete");
	scripts\sp\_utility::func_9189("default_seeker",3,"default");
}

//Function Number: 2
func_F135(param_00)
{
	if(level.var_F10A.var_1633.size >= level.var_F10A.var_B41A)
	{
		func_A5FB();
	}

	var_01 = undefined;
	if(self == level.player && isdefined(level.player.var_AF29))
	{
		var_01 = level.player.var_AF29;
		level.player.var_AF29 = undefined;
	}

	var_02 = scripts\common\utility::spawn_tag_origin();
	var_02.origin = param_00.origin;
	var_02 linkto(param_00);
	var_02.var_15F = param_00;
	level.var_F10A.var_162D[level.var_F10A.var_162D.size] = var_02;
	param_00 thread func_F136();
	var_03 = var_02.var_15F scripts\common\utility::func_13734("missile_stuck","death","entitydeleted");
	if(!isdefined(var_02.var_15F))
	{
		var_02 thread func_E085();
		return;
	}

	if(var_03 == "missile_stuck")
	{
		func_107D1(var_02,undefined,undefined,var_01);
	}

	if(level.player.var_F179.var_45BF)
	{
		level thread func_B9CD();
	}

	var_02 thread func_E085();
}

//Function Number: 3
func_F136()
{
	self endon("death");
	wait(5);
	self delete();
}

//Function Number: 4
func_E085()
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_15F))
	{
		level.var_F10A.var_A8C6 = self.var_15F.origin;
		self.var_15F unlink();
		self.var_15F delete();
	}

	if(scripts\common\utility::flag("seeker_force_delete"))
	{
		scripts\common\utility::func_136F7();
	}

	if(isdefined(self))
	{
		level.var_F10A.var_162D = scripts\common\utility::func_22A9(level.var_F10A.var_162D,self);
		self delete();
	}
}

//Function Number: 5
func_A5FB()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in level.var_F10A.var_1633)
	{
		if(var_01 == 0 || var_03.var_10DFF < var_01)
		{
			var_01 = var_03.var_10DFF;
			var_00 = var_03;
		}
	}

	if(isdefined(var_00))
	{
		var_00.var_EA0E = 1;
		if(isdefined(var_00.var_F166))
		{
			stopfxontag(level.var_7649[var_00.var_F166],var_00,"tag_fx");
		}

		if(isdefined(var_00.var_B14F))
		{
			var_00 scripts\sp\_utility::func_1101B();
		}

		playfxontag(level.var_7649["seeker_sparks"],var_00,"tag_fx");
		function_0178("seeker_expire",var_00.origin);
		var_00 method_818B();
		var_00 method_81D0();
	}
}

//Function Number: 6
func_DFC1()
{
	level notify("removing_all_seekers_instantly");
	level endon("removing_all_seekers_instantly");
	scripts\common\utility::flag_set("seeker_force_delete");
	foreach(var_01 in level.var_F10A.var_162D)
	{
		var_01 thread func_E085();
	}

	foreach(var_04 in level.var_F10A.var_1633)
	{
		var_04 thread func_E084();
	}

	for(;;)
	{
		if(level.var_F10A.var_162D.size > 0 || level.var_F10A.var_1633.size > 0)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		break;
	}

	scripts\common\utility::func_6E2A("seeker_force_delete");
}

//Function Number: 7
func_107D1(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_04 = getclosestpointonnavmesh(param_00.origin,undefined,1);
	var_05 = distancesquared(var_04,param_00.origin);
	if(var_05 > squared(250))
	{
		return;
	}

	var_06 = getspawner("actor_ally_equipment_seeker","classname");
	var_06.origin = param_00.origin;
	if(isdefined(param_02))
	{
		var_06.origin = var_06.origin + param_02;
	}

	var_06.angles = self.angles;
	var_06.var_C1 = var_06.var_C1 + 1;
	var_07 = var_06 func_F15A();
	if(!isdefined(var_07))
	{
		return;
	}

	var_07.var_222 = self;
	if(isdefined(param_01) && param_01 == 1)
	{
		var_07.var_C93D = 1;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "no_expire")
	{
		self.var_595E = 1;
	}

	if(!isdefined(var_07.var_C93D))
	{
		var_07.team = var_07.var_222.team;
	}

	self.var_F10A = var_07;
	if(isdefined(param_03))
	{
		var_07.var_12E = param_03;
	}

	var_07 thread func_F159();
	if(isdefined(level.var_F10A.var_4C74))
	{
		var_07 thread [[ level.var_F10A.var_4C74 ]]();
	}

	level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_07;
	return var_07;
}

//Function Number: 8
func_107D2(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getspawner("actor_ally_equipment_seeker","classname");
	var_05.origin = param_00;
	var_05.angles = param_01;
	var_05.var_C1 = var_05.var_C1 + 1;
	var_06 = var_05 func_F15A();
	if(!isdefined(var_06))
	{
		return;
	}

	var_06.var_222 = var_06;
	var_06.team = param_02;
	if(isdefined(param_03))
	{
		var_06.var_728A = param_03;
	}

	if(isdefined(param_04))
	{
		var_06.var_5967 = param_04;
	}

	var_06 thread func_F159();
	level.var_F10A.var_1633[level.var_F10A.var_1633.size] = var_06;
	return var_06;
}

//Function Number: 9
func_F12A()
{
	self endon("death");
	var_00 = 0;
	var_01 = 5;
	for(;;)
	{
		if(!self islinked())
		{
			var_02 = self method_812B();
			if(var_02 == "none")
			{
				var_00++;
				if(var_00 > 4 * var_01)
				{
					self delete();
				}
			}
			else
			{
				var_00 = 0;
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.25);
	}
}

//Function Number: 10
func_F15A()
{
	level endon("seeker_force_delete");
	if(scripts\common\utility::flag("seeker_force_delete"))
	{
		return undefined;
	}

	var_00 = 0;
	while(isdefined(self.var_9C20))
	{
		wait(0.05);
		var_00++;
		if(var_00 > 5)
		{
			return undefined;
		}
	}

	var_01 = undefined;
	self.var_9C20 = 1;
	self.var_C1 = self.var_C1 + 1;
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_01 = self method_8393();
		if(!isdefined(var_01))
		{
			wait(0.05);
			continue;
		}

		break;
	}

	self.var_9C20 = undefined;
	return var_01;
}

//Function Number: 11
func_10679(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	wait(param_00);
	if(self.team == "allies" || self.team == "neutral")
	{
		var_03 = "axis";
	}
	else
	{
		var_03 = "allies";
	}

	return func_107D2(param_01,param_02,var_03,self);
}

//Function Number: 12
func_F162()
{
	self endon("death");
	self endon("seeker_unequipped");
	if(!level.player.var_F179.var_9076)
	{
		return;
	}

	thread func_F165();
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(var_00 != "seeker")
		{
			continue;
		}

		self.var_AF29 = undefined;
		childthread func_F161();
		self waittill("offhand_end");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
func_F165()
{
	self endon("death");
	self endon("stop_seeker_unequipped_think");
	self notify("seeker_unequipped_think");
	self endon("seeker_unequipped_think");
	self waittill("primary_equipment_change");
	if(!scripts\sp\_utility::func_93A6())
	{
		self method_8438();
	}

	self notify("seeker_unequipped");
}

//Function Number: 14
func_F160()
{
	scripts\common\utility::waittill_either("offhand_end","offhand_ammo");
	wait(0.05);
	if(isdefined(self.var_AF29))
	{
		self.var_AF29 scripts\sp\_utility::func_9193("default_seeker");
		self.var_AF29 = undefined;
	}
}

//Function Number: 15
func_F161()
{
	self endon("offhand_end");
	self endon("offhand_ammo");
	thread func_F160();
	wait(1.5);
	for(;;)
	{
		var_00 = func_F07D();
		if(isdefined(var_00))
		{
			if(isdefined(self.var_AF29) && var_00 != self.var_AF29)
			{
				self.var_AF29 scripts\sp\_utility::func_9193("default_seeker");
			}

			var_00 scripts\sp\_utility::func_9196(1,0,0,"default_seeker");
			self.var_AF29 = var_00;
			wait(0.5);
		}
		else if(isdefined(self.var_AF29))
		{
			self.var_AF29 scripts\sp\_utility::func_9193("default_seeker");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 16
func_10793()
{
	var_00 = func_F15A();
	var_00.var_C93D = 1;
	var_00 thread func_F159();
}

//Function Number: 17
func_F159()
{
	if(isdefined(self.var_C93D))
	{
		self.team = "team3";
		if(isdefined(self.target))
		{
			thread lib_0B77::func_8409();
		}
	}

	self.var_F166 = "seeker_" + self.team;
	playfxontag(level.var_7649[self.var_F166],self,"tag_fx");
	self.var_BC = "no_cover";
	self.name = "";
	self.var_163 = 0;
	self.var_1491.var_5605 = 1;
	self.allowpain = 0;
	self.var_10264 = 1;
	self.var_28CF = 0;
	self.var_B5DD = 1;
	self.var_186 = 1;
	self.var_5963 = 1;
	self.var_231 = 8;
	self.var_232 = 8;
	self.maxsightdistsqrd = 0;
	self.var_1FD = 0;
	self.var_132 = 0;
	self.var_55B5 = 1;
	self.var_55EF = 1;
	self.var_F7 = 0;
	self.var_C012 = 1;
	self.var_2745 = [];
	self.var_2A4B = 1;
	self.var_733D = 0;
	self method_84E5(0);
	if(isdefined(self.var_C93D))
	{
		self.ignoreme = 1;
	}

	if(self.var_222 == level.player)
	{
		self.health = 3000;
		thread scripts\sp\_utility::func_B14F(1);
	}
	else
	{
		self.health = 50;
	}

	if(level.var_7683 == 0 && self.var_222 != level.player)
	{
		thread func_F169();
	}

	func_F13A();
	thread scripts\sp\_utility::func_CE2F("seeker_init");
	thread scripts\common\utility::func_CD7F("seeker_seek_lp");
	thread func_BC0A();
	thread func_F137();
	thread func_F114();
	thread func_F12A();
	thread func_F115();
	thread func_6C95();
	if(self.var_222 == level.player)
	{
		thread func_F14C();
	}
}

//Function Number: 18
func_F115()
{
	scripts\common\utility::waittill_either("death","entitydeleted");
	if(isdefined(self.var_A481))
	{
		self.var_A481 delete();
	}
}

//Function Number: 19
func_F13A()
{
	if(self.var_222 == level.player)
	{
		self.var_BCD6 = 1;
		return;
	}

	if(level.var_7683 <= 1)
	{
		self.var_BCD6 = 0.65;
		return;
	}

	self.var_BCD6 = 0.75;
}

//Function Number: 20
func_F114()
{
	self endon("death");
	for(;;)
	{
		function_00F3(self.origin,25,1000,1000);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 21
func_8BA7()
{
	if(level.player hasweapon("seeker"))
	{
		return "current";
	}

	var_00 = scripts\sp\_utility::func_7CAF();
	if(!isdefined(var_00))
	{
		return "no";
	}

	if(var_00 == "seeker")
	{
		return "stored";
	}

	return "no";
}

//Function Number: 22
func_F16B()
{
	self endon("death");
	for(;;)
	{
		scripts\common\utility::func_136F7();
		var_00 = func_8BA7();
		if(var_00 == "no")
		{
			self notify("no_inventory");
			continue;
		}

		var_01 = 0;
		if(var_00 == "current")
		{
			var_01 = scripts\sp\_utility::func_7BD7();
		}
		else if(var_00 == "stored")
		{
			var_01 = scripts\sp\_utility::func_7CB0();
		}

		if(var_01 == 4)
		{
			self notify("max_ammo");
			continue;
		}
	}
}

//Function Number: 23
func_F14C()
{
	self endon("death");
	if(isdefined(self.var_C93D))
	{
		return;
	}

	var_00 = 0;
	childthread func_F16B();
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(isdefined(self.var_3135.var_F15D) && self.var_3135.var_F15D != self.var_222)
		{
			continue;
		}

		var_01 = func_8BA7();
		if(var_01 == "no")
		{
			continue;
		}

		var_02 = 0;
		if(var_01 == "current")
		{
			var_02 = scripts\sp\_utility::func_7BD7();
		}
		else if(var_01 == "stored")
		{
			var_02 = scripts\sp\_utility::func_7CB0();
		}

		if(var_02 == 4)
		{
			continue;
		}

		thread lib_0E46::func_48C4("tag_origin",(0,0,25),&"EQUIPMENT_SEEKER_RETRIEVE",undefined,60,50,undefined,undefined,undefined,&"hud_interaction_prompt_center_equipment",undefined,undefined,undefined,undefined,90);
		var_00 = 1;
		var_03 = scripts\common\utility::func_13734("trigger","max_ammo","no_inventory","set_bt_target");
		if(var_03 == "trigger")
		{
			break;
		}
		else
		{
			if(var_00)
			{
				lib_0E46::func_DFE3();
			}

			continue;
		}
	}

	function_0178("player_refill_all_ammo",level.player.origin);
	var_01 = func_8BA7();
	var_02 = 0;
	if(var_01 == "current")
	{
		var_02 = scripts\sp\_utility::func_7BD7();
		level.player setweaponammoclip("seeker",var_02 + 1);
	}
	else if(var_01 == "stored")
	{
		var_02 = scripts\sp\_utility::func_7CB0();
		level.player.var_110BE++;
	}

	func_E084();
}

//Function Number: 24
func_E084()
{
	self.var_EA0E = 1;
	if(isdefined(self.var_F166))
	{
		stopfxontag(level.var_7649[self.var_F166],self,"tag_fx");
		self.var_F166 = undefined;
	}

	if(isdefined(self.var_B55B))
	{
		self method_8484();
		if(isdefined(self.var_B55B))
		{
			if(isdefined(self.var_B55B.target))
			{
				self.var_B55B.target.var_B55B = undefined;
			}

			self.var_B55B = undefined;
		}
	}

	self notify("stop soundseeker_target_acquire_lp");
	self notify("stop soundseeker_move_lp");
	self notify("stop soundseeker_move_servo_lp");
	level.var_F10A.var_1633 = scripts\common\utility::func_22A9(level.var_F10A.var_1633,self);
	if(isplayer(self.var_222))
	{
		var_00 = level.player func_7B02();
		if(!var_00.size)
		{
			level.var_F10A.var_5AE6 = undefined;
			level.player notify("stop_monitoring_doubletap");
		}
	}

	self delete();
}

//Function Number: 25
func_F169()
{
	level.player endon("death");
	for(;;)
	{
		if(!isalive(self))
		{
			return;
		}

		if(isdefined(self.var_3135) && isdefined(self.var_3135.var_F15D))
		{
			if(self.var_3135.var_F15D == level.player)
			{
				if(distance2dsquared(self.origin,level.player getorigin()) < squared(800))
				{
					self.var_138F2 = newhudelem();
					var_00 = scripts\common\utility::spawn_tag_origin(self.origin + (0,0,30));
					var_00 linkto(self);
					self.var_138F2 setshader("hud_icon_grenade_incoming_seeker",32,32);
					self.var_138F2.color = (1,1,1);
					self.var_138F2.alpha = 1;
					self.var_138F2 setwaypoint(1,1,0);
					self.var_138F2 settargetent(var_00);
					scripts\common\utility::waittill_either("jumped_on_player","death");
					self.var_138F2 destroy();
					var_00 delete();
					return;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 26
func_F137()
{
	if(isdefined(self.var_C93D) || isdefined(self.var_5967) && self.var_5967)
	{
		return;
	}

	if(self.team == "allies")
	{
		scripts\sp\_utility::func_9196(3,0,0,"default_seeker");
		return;
	}

	if(self.team == "axis")
	{
		scripts\sp\_utility::func_9196(1,1,1,"default_seeker");
	}
}

//Function Number: 27
func_BC0A()
{
	self endon("death");
	for(;;)
	{
		func_BC73();
		while(self.var_164D["seeker"].var_4BC0 != "run_loop")
		{
			wait(0.05);
		}

		func_BC72();
		while(self.var_164D["seeker"].var_4BC0 == "run_loop")
		{
			wait(0.05);
		}
	}
}

//Function Number: 28
func_BC72()
{
	self playsound("seeker_move_start","sound_done");
	self waittill("sound_done");
	thread scripts\common\utility::func_CD7F("seeker_move_lp");
	thread scripts\common\utility::func_CD7F("seeker_move_servo_lp");
}

//Function Number: 29
func_BC73()
{
	self notify("stop soundseeker_move_lp");
	self notify("stop soundseeker_move_servo_lp");
	self playsound("seeker_move_end","sound_done");
	self waittill("sound_done");
}

//Function Number: 30
func_B9CD()
{
	if(isdefined(self.var_C93D))
	{
		return;
	}

	if(isdefined(level.var_F10A.var_5AE6))
	{
		return;
	}

	level.var_F10A.var_5AE6 = 1;
	level.player endon("stop_monitoring_doubletap");
	var_00 = 0;
	var_01 = 0.3;
	for(;;)
	{
		if(level.player usebuttonpressed())
		{
			var_00 = 0;
			while(level.player usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= var_01)
			{
				continue;
			}

			var_00 = 0;
			while(!level.player usebuttonpressed() && var_00 < var_01)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= var_01)
			{
				continue;
			}

			func_2BCF(level.player);
			level.var_F10A.var_5AE6 = undefined;
			level.player notify("stop_monitoring_doubletap");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 31
func_2BCF(param_00)
{
	foreach(var_02 in level.var_F10A.var_1633)
	{
		if(var_02.var_222 == param_00)
		{
			if(isdefined(var_02.var_9BB9))
			{
				continue;
			}

			var_02.var_9BB9 = 1;
			var_02 thread func_F11E(1);
		}
	}
}

//Function Number: 32
func_7B02()
{
	var_00 = [];
	foreach(var_02 in level.var_F10A.var_1633)
	{
		if(var_02.var_222 == self)
		{
			if(isdefined(var_02.var_9BB9))
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 33
func_F11C()
{
	self endon("seeker_detonate_finish");
	self.var_50EB = 1;
	wait(0.4);
	if(!isdefined(self) || isdefined(self.var_9BB9))
	{
		return;
	}

	function_0178("seeker_expl_beep",self.origin);
	wait(0.6);
	if(!isdefined(self) || isdefined(self.var_9BB9))
	{
		return;
	}

	self.var_9BB9 = 1;
	thread func_F11E();
}

//Function Number: 34
func_F11E(param_00,param_01,param_02)
{
	if(isdefined(self))
	{
		function_0278("ent_" + self getentitynumber() + "_seeker_repulsor");
		if(isdefined(self.var_F166))
		{
			stopfxontag(level.var_7649[self.var_F166],self,"tag_fx");
			self.var_F166 = undefined;
		}

		if(isdefined(self.var_EA0E))
		{
			return;
		}

		if(!isdefined(param_00))
		{
			thread func_F11D();
		}

		var_03 = self gettagorigin("j_body") + (0,0,2);
		if(isdefined(param_01))
		{
			var_03 = param_01;
		}

		if(isdefined(self.var_222) && level.player == self.var_222)
		{
			var_04 = self.var_222 scripts\sp\_detonategrenades::func_734E();
			self.var_222 scripts\common\utility::func_5127(0.1,::scripts\sp\_detonategrenades::func_734D,var_03,var_04,level.var_F10A.var_4D19);
		}

		self notify("seeker_detonate_finish",var_03);
		self notify("stop soundseeker_target_acquire_lp");
		if(self.health > 0 || isdefined(param_02))
		{
			if(isalive(self) && isdefined(self))
			{
				self.var_166 = "seeker_expl";
				self method_81EE(var_03,(0,0,0),0);
			}
			else
			{
				function_0136("seeker_expl",var_03,(0,0,0),0);
			}

			if(isalive(self))
			{
				self hide();
			}

			wait(0.1);
			physicsexplosionsphere(var_03,1000,100,2);
			thread scripts\sp\_detonategrenades::func_DBDB(var_03 + (0,0,5),0.2);
			earthquake(0.5,0.8,var_03,250);
			thread scripts\sp\_utility::func_54EF(var_03);
			thread func_F110(250,var_03);
			wait(0.5);
			if(!isdefined(self))
			{
				return;
			}

			if(isdefined(self.var_B14F))
			{
				scripts\sp\_utility::func_1101B();
			}

			if(isalive(self))
			{
				self method_81D0();
			}

			self delete();
		}

		wait(0.75);
	}
}

//Function Number: 35
func_F129(param_00)
{
	var_01 = function_0072("axis","allies");
	var_01[var_01.size] = level.player;
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(distance(param_00,var_04.origin) <= level.var_F10A.var_4D19)
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in var_02)
	{
		if(isplayer(var_04) && scripts\sp\_detonategrenades::func_385D(param_00))
		{
			func_57BB(param_00,var_04);
		}

		if(scripts\sp\_detonategrenades::func_385C(param_00,var_04))
		{
			func_57BB(param_00,var_04);
		}
	}
}

//Function Number: 36
func_57BB(param_00,param_01)
{
	var_02 = distance2d(param_01.origin,param_00);
	var_03 = lib_0B4D::func_C097(0,level.var_F10A.var_4D19,var_02);
	var_04 = lib_0B4D::func_6A8E(level.var_F10A.var_4D0C,level.var_F10A.var_4D02,var_03);
	if(isdefined(param_01.var_12BA4))
	{
		var_05 = tolower(param_01.var_12BA4);
		if(var_05 == "c6")
		{
			var_04 = var_04 * 3;
		}
		else if(var_05 == "c8")
		{
			var_04 = var_04 * 3;
		}
		else if(var_05 == "c12")
		{
			var_04 = var_04 * 3;
		}
	}

	param_01 dodamage(var_04,self.origin,self,self,"MOD_EXPLOSIVE","seeker");
}

//Function Number: 37
func_F11D()
{
	scripts\common\utility::play_sound_in_space("seeker_expl_beep",self.origin);
}

//Function Number: 38
func_F110(param_00,param_01)
{
	if(level.player scripts\sp\_utility::func_65DB("no_grenade_block_gesture") || level.player method_81C6() || level.player method_8448())
	{
		return;
	}

	var_02 = distance2dsquared(level.player.origin,param_01);
	if(var_02 > squared(param_00))
	{
		return;
	}

	if(var_02 > squared(param_00 * 0.25))
	{
		var_03 = vectordot(scripts\common\utility::func_6EE6(vectornormalize(param_01 - level.player.origin)),anglestoforward(level.player.angles));
		if(var_03 < 0)
		{
			return;
		}
	}

	if(!scripts\common\trace::func_DCF1(param_01 + (0,0,12),level.player geteye(),undefined,scripts\common\trace::func_497D()))
	{
		return;
	}

	level.player thread func_F155(param_01);
}

//Function Number: 39
func_F155(param_00)
{
	self endon("death");
	var_01 = scripts\common\utility::spawn_tag_origin(param_00,(0,0,0));
	thread scripts\common\utility::func_5179(var_01);
	var_02 = "ges_frag_block";
	var_03 = self playgestureviewmodel(var_02,var_01,1,0.1);
	if(var_03)
	{
		childthread lib_0E49::func_D092(var_02,0,0,0,0,1,0,1,0,0,1,0,1.4);
		for(;;)
		{
			self waittill("gesture_stopped",var_02);
			if(var_02 == "ges_frag_block")
			{
				break;
			}
		}
	}

	var_01 delete();
}

//Function Number: 40
func_F14D(param_00)
{
	if(param_00)
	{
		if(isdefined(self.var_222) && !isplayer(self.var_222))
		{
			return;
		}

		if(isdefined(self.var_C93D))
		{
			return;
		}

		if(isdefined(self.var_9BB9))
		{
			return;
		}

		if(isdefined(level.var_F14D))
		{
			return;
		}

		level.var_F14D = 1;
		self.var_CBA0 = scripts\common\utility::spawn_tag_origin();
		thread scripts\common\utility::func_5179(self.var_CBA0);
		thread func_CBA1();
		thread func_F14E();
		var_01 = (0,0,0);
		var_02 = (0,0,0);
		scripts\sp\_pip::func_CBB5(self.var_CBA0,"tag_origin",40,var_01,var_02);
		return;
	}

	scripts\sp\_pip::func_CBA3();
	level.var_F14D = undefined;
}

//Function Number: 41
func_F14E()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self.var_9BB9))
		{
			setomnvar("ui_pip_message_text_top","equipment_seeker_top");
			setomnvar("ui_pip_message_text_bottom","equipment_seeker_blownup");
			setomnvar("ui_pip_message_type",3);
		}
		else if(self.var_3135.var_1152B)
		{
			setomnvar("ui_pip_message_text_top","equipment_seeker_top");
			setomnvar("ui_pip_message_text_bottom","equipment_seeker_locked");
			setomnvar("ui_pip_message_type",3);
		}
		else if(isdefined(self.var_3135.var_F15D) && self.var_3135.var_F15D == self.var_222)
		{
			setomnvar("ui_pip_message_text_top","equipment_seeker_top");
			setomnvar("ui_pip_message_text_bottom","equipment_seeker_idle");
			setomnvar("ui_pip_message_type",1);
		}
		else
		{
			setomnvar("ui_pip_message_text_top","equipment_seeker_top");
			setomnvar("ui_pip_message_text_bottom","equipment_seeker_searching");
			setomnvar("ui_pip_message_type",2);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 42
func_CBA1()
{
	scripts\common\utility::func_136F7();
	var_00 = spawnturret("misc_turret",self.origin,"seeker_camera");
	var_00 setmodel("tag_turret");
	var_00 method_82D1(0);
	var_00 method_830F("manual");
	var_00 makeunusable();
	var_00.var_9FF0 = 1;
	var_00 method_82C9(0,"yaw");
	var_00 method_82C9(0,"pitch");
	var_01 = (2,0,7);
	if(isdefined(self.var_37B3))
	{
		var_01 = var_01 + self.var_37B3;
	}

	var_00 linkto(self,"j_spine4",var_01,(0,0,0));
	var_02 = scripts\common\utility::spawn_tag_origin();
	var_03 = scripts\common\utility::spawn_tag_origin();
	var_00 method_8347(var_03);
	self.var_CBA0 linkto(var_00,"tag_flash",(0,0,0),(0,0,0));
	while(isalive(self))
	{
		if(isdefined(self.var_7260))
		{
			var_03 linkto(self.var_7260,"tag_origin",(0,0,0),(0,0,0));
			continue;
		}

		if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_312F) && self.var_B55B.var_312F && isalive(self.var_B55B.target))
		{
			if(isdefined(self.var_2479))
			{
				var_03 linkto(self.var_B55B.target,"tag_eye",(0,0,0),(0,0,0));
			}
			else
			{
				var_03 linkto(self.var_B55B.target,"j_neck",(0,0,0),(0,0,0));
			}

			continue;
		}

		if(isalive(self.var_3135.var_F15D) && self method_805F(self.var_3135.var_F15D) || self.var_3135.var_1152B)
		{
			var_03 linkto(self.var_3135.var_F15D,"tag_eye",(0,0,0),(0,0,0));
			continue;
		}

		var_03 linkto(self,"tag_eye",(50,0,2),(0,0,0));
		wait(0.05);
	}

	var_02 delete();
	var_03 delete();
	var_00 delete();
}

//Function Number: 43
func_CBA2(param_00,param_01)
{
	var_02 = lib_0B4D::func_10AAE(10,param_00.origin,(0,0,0));
	while(isalive(self) && isdefined(param_01))
	{
		var_03 = lib_0B4D::func_10AB4(var_02,param_01.origin,param_00.origin);
		param_00.origin = var_03;
		scripts\common\utility::func_136F7();
	}

	lib_0B4D::func_10AAA(var_02);
}

//Function Number: 44
func_F11B(param_00)
{
}

//Function Number: 45
func_6C95()
{
	self endon("death");
	self.var_733D = 0;
	for(;;)
	{
		var_00 = getclosestpointonnavmesh(self.origin,self);
		var_01 = distancesquared(var_00,self.origin);
		if(var_01 <= squared(15))
		{
			self.var_733D = 1;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 46
func_7C41(param_00)
{
	if(!isdefined(self.var_728A) && !self.var_733D)
	{
		return undefined;
	}

	var_01 = gettime();
	if(self.var_3135.var_1152B || self.var_3135.var_1154B > 0 && self.var_3135.var_1154B + 700 > var_01)
	{
		return self.var_3135.var_F15D;
	}

	if(isdefined(self.var_EA0E) || isdefined(self.var_C93D) || isdefined(self.var_50EB) || isdefined(self.var_9BB9) || !isdefined(self.var_3135.var_652A))
	{
		return undefined;
	}

	if(!isdefined(self.var_3135.var_9882))
	{
		return undefined;
	}

	if(scripts\common\utility::func_6E34("stealth_enabled") && scripts\common\utility::flag("stealth_enabled"))
	{
		if(isalive(self.var_222) && self.var_222 scripts\sp\_utility::func_65DF("stealth_attack") && !self.var_222 scripts\sp\_utility::func_65DB("stealth_attack"))
		{
			return undefined;
		}
	}

	if(isdefined(self.var_12E))
	{
		return self.var_12E;
	}

	if(isdefined(self.var_728A))
	{
		return self.var_728A;
	}

	var_02 = function_0075(self.var_3135.var_652A,"all");
	if(self.var_3135.var_652A == "allies")
	{
		if(lib_0F3D::func_B575(self.var_12BA4))
		{
			var_02 = scripts\common\utility::array_add(var_02,level.player);
		}
	}

	var_03 = 1200;
	var_04 = 100;
	var_05 = [];
	foreach(var_07 in var_02)
	{
		if(var_07.ignoreme || !isalive(var_07) || isdefined(var_07.var_C012))
		{
			continue;
		}

		if(isdefined(var_07.var_2023))
		{
			continue;
		}

		if(scripts\common\utility::func_2286(self.var_2745,var_07))
		{
			continue;
		}

		if(isalive(self.var_222))
		{
			var_08 = distancesquared(self.var_222.origin,var_07.origin);
			if(var_08 < squared(var_04) || var_08 > squared(var_03))
			{
				continue;
			}
		}

		var_05 = scripts\common\utility::array_add(var_05,var_07);
	}

	if(!var_05.size)
	{
		if(isalive(self.var_222))
		{
			return self.var_222;
		}
		else
		{
			return undefined;
		}
	}

	if(var_05.size == 1)
	{
		if(isdefined(var_05[0]) && isalive(var_05[0]))
		{
			return var_05[0];
		}
	}

	var_0A = undefined;
	if(self.var_222 == level.player)
	{
		var_0A = level.player func_797E();
	}

	var_0B = cos(45);
	var_0C = 400;
	var_0D = 0;
	var_0E = undefined;
	var_0F = 1;
	foreach(var_11 in var_05)
	{
		var_12 = var_0F;
		if(isdefined(var_11.var_12BA4))
		{
			if(var_11.var_12BA4 == "c6" || var_11.var_12BA4 == "c6i")
			{
				var_12 = var_12 * 0.99;
			}
			else if(var_11.var_12BA4 == "c8")
			{
				var_12 = var_12 * 0.98;
			}
			else if(var_11.var_12BA4 == "c12")
			{
				var_12 = var_12 * 0.2;
			}
		}

		if(isplayer(var_11))
		{
			var_12 = var_12 * 0.99;
		}

		if(isdefined(var_11.var_F126) && var_11.var_F126 != self)
		{
			var_12 = var_12 * 0.5;
		}

		if(param_00)
		{
			var_08 = distancesquared(self.origin,var_11.origin);
			if(isdefined(self.var_3135.var_F15D) && self.var_3135.var_F15D == var_11)
			{
				var_12 = var_12 * 2;
				var_13 = 1 - lib_0B4D::func_C097(0,squared(var_0C),var_08);
				var_12 = var_12 * var_13 + 0.5;
			}
			else if(var_08 > squared(var_0C))
			{
				var_12 = 0;
			}
			else
			{
				var_13 = 1 - lib_0B4D::func_C097(0,squared(var_0C),var_08);
				var_12 = var_12 * var_13 + 0.5;
			}
		}
		else
		{
			if(self.var_222 == level.player)
			{
				if(isdefined(var_0A) && var_0A == var_11)
				{
					var_12 = var_12 * 3;
				}

				var_14 = scripts\sp\_utility::func_7951(level.player geteye(),level.player getplayerangles(),var_11.origin);
				var_15 = lib_0B4D::func_DF68(var_14,var_0B,1,0,1);
				var_12 = var_12 * var_15;
			}
			else if(self.var_3135.var_652A == "axis")
			{
				if(isdefined(level.player.var_4D2C) && issentient(level.player.var_4D2C) && isalive(level.player.var_4D2C))
				{
					var_12 = var_12 * 2;
				}
			}
			else if(isdefined(self.var_222.var_1B1) && issentient(self.var_222.var_1B1) && isalive(self.var_222.var_1B1))
			{
				var_12 = var_12 * 2;
			}

			var_08 = distancesquared(self.origin,var_11.origin);
			var_13 = 1 - lib_0B4D::func_C097(squared(var_04),squared(var_03),var_08);
			var_12 = var_12 * var_13 + 0.5;
		}

		if(!isdefined(var_0E) || var_12 > var_0D)
		{
			var_0E = var_11;
			var_0D = var_12;
		}
	}

	return var_0E;
}

//Function Number: 47
func_F07D()
{
	var_00 = function_0075("axis","all");
	var_01 = 100;
	var_02 = [];
	foreach(var_04 in var_00)
	{
		if(var_04.ignoreme || !isalive(var_04))
		{
			continue;
		}

		var_05 = distancesquared(self.origin,var_04.origin);
		if(var_05 < squared(var_01))
		{
			continue;
		}

		var_02 = scripts\common\utility::array_add(var_02,var_04);
	}

	if(!var_02.size)
	{
		return undefined;
	}

	if(var_02.size == 1)
	{
		if(isdefined(var_02[0]) && isalive(var_02[0]))
		{
			return var_02[0];
		}
	}

	var_07 = func_797E();
	if(isdefined(var_07))
	{
		return var_07;
	}

	var_08 = cos(45);
	var_09 = 800;
	var_0A = 400;
	var_0B = 0;
	var_0C = undefined;
	var_0D = 1;
	foreach(var_0F in var_02)
	{
		var_10 = var_0D;
		if(isdefined(var_0F.var_F126) && var_0F.var_F126 != self)
		{
			var_10 = var_10 * 0.5;
		}

		var_11 = scripts\sp\_utility::func_7951(level.player geteye(),level.player getplayerangles(),var_0F.origin);
		var_12 = lib_0B4D::func_DF68(var_11,var_08,1,0,1);
		var_10 = var_10 * var_12;
		var_05 = distancesquared(self.origin,var_0F.origin);
		var_13 = 1 - lib_0B4D::func_C097(squared(var_01),squared(var_09),var_05);
		var_10 = var_10 * var_13 + 0.5;
		if(!isdefined(var_0C) || var_10 > var_0B)
		{
			var_0C = var_0F;
			var_0B = var_10;
		}
	}

	return var_0C;
}

//Function Number: 48
func_797E()
{
	var_00 = vectornormalize(anglestoforward(self.angles));
	var_01 = self.origin + var_00 * 10000;
	var_02 = scripts\common\trace::func_DCED(self geteye(),var_01,self);
	if(isdefined(var_02["entity"]))
	{
		if(issentient(var_02["entity"]))
		{
			if(function_0106(self.team,var_02["entity"].team))
			{
				var_03 = var_02["entity"];
				return var_03;
			}

			return;
		}

		return undefined;
	}
}

//Function Number: 49
func_7981(param_00,param_01)
{
	if(isalive(self.var_222))
	{
		return undefined;
	}

	param_01 = scripts\common\utility::func_116D7(isdefined(param_01),param_01,2000);
	param_00 = sortbydistance(param_00,self.origin);
	foreach(var_03 in param_00)
	{
		var_04 = distancesquared(self.var_222.origin,var_03.origin);
		if(func_56EF(var_04,param_01))
		{
			if(isalive(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 50
func_56EF(param_00,param_01)
{
	param_01 = scripts\common\utility::func_116D7(isdefined(param_01),param_01,800);
	if(param_00 <= param_01 * param_01 && param_00 >= level.var_F10A.var_4D19 * level.var_F10A.var_4D19)
	{
		return 1;
	}

	return 0;
}