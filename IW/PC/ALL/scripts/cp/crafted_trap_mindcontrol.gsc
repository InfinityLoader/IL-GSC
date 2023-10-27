/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_trap_mindcontrol.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1039 ms
 * Timestamp: 10/27/2023 12:10:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.mindcontrol_trap_settings = [];
	var_00 = spawnstruct();
	var_00.var_39B = "zmb_robotprojectile_mp";
	var_00.var_B91A = "cp_town_mind_control_device";
	var_00.var_B924 = "cp_town_mind_control_device_good";
	var_00.var_B925 = "cp_town_mind_control_device_bad";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_AC71 = 45;
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 24;
	var_00.var_3AA7 = (0,0,0);
	var_00.var_3AA6 = (0,0,0);
	level.mindcontrol_trap_settings["crafted_mindcontrol"] = var_00;
}

//Function Number: 2
give_crafted_mindcontrol_trap(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_mindcontrol");
	param_01 setclientomnvar("zom_crafted_weapon",15);
	scripts\cp\_utility::func_F313("crafted_mindcontrol",::give_crafted_mindcontrol_trap,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("death");
	self endon("disconnect");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_ims","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_ims");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread give_mindcontrol_trap("crafted_mindcontrol");
}

//Function Number: 4
give_mindcontrol_trap(param_00)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_01 = create_mindcontrol_trap_for_player(param_00,self);
	self.var_A039 = var_01.name;
	scripts\cp\_utility::func_E077();
	self.carried_mindcontrol_trap = var_01;
	var_01.var_6DEC = 1;
	var_02 = set_carrying_mindcontrol(var_01,1);
	self.carried_mindcontrol_trap = undefined;
	thread scripts\cp\_utility::func_E2CC();
	return var_02;
}

//Function Number: 5
set_carrying_mindcontrol(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 thread mindcontrol_trap_setcarried(self);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_ims","+attack");
	self notifyonplayercommand("place_ims","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_ims","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_ims","+actionslot 5");
		self notifyonplayercommand("cancel_ims","+actionslot 6");
		self notifyonplayercommand("cancel_ims","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_ims","cancel_ims","force_cancel_placement","player_action_slot_restart");
		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_ims" || var_03 == "force_cancel_placement" || var_03 == "player_action_slot_restart")
		{
			if(!param_01 && var_03 == "cancel_ims")
			{
				continue;
			}

			param_00 mindcontrol_trap_setcancelled(var_03 == "force_cancel_placement" && !isdefined(param_00.var_6DEC));
			if(var_03 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 thread mindcontrol_trap_setplaced(param_02);
		self notify("IMS_placed");
		scripts\common\utility::func_5127(0.5,::scripts\common\utility::allow_weapon,1);
		return 1;
	}
}

//Function Number: 6
create_mindcontrol_trap_for_player(param_00,param_01)
{
	if(isdefined(param_01.var_9D81) && param_01.var_9D81)
	{
		return;
	}

	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_01.angles;
	var_02.mindcontrol_trap_type = param_00;
	var_02.var_222 = param_01;
	var_02.name = "crafted_mindcontrol";
	var_02.carried_mindcontrol_trap = spawn("script_model",var_02.origin);
	var_02.carried_mindcontrol_trap.angles = param_01.angles;
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_01);
	return var_02;
}

//Function Number: 7
create_mindcontrol_trap(param_00,param_01)
{
	var_02 = param_00.var_222;
	var_03 = param_00.mindcontrol_trap_type;
	var_04 = spawn("script_model",param_00.origin + (0,0,2));
	var_04 setmodel(level.mindcontrol_trap_settings[var_03].var_B91A);
	var_04.var_EB9C = 3;
	var_04.angles = (0,param_00.carried_mindcontrol_trap.angles[1],0);
	var_04.mindcontrol_trap_type = var_03;
	var_04.var_222 = var_02;
	var_04 method_831F(var_02);
	var_04.team = var_02.team;
	var_04.name = "crafted_mindcontrol";
	var_04.var_10085 = 0;
	var_04.hidden = 0;
	var_04.var_451C = level.mindcontrol_trap_settings[var_03];
	var_04 thread mindcontrol_trap_handleuse();
	if(isdefined(param_01))
	{
		var_04 thread scripts\cp\_utility::func_A030(param_01);
	}
	else
	{
		var_04 thread scripts\cp\_utility::func_A030(undefined,level.mindcontrol_trap_settings[self.mindcontrol_trap_type].var_AC71);
	}

	return var_04;
}

