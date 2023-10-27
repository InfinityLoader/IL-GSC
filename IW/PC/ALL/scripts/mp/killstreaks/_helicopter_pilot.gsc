/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_helicopter_pilot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 1370 ms
 * Timestamp: 10/27/2023 12:28:45 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("heli_pilot",::func_128E7);
	level.var_8D79 = [];
	level.var_8DCE = [];
	level.var_8DCE["heli_pilot"] = spawnstruct();
	level.var_8DCE["heli_pilot"].var_11901 = 60;
	level.var_8DCE["heli_pilot"].maxhealth = 2000;
	level.var_8DCE["heli_pilot"].var_110EA = "heli_pilot";
	level.var_8DCE["heli_pilot"].var_13260 = "heli_pilot_mp";
	level.var_8DCE["heli_pilot"].var_B91A = "vehicle_aas_72x_killstreak";
	level.var_8DCE["heli_pilot"].var_115EB = "used_heli_pilot";
	func_8DC7();
	level.var_8D7C = getent("heli_pilot_mesh","targetname");
	if(!isdefined(level.var_8D7C))
	{
	}
	else
	{
		level.var_8D7C.origin = level.var_8D7C.origin + scripts\mp\_utility::func_7EF9();
	}

	var_00 = spawnstruct();
	var_00.var_EC44 = "destroyed_helo_pilot";
	var_00.var_13523 = undefined;
	var_00.var_3774 = "callout_destroyed_helo_pilot";
	var_00.var_EB11 = 0.09;
	var_00.var_65D0 = "tag_engine_right";
	level.var_8DA6["heli_pilot"] = var_00;
}

//Function Number: 2
func_128E7(param_00,param_01)
{
	var_02 = "heli_pilot";
	var_03 = 1;
	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}
	else if(func_68C1(self.team))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_03 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_04 = func_49D2(var_02);
	if(!isdefined(var_04))
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	level.var_8D79[self.team] = var_04;
	var_05 = func_10DA3(var_04);
	if(!isdefined(var_05))
	{
		var_05 = 0;
	}

	return var_05;
}