//Function Number: 8
func_936D(param_00)
{
	self.var_933C = 1;
	self notify("death");
}

//Function Number: 9
func_9367(param_00)
{
	self endon("carried");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	mindcontrol_trap_setinactive();
	if(isdefined(self.var_9B05))
	{
		self.var_9B05 scripts\cp\_utility::func_E2CC();
		self notify("deleting");
		wait(1);
	}

	func_66A7();
	self delete();
}

//Function Number: 10
func_66A7()
{
	self playsound("trap_boom_box_explode");
	playfx(level._effect["violet_light_explode"],self.origin);
	wait(0.1);
	radiusdamage(self.origin + (0,0,40),200,500,250,self,"MOD_EXPLOSIVE","iw7_electrictrap_zm");
	self hide();
	wait(0.65);
	physicsexplosionsphere(self.origin,256,256,2);
}

//Function Number: 11
mindcontrol_trap_handleuse()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.kung_fu_mode))
		{
			continue;
		}

		var_01 = create_mindcontrol_trap_for_player(self.mindcontrol_trap_type,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		mindcontrol_trap_setinactive();
		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_00 thread set_carrying_mindcontrol(var_01,0,self.var_AC71);
		self delete();
		break;
	}
}

//Function Number: 12
mindcontrol_trap_setplaced(param_00)
{
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.var_3A9D))
	{
		self.var_3A9D method_80F3();
	}

	self.var_3A9D = undefined;
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_6DEC = undefined;
	var_01 = create_mindcontrol_trap(self,param_00);
	var_01.var_9EE4 = 1;
	var_01 thread func_9367(self.var_222);
	self playsound("trap_boom_box_drop");
	self notify("placed");
	var_01 thread mindcontrol_trap_setactive();
	var_02 = spawnstruct();
	if(isdefined(self.var_BD3B))
	{
		var_02.var_AD39 = self.var_BD3B;
	}

	var_02.var_6371 = "carried";
	var_02.var_4E53 = ::func_936D;
	var_01 thread scripts\cp\_movers::func_892F(var_02);
	self.carried_mindcontrol_trap delete();
	self delete();
}

//Function Number: 13
mindcontrol_trap_setcancelled(param_00)
{
	if(isdefined(self.var_3A9D))
	{
		var_01 = self.var_3A9D;
		var_01 method_80F3();
		var_01.var_9D81 = undefined;
		var_01.var_3AA0 = undefined;
		var_01 scripts\common\utility::allow_weapon(1);
	}

	if(isdefined(param_00) && param_00)
	{
		func_66A7();
	}

	self.carried_mindcontrol_trap delete();
	self delete();
}

//Function Number: 14
mindcontrol_trap_setcarried(param_00)
{
	self method_8335(param_00);
	self method_82C7(0);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.carried_mindcontrol_trap,level.mindcontrol_trap_settings["crafted_mindcontrol"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread func_936F(param_00);
	thread func_9371(param_00);
	if(isdefined(level.var_5CF2))
	{
		self thread [[ level.var_5CF2 ]](param_00);
	}

	self notify("carried");
}

//Function Number: 15
func_936F(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	param_00 waittill("disconnect");
	mindcontrol_trap_setcancelled();
}

//Function Number: 16
func_9371(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	level waittill("game_ended");
	mindcontrol_trap_setcancelled();
}

//Function Number: 17
mindcontrol_trap_setactive()
{
	self endon("death");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.mindcontrol_trap_settings[self.mindcontrol_trap_type].var_17B);
	scripts\cp\_utility::func_1861();
	var_00 = self.var_222;
	var_00 method_80F3();
	scripts\cp\_utility::func_F838(var_00);
	self method_84A5(120);
	self method_84A2(96);
	thread mindcontrol_trap_kill_zombies();
	thread scripts\cp\_utility::func_A021("mindcontrol_disconnect");
	if(!isdefined(var_00.next_trap_time))
	{
		var_00.next_trap_time = gettime();
	}

	wait(1);
	if(isdefined(var_00))
	{
		if(gettime() >= var_00.next_trap_time)
		{
			self setscriptablepartstate("mindcontrol","on");
		}
		else
		{
			while(gettime() <= var_00.next_trap_time)
			{
				wait(0.05);
			}

			self setscriptablepartstate("mindcontrol","on");
		}

		if(isdefined(var_00))
		{
			var_00.next_trap_time = gettime() + 3000;
			return;
		}

		return;
	}

	self notify("death");
}