//Function Number: 3
func_68C1(param_00)
{
	if(level.gametype == "dm")
	{
		if(isdefined(level.var_8D79[param_00]) || isdefined(level.var_8D79[level.var_C74B[param_00]]))
		{
			return 1;
		}

		return 0;
	}

	if(isdefined(level.var_8D79[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
func_13AA2(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		param_00 setclientomnvar("ui_heli_pilot",1);
	}
}

//Function Number: 5
func_49D2(param_00)
{
	var_01 = func_8DC3(self.origin);
	var_02 = func_8DC4(var_01);
	var_03 = vectortoangles(var_02.origin - var_01.origin);
	var_04 = anglestoforward(self.angles);
	var_05 = var_02.origin + var_04 * -100;
	var_06 = var_01.origin;
	var_07 = spawnhelicopter(self,var_06,var_03,level.var_8DCE[param_00].var_13260,level.var_8DCE[param_00].var_B91A);
	if(!isdefined(var_07))
	{
		return;
	}

	var_07 method_81FC(18,-9,18);
	var_07 scripts\mp\killstreaks\_helicopter::func_1852();
	var_07 thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_07.maxhealth = level.var_8DCE[param_00].maxhealth;
	var_07.var_2B3 = 40;
	var_07.var_222 = self;
	var_07 method_831F(self);
	var_07.team = self.team;
	var_07.var_8DD9 = "littlebird";
	var_07.var_8DCF = "heli_pilot";
	var_07 method_830A(45,45);
	var_07 method_83E5(var_07.var_2B3,40,40);
	var_07 method_8378(120,60);
	var_07 method_8316(32);
	var_07 method_82F6(100,100,100);
	var_07 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",self);
	var_07.var_1157A = var_05;
	var_07.var_4BF7 = var_02;
	var_07.var_254D = 10000;
	var_07.var_254C = 150;
	var_07.var_2550 = missile_createattractorent(var_07,var_07.var_254D,var_07.var_254C);
	var_07 thread scripts\mp\killstreaks\_helicopter::func_8D40("heli_pilot");
	var_07 thread func_8DC6();
	var_07 thread func_8DCD();
	var_07 thread func_8DCB();
	var_07 thread func_8DCC();
	var_07 thread func_8DCA();
	var_07 thread func_8DC9();
	var_07 thread func_13AA2(self);
	var_07.var_222 scripts\mp\_matchdata::func_AFC9(level.var_8DCE[var_07.var_8DCF].var_110EA,var_07.var_1157A);
	return var_07;
}

//Function Number: 6
func_8DC6()
{
	playfxontag(level.var_3F19["light"]["left"],self,"tag_light_nose");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["belly"],self,"tag_light_belly");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail1");
	wait(0.05);
	playfxontag(level.var_3F19["light"]["tail"],self,"tag_light_tail2");
}

//Function Number: 7
func_10DA3(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	scripts\mp\_utility::func_FB09(param_00.var_8DCF);
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	self.var_E2D7 = self.angles;
	param_00 thread scripts\mp\killstreaks\_flares::func_A730(2,"+smoke","ui_heli_pilot_flare_ammo","ui_heli_pilot_warn");
	thread func_13AA8(param_00);
	scripts\mp\_utility::func_7385(1);
	var_01 = scripts\mp\killstreaks\_killstreaks::func_98C2(param_00.var_8DCF);
	if(var_01 != "success")
	{
		if(isdefined(self.var_55E6) && self.var_55E6)
		{
			scripts\common\utility::allow_weapon(1);
		}

		param_00 notify("death");
		return 0;
	}

	scripts\mp\_utility::func_7385(0);
	var_02 = scripts\mp\_utility::func_7EFA();
	var_03 = param_00.var_4BF7.origin + scripts\mp\_utility::func_7EF9() + var_02;
	var_04 = param_00.var_4BF7.origin + scripts\mp\_utility::func_7EF9() - var_02;
	var_05 = bullettrace(var_03,var_04,0,undefined,0,0,1);
	if(!isdefined(var_05["entity"]))
	{
	}

	var_06 = var_05["position"] - scripts\mp\_utility::func_7EF9() + (0,0,250);
	var_07 = spawn("script_origin",var_06);
	self method_825C(param_00);
	param_00 thread func_8DB9(var_07);
	param_00 thread func_8DC8();
	level thread scripts\mp\_utility::func_115DE(level.var_8DCE[param_00.var_8DCF].var_115EB,self);
	param_00.var_A63A = spawn("script_origin",self method_816E());
	return 1;
}

//Function Number: 8
func_8DB9(param_00)
{
	self endon("death");
	level endon("game_ended");
	self method_825E(param_00);
	self waittill("goal_reached");
	self method_825F();
	param_00 delete();
}

//Function Number: 9
func_13AA8(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	self waittill("intro_cleared");
	self setclientomnvar("ui_heli_pilot",1);
	var_01 = scripts\mp\_utility::func_C794(self,"cyan",self,0,0,"killstreak");
	func_E146(var_01,param_00);
	foreach(var_03 in level.var_C928)
	{
		if(!scripts\mp\_utility::func_9F19(var_03) || var_03.sessionstate != "playing")
		{
			continue;
		}

		if(scripts\mp\_utility::func_9DD6(var_03))
		{
			if(!var_03 scripts\mp\_utility::_hasperk("specialty_noplayertarget"))
			{
				var_01 = scripts\mp\_utility::func_C794(var_03,"orange",self,0,0,"killstreak");
				var_03 func_E146(var_01,param_00);
				continue;
			}

			var_03 thread func_13A56(param_00);
		}
	}

	param_00 thread func_13B0D();
	thread func_13A0D(param_00);
}

//Function Number: 10
func_13A56(param_00)
{
	self notify("watchForPerkRemoval");
	self endon("watchForPerkRemoval");
	self endon("death");
	self waittill("removed_specialty_noplayertarget");
	var_01 = scripts\mp\_utility::func_C794(self,"orange",param_00.var_222,0,0,"killstreak");
	func_E146(var_01,param_00);
}

//Function Number: 11
func_13B0D()
{
	self endon("leaving");
	self endon("death");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(var_00.sessionstate == "playing" && self.var_222 scripts\mp\_utility::func_9DD6(var_00))
		{
			var_00 thread func_13A56(self);
		}
	}
}

//Function Number: 12
func_E146(param_00,param_01)
{
	thread func_8DD0(param_00,param_01);
	thread func_D3E9(param_00,param_01);
}

//Function Number: 13
func_8DD0(param_00,param_01)
{
	self notify("heliRemoveOutline");
	self endon("heliRemoveOutline");
	self endon("outline_removed");
	self endon("disconnect");
	level endon("game_ended");
	var_02 = ["leaving","death"];
	param_01 scripts\common\utility::func_13731(var_02);
	if(isdefined(self))
	{
		scripts\mp\_utility::func_C78F(param_00,self);
		self notify("outline_removed");
	}
}

//Function Number: 14
func_D3E9(param_00,param_01)
{
	self notify("playerRemoveOutline");
	self endon("playerRemoveOutline");
	self endon("outline_removed");
	self endon("disconnect");
	level endon("game_ended");
	var_02 = ["death"];
	scripts\common\utility::func_13731(var_02);
	scripts\mp\_utility::func_C78F(param_00,self);
	self notify("outline_removed");
}

//Function Number: 15
func_8DC9()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(isdefined(self.var_222))
	{
		self.var_222 func_8DC1(self);
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	thread scripts\mp\killstreaks\_helicopter::func_AAC7();
}

//Function Number: 16
func_8DCA()
{
	level endon("game_ended");
	self endon("gone");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	level waittill("objective_cam");
	thread scripts\mp\killstreaks\_helicopter::func_AAC7();
	if(isdefined(self.var_222))
	{
		self.var_222 func_8DC1(self);
	}
}

//Function Number: 17
func_8DCD()
{
	level endon("game_ended");
	self endon("death");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	var_00 = level.var_8DCE[self.var_8DCF].var_11901;
	scripts\mp\_hostmigration::func_13708(var_00);
	thread func_8DC5();
}

//Function Number: 18
func_8DCB()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	thread func_8DC5();
}