//Function Number: 18
mindcontrol_trap_setinactive()
{
	self makeunusable();
	self stoploopsound();
	self setscriptablepartstate("mindcontrol","off");
	if(isdefined(self.var_5761))
	{
		self.var_5761 delete();
	}

	scripts\cp\_utility::func_E11E();
}

//Function Number: 19
mindcontrol_trap_kill_zombies()
{
	self endon("death");
	self.var_5761 = spawn("trigger_radius",self.origin,0,200,64);
	for(;;)
	{
		var_00 = 0;
		self waittill("scriptableNotification");
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		foreach(var_03 in var_01)
		{
			if(!var_03 istouching(self.var_5761))
			{
				continue;
			}

			if(!scripts\cp\_utility::func_FF18(var_03) || scripts\common\utility::istrue(var_03.controlled) || scripts\common\utility::istrue(var_03.var_152C) || scripts\common\utility::istrue(var_03.var_9BB0))
			{
				continue;
			}

			if(var_03.agent_type == "crab_mini" || var_03.agent_type == "crab_brute")
			{
				continue;
			}

			if(var_00 >= 3)
			{
				continue;
			}

			var_03 thread control_zombie(self);
			var_00++;
		}
	}
}

//Function Number: 20
control_zombie(param_00)
{
	self endon("death");
	self.controlled = 1;
	self.var_222 = param_00.var_222;
	self.var_C384 = self.health;
	self.og_maxhealth = self.maxhealth;
	self.og_movemode = self.var_1F5;
	self.goalradius_old = self.var_15C;
	self.var_9CEF = 1;
	self.var_B57A = int(scripts\cp\zombies\zombies_spawning::func_3728("generic_zombie") * 0.5);
	self.var_1F5 = "sprint";
	self setscriptablepartstate("eyes","turned_eyes");
	self.team = "allies";
	self.maxhealth = 1500;
	self.health = 1500;
	thread kill_intersecting_zombies(param_00);
	wait(60);
	self notify("end_control");
	self.maxhealth = self.og_maxhealth;
	self.health = self.var_C384;
	self.var_9CEF = undefined;
	self.var_B57A = undefined;
	self.controlled = 0;
	self.team = "axis";
	self.var_1F5 = self.og_movemode;
	self.var_15C = self.goalradius_old;
	self setscriptablepartstate("eyes","yellow_eyes");
}

//Function Number: 21
kill_intersecting_zombies(param_00)
{
	self endon("death");
	self endon("end_control");
	var_01 = 576;
	for(;;)
	{
		var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
		if(var_02.size == 0)
		{
			wait(0.05);
			continue;
		}

		var_03 = scripts\common\utility::getclosest(self.origin,var_02);
		if(distancesquared(var_03.origin,self.origin) < var_01)
		{
			var_03.full_gib = 1;
			var_03.var_4C87 = 1;
			var_03 dodamage(var_03.health + 100,var_03.origin,self,self,"MOD_MELEE","none");
			if(isdefined(param_00.var_222))
			{
				param_00.var_222 scripts\cp\_merits::func_D9AD("mt_dlc3_crafted_kills");
			}
		}

		wait(0.05);
	}
}