//Function Number: 19
func_8DCC()
{
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	thread func_8DC5();
}

//Function Number: 20
func_8DC5()
{
	self endon("death");
	self notify("leaving");
	if(isdefined(self.var_222))
	{
		self.var_222 func_8DC1(self);
	}

	var_00 = scripts\mp\killstreaks\_airdrop::func_7EC0(self.origin);
	var_01 = self.origin + (0,0,var_00);
	self method_83E5(140,60);
	self method_830A(45,180);
	self method_8362(var_01);
	self waittill("goal");
	var_01 = var_01 + anglestoforward(self.angles) * 15000;
	var_02 = spawn("script_origin",var_01);
	if(isdefined(var_02))
	{
		self method_8305(var_02);
		var_02 thread func_13589(3);
	}

	self method_8362(var_01);
	self waittill("goal");
	self notify("gone");
	scripts\mp\killstreaks\_helicopter::func_E139();
}

//Function Number: 21
func_13589(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 22
func_8DC1(param_00)
{
	if(isdefined(param_00))
	{
		self setclientomnvar("ui_heli_pilot",0);
		param_00 notify("end_remote");
		if(scripts\mp\_utility::func_9FC6())
		{
			scripts\mp\_utility::func_41E9();
		}

		if(getdvarint("camera_thirdPerson"))
		{
			scripts\mp\_utility::setthirdpersondof(1);
		}

		self method_825D(param_00);
		self setplayerangles(self.var_E2D7);
		thread func_8DC2();
	}
}

//Function Number: 23
func_8DC2()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	wait(0.5);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 24
func_8DC8()
{
	self endon("leaving");
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(isdefined(self.var_222))
		{
			if(self.var_222 adsbuttonpressed())
			{
				if(!var_00)
				{
					self.var_222 setclientomnvar("ui_heli_pilot",2);
					var_00 = 1;
				}
			}
			else if(var_00)
			{
				self.var_222 setclientomnvar("ui_heli_pilot",1);
				var_00 = 0;
			}
		}

		wait(0.1);
	}
}

//Function Number: 25
func_8DC7()
{
	level.var_1A6B = scripts\common\utility::getstructarray("chopper_boss_path_start","targetname");
}

//Function Number: 26
func_8DC4(param_00)
{
	if(isdefined(param_00.var_EE01))
	{
		var_01 = param_00 scripts\common\utility::func_7A9C();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = scripts\common\utility::getstruct(var_01[var_02],"script_linkname");
			if(isdefined(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 27
func_8DC3(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.var_1A6B)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 28
func_13A0D(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self endon("leaving");
	param_00 thread scripts\mp\killstreaks\_killstreaks::func_1CA5();
	param_00 waittill("killstreakExit");
	param_00 thread func_8DC5();
}