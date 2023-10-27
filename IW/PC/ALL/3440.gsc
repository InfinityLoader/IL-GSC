/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3440.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 18 ms
 * Timestamp: 10/27/2023 12:27:28 AM
*******************************************************************/

//Function Number: 1
func_97D0()
{
	level.var_37D3 = [];
	level._effect["marked_target"] = loadfx("vfx/iw7/_requests/mp/vfx_marked_target");
	level._effect["wall_lock_engaged"] = loadfx("vfx/iw7/_requests/mp/vfx_sonic_sensor_pulse");
}

//Function Number: 2
func_20BB()
{
}

//Function Number: 3
func_E0D0()
{
	self notify("removeArchetype");
}

//Function Number: 4
func_E89D()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("victim_damaged",var_00,var_01);
		if(var_00 scripts\mp\_utility::_hasperk("specialty_coldblooded") || var_00 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			continue;
		}

		thread func_10222(var_00);
		wait(0.05);
	}
}

//Function Number: 5
func_10222(param_00)
{
	param_00 endon("disconnect");
	var_01 = scripts\mp\_utility::func_C794(param_00,"red",self,0,0,"level_script");
	param_00 scripts\mp\_hud_message::func_1013D("spotted");
	thread func_13AA0(var_01,param_00,2);
	wait(2);
}

//Function Number: 6
func_E83E()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	setdvarifuninitialized("camo_method",0);
	if(level.ingraceperiod == 0)
	{
		self waittill("spawned_player");
	}
	else
	{
		wait(1);
	}

	self.var_9E3F = 0;
	self.var_37E5 = 0.1;
	self.var_C3E6 = self.model;
	self.var_C408 = self method_816D();
	thread func_37DD();
	if(getdvarint("camo_method",1))
	{
		thread func_37D4();
		return;
	}

	thread func_37D5();
}

//Function Number: 7
func_37D4()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	thread func_37E0();
	thread func_37DB();
	thread func_37DF();
	thread func_37E3();
	thread func_37DE();
	if(scripts\mp\_utility::_hasperk("specialty_camo_elite"))
	{
		self.var_37D2 = "mp_fullbody_synaptic_1";
	}
	else
	{
		self.var_37D2 = "mp_fullbody_synaptic_1";
	}

	for(;;)
	{
		if((self method_81BD() || self method_8446()) && !self ismeleeing() && !scripts\mp\killstreaks\_emp_common::isemped() && !self ismantling() && !self usebuttonpressed() && !self adsbuttonpressed() && !isdefined(self.var_9FF6) && !isdefined(self.var_6F43))
		{
			func_37DA();
		}
		else
		{
			wait(1.5);
			continue;
		}

		wait(0.1);
		scripts\common\utility::waittill_any_3("camo_off","emp_damage");
		wait(0.05);
		func_37D9();
		wait(self.var_37E5);
		self.var_37E5 = 0.1;
	}
}

//Function Number: 8
func_37D5()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	thread func_37DF();
	thread func_37E3();
	if(scripts\mp\_utility::_hasperk("specialty_camo_elite"))
	{
		self.var_37D2 = "mp_fullbody_synaptic_1";
	}
	else
	{
		self.var_37D2 = "mp_fullbody_synaptic_1";
	}

	for(;;)
	{
		if(!self ismeleeing() && !scripts\mp\killstreaks\_emp_common::isemped())
		{
			func_37DA();
		}
		else
		{
			wait(1.5);
			continue;
		}

		wait(0.1);
		scripts\common\utility::waittill_any_3("camo_off","emp_damage");
		wait(0.05);
		func_37D9();
		wait(self.var_37E5);
		self.var_37E5 = 0.1;
	}
}

//Function Number: 9
func_37E3()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired",var_00);
		if(self.var_9E3F)
		{
			self.var_37E5 = 3.5;
			self notify("camo_off");
		}
	}
}

//Function Number: 10
func_37E4()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_change");
		if(self.var_9E3F && scripts\mp\_utility::func_8225(self getcurrentweapon()) == "weapon_sniper")
		{
			self notify("camo_off");
		}
	}
}

//Function Number: 11
func_37E0()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		if((!self method_81BD() && !self method_8446() && !self isjumping() && !self ismantling()) || isdefined(self.var_9FF6) || isdefined(self.var_6F43))
		{
			self notify("camo_off");
			self waittill("camo_on");
		}

		wait(0.05);
	}
}

//Function Number: 12
func_37DB()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("removeArchetype");
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			self notify("camo_off");
			self waittill("camo_on");
		}

		wait(0.05);
	}
}

//Function Number: 13
func_37DF()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("removeArchetype");
	for(;;)
	{
		if(self ismeleeing())
		{
			self notify("camo_off");
			self waittill("camo_on");
		}

		wait(0.05);
	}
}

//Function Number: 14
func_37E2()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("removeArchetype");
	for(;;)
	{
		if(self method_8446())
		{
			self notify("camo_off");
			self waittill("camo_on");
		}

		wait(0.05);
	}
}

//Function Number: 15
func_37DA()
{
	if(!self.var_9E3F)
	{
		self.var_9E3F = 1;
		self setmodel(self.var_37D2);
		func_20CE();
		self playlocalsound("ghost_wall_camo_on");
		scripts\mp\_utility::func_8387("specialty_blindeye");
		scripts\mp\_utility::func_8387("specialty_noscopeoutline");
		self notify("camo_on");
	}
}

//Function Number: 16
func_37D9()
{
	if(self.var_9E3F)
	{
		self.var_9E3F = 0;
		self setmodel(self.var_C3E6);
		func_E12D();
		self playlocalsound("ghost_wall_camo_off");
		scripts\mp\_utility::func_E150("specialty_blindeye");
		scripts\mp\_utility::func_E150("specialty_noscopeoutline");
	}
}

//Function Number: 17
func_561B()
{
	self endon("death");
	self endon("disconnect");
	self method_80AA();
	self waittill("camo_off");
	self enableweapons();
}

//Function Number: 18
func_37DE()
{
	self endon("death");
	self endon("disconnect");
	self endon("camo_off");
	for(;;)
	{
		if(self usebuttonpressed() || self adsbuttonpressed() && !isdefined(self.var_9FF6))
		{
			self notify("camo_off");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
func_37DD()
{
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self waittill("death");
	if(self.var_9E3F)
	{
		func_37D9();
		self.var_9FF6 = undefined;
		self notify("camo_off");
	}
}

//Function Number: 20
func_E8AC()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self.var_138CE = undefined;
	for(;;)
	{
		if(self method_8446() && self method_822E() > 0.3)
		{
			var_00 = self method_842B(0);
			var_01 = self method_842D(0);
			self method_842C(0,var_01);
			self.var_138CE = var_00;
			func_68D7();
			thread func_13BA3();
			self waittill("walllock_ended");
			func_639B();
		}

		wait(0.1);
	}
}

//Function Number: 21
func_13BA3()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self endon("walllock_ended");
	wait(0.05);
	while(self method_822E() > 0.3 && self method_842B(0) > 0)
	{
		self method_842C(0,self method_842B(0) - 3);
		wait(0.05);
	}

	self notify("walllock_ended");
}

//Function Number: 22
func_68D7()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	self.var_9FF6 = 1;
	self allowmovement(0);
	self allowjump(0);
	self setstance("crouch");
	self playlocalsound("ghost_wall_attach");
	var_00 = scripts\common\utility::spawn_tag_origin();
	self setscriptablepartstate("perch","active",0);
	self playerlinkto(var_00);
	thread func_49EE(var_00.origin,scripts\mp\_utility::getotherteam(self.team));
	thread func_B2F5(var_00);
}

//Function Number: 23
func_B2F5(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	self endon("walllock_ended");
	level endon("game_ended");
	wait(10);
	var_01 = param_00.origin - (0,0,100);
	var_02 = scripts\common\trace::func_DCED(param_00.origin,var_01);
	if(length(param_00.origin - var_02["position"]) < length(param_00.origin - var_01))
	{
		var_01 = var_02["position"];
	}

	param_00 moveto(var_01,4,3.5);
	wait(4);
	self notify("walllock_ended");
}

//Function Number: 24
func_639B()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	var_00 = self.angles;
	self.var_9FF6 = undefined;
	self allowmovement(1);
	self allowjump(1);
	self setstance("stand");
	self playlocalsound("ghost_wall_detach");
	if(isdefined(self.var_138CE))
	{
		self method_842C(0,self.var_138CE);
	}

	self.var_138CE = undefined;
	self unlink();
	scripts\common\utility::func_136F7();
	self.angles = var_00;
	self setscriptablepartstate("perch","neutral",0);
}

//Function Number: 25
func_20CE()
{
	self setclientomnvar("ui_camouflageOverlay",1);
}

//Function Number: 26
func_E12D()
{
	self setclientomnvar("ui_camouflageOverlay",0);
}

//Function Number: 27
func_49EE(param_00,param_01)
{
	if(!isdefined(self) || !scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_02 == -1)
	{
		return;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",self.origin,"cb_compassping_sniper_enemy","icon_large");
	scripts\mp\objidpoolmanager::minimap_objective_team(var_02,param_01);
	scripts\common\utility::waittill_any_3("death","disconnect","stop_minimap_decoys","walllock_ended");
	scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

//Function Number: 28
func_13A2A()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	wait(0.05);
	if(!isdefined(self.var_AD33))
	{
		self.var_AD33 = scripts\common\utility::spawn_tag_origin();
		self.var_5FF1 = spawn("script_model",self.origin);
		self.var_5FF1 setmodel("tag_origin");
	}
	else
	{
		self.var_5FF1.origin = self gettagorigin("tag_shield_back");
		self.var_5FF1.angles = self gettagangles("tag_shield_back");
		self.var_5FF1 linkto(self,"tag_shield_back");
		self.var_AD33.origin = self.origin;
	}

	self notifyonplayercommand("floatPressed","+stance");
	for(;;)
	{
		self waittill("doubleJumpBegin");
		if(self isonground())
		{
			continue;
		}

		if(self ismantling())
		{
			continue;
		}

		func_10B46();
	}
}

//Function Number: 29
func_10B46()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("adjustedStance","doubleJumpEnd","unlinked");
		if(var_00 == "doubleJumpEnd" || var_00 == "unlinked")
		{
			break;
		}

		if(isdefined(self.var_1D42) && self.var_1D42)
		{
			break;
		}

		if(self method_842B(0) > 10)
		{
			continue;
		}

		func_1608();
	}
}

//Function Number: 30
func_1608()
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	self.var_6F43 = 1;
	self.var_1D42 = 1;
	self.var_AD33.origin = self.origin;
	self playerlinkto(self.var_AD33);
	self setstance("stand");
	thread func_D47C(self.var_5FF1);
	thread func_13A43();
	thread func_13A7C();
	thread func_13A49();
	thread func_BCB9(self.var_AD33);
	self.var_5039 = self method_8433(0);
	self method_8434(0,0);
	wait(5);
	func_10358();
}

//Function Number: 31
func_13A43()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		if(self isonground())
		{
			self.var_1D42 = 0;
			return;
		}
		else
		{
			wait(0.05);
		}
	}
}

//Function Number: 32
func_D47C(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	if(!param_00 islinked(self))
	{
		param_00.origin = self gettagorigin("tag_shield_back");
		param_00.angles = self gettagangles("tag_shield_back");
		param_00 linkto(self,"tag_shield_back");
		wait(0.05);
	}

	param_00 show();
	wait(0.1);
	scripts\mp\_utility::func_D486(self,param_00,"tag_origin",self.team,scripts\common\utility::getfx("heavyThrustFr"),scripts\common\utility::getfx("heavyThrustEn"),undefined,undefined,[self]);
}

//Function Number: 33
func_10358()
{
	self.var_6F43 = undefined;
	self.var_5FF1 hide();
	stopfxontag(level._effect["heavyThrustFr"],self.var_5FF1,"tag_origin");
	self method_8434(0,self.var_5039);
	self unlink();
	self notify("unlinked");
}

//Function Number: 34
func_13A7C()
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	self waittill("floatPressed");
	func_10358();
}

//Function Number: 35
func_13A49()
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	self waittill("adjustedStance");
	func_10358();
}

//Function Number: 36
func_BCB9(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	for(;;)
	{
		var_01 = self getnormalizedmovement();
		if(var_01[0] >= 0.15 || var_01[1] >= 0.15 || var_01[0] <= -0.15 || var_01[1] <= -0.15)
		{
			thread func_B31F(param_00,var_01);
		}
		else
		{
			thread func_DCBD(param_00,var_01);
		}

		wait(0.05);
		func_8D14(param_00);
	}
}

//Function Number: 37
func_B31F(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	param_00.var_BCD9 = 80;
	var_02 = anglestoforward(self.angles) * param_00.var_BCD9 * param_01[0];
	var_03 = anglestoright(self.angles) * param_00.var_BCD9 * param_01[1];
	var_04 = var_02 + var_03;
	var_05 = self.origin + var_04;
	var_06 = self.origin[2] - param_00.var_BCD9 / 4;
	var_05 = var_05 * (1,1,0);
	var_05 = var_05 + (0,0,var_06);
	var_05 = func_EA27(var_05);
	param_00 moveto(var_05,0.5);
}

//Function Number: 38
func_DCBD(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	var_02 = self.origin[2] - 12.5;
	var_03 = self.origin;
	var_03 = var_03 * (1,1,0);
	var_03 = var_03 + (0,0,var_02);
	var_03 = func_EA27(var_03);
	param_00 moveto(var_03,0.5);
}

//Function Number: 39
func_EA27(param_00)
{
	var_01 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_02 = scripts\common\trace::func_3A09(self.origin,param_00,16,32,(0,0,0),self,var_01,0);
	var_03 = var_02["fraction"];
	var_04 = var_02["position"];
	var_05 = undefined;
	var_06 = var_02["normal"];
	var_07 = 0;
	if(var_03 != 1)
	{
		if(var_06[0] > 0.8 || var_06[0] < -0.8)
		{
			var_07 = 1;
		}

		if(var_06[1] > 0.8 || var_06[1] < -0.8)
		{
			var_07 = 1;
		}

		if(var_03 < 0.25 && !var_07)
		{
			return self.origin;
		}
		else if(var_03 < 0.25 && var_07)
		{
			return (self.origin[0],self.origin[1],param_00[2]);
		}

		var_08 = param_00 - self.origin;
		var_09 = vectortoangles(var_08);
		var_0A = anglestoforward(var_09);
		var_05 = distance(self.origin,param_00);
		var_05 = var_05 - 32;
		var_0B = self.origin + var_0A * var_05;
	}
	else
	{
		var_0B = var_01;
	}

	if(isdefined(var_05) && var_05 < 16)
	{
		return self.origin;
	}

	return var_0B;
}

//Function Number: 40
func_8D14(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unlinked");
	self endon("removeArchetype");
	level endon("game_ended");
	var_01 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_02 = scripts\common\trace::func_D305(param_00.origin,param_00.origin - (0,0,100),self.angles,self,var_01);
	var_03 = var_02["position"];
	var_04 = var_02["normal"];
	var_05 = 0;
	if(var_04[0] == 1 || var_04[0] == -1)
	{
		var_05 = 1;
	}

	if(var_04[1] == 1 || var_04[1] == -1)
	{
		var_05 = 1;
	}

	if(!var_02["fraction"] && var_05)
	{
		var_06 = scripts\common\trace::func_DCED(param_00.origin,param_00.origin - (0,0,100),self,var_01);
		var_05 = 0;
		var_04 = var_06["normal"];
		if(var_04[0] > 0.8 || var_04[0] < -0.8)
		{
			var_05 = 1;
		}

		if(var_04[1] > 0.8 || var_04[1] < -0.8)
		{
			var_05 = 1;
		}

		if(var_05)
		{
			return;
		}
	}

	if(distancesquared(param_00.origin,var_03) < 256)
	{
		func_10358();
	}
}

//Function Number: 41
func_B382(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(scripts\common\utility::func_9D74(param_01) && isplayer(param_00) && param_00.team != self.team && !param_00 scripts\mp\_utility::_hasperk("specialty_coldblooded") || param_00 scripts\mp\_utility::_hasperk("specialty_empimmune") && !isdefined(param_00.var_9E92))
	{
		thread func_B380(param_00);
	}
}

//Function Number: 42
func_B380(param_00)
{
	var_01 = param_00 scripts\common\utility::spawn_tag_origin();
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("tag_origin");
	var_02 linkto(var_01,"tag_origin",(0,0,45),(0,0,0));
	var_01 linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00.var_9E92 = 1;
	param_00.var_8CC1 = 1;
	wait(0.1);
	if(level.gametype != "dm")
	{
		var_03 = function_029A(scripts\common\utility::getfx("marked_target"),var_02,"tag_origin",self.team);
	}
	else
	{
		var_03 = playfxontagforclients(scripts\common\utility::getfx("marked_target"),var_03,"tag_origin",self);
	}

	param_00 scripts\common\utility::waittill_notify_or_timeout("death",5);
	stopfxontag(scripts\common\utility::getfx("marked_target"),param_00,"tag_origin");
	var_01 delete();
	wait(0.1);
	param_00.var_9E92 = undefined;
	param_00.var_8CC1 = undefined;
}

//Function Number: 43
func_13AA0(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
	}
}

//Function Number: 44
func_E84B(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = self.var_222;
	var_02 = level.var_12AF7["uav_3dping"];
	if(var_01 scripts\mp\_utility::_hasperk("specialty_equipment_ping"))
	{
		for(;;)
		{
			foreach(var_04 in level.players)
			{
				if(!var_01 scripts\mp\_utility::func_9DD6(var_04))
				{
					continue;
				}

				if(var_04 scripts\mp\_utility::_hasperk("specialty_engineer") || var_04 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
				{
					continue;
				}

				if(isdefined(var_04.var_C78B))
				{
					continue;
				}

				var_05 = scripts\common\utility::array_add(level.players,self);
				if(isdefined(param_00))
				{
					var_05 = scripts\common\utility::array_add(var_05,param_00);
				}

				if(distance2d(var_04.origin,self.origin) < 300 && scripts\common\trace::func_DCF1(self.origin,var_04 gettagorigin("j_head"),var_05))
				{
					playfxontagforclients(var_02.var_7636,self,"tag_origin",var_01);
					playsoundatpos(self.origin + (0,0,5),var_02.var_10469);
					var_04 scripts\mp\_hud_message::func_1013D("spotted");
					var_01 scripts\mp\_damagefeedback::func_917F("eqp_ping");
					var_01 thread func_B369(var_04,self);
					wait(3);
				}
			}

			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 45
func_1B45()
{
	self playsoundtoplayer("mp_cranked_countdown",self);
}

//Function Number: 46
func_B369(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(!isdefined(self) || !scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_02 == -1)
	{
		return;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",param_01.origin,"cb_compassping_eqp_ping","icon_large");
	scripts\mp\objidpoolmanager::minimap_objective_team(var_02,self.team);
	param_00 thread func_13A35(var_02);
	wait(3);
	scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

//Function Number: 47
func_13A35(param_00)
{
	scripts\common\utility::waittill_any_3("death","disconnect");
	scripts\mp\objidpoolmanager::returnminimapid(param_00);
}

//Function Number: 48
func_C7A6(param_00)
{
	param_00 endon("disconnect");
	var_01 = scripts\mp\_utility::func_C794(param_00,"orange",self,0,0,"level_script");
	param_00 scripts\mp\_hud_message::func_1013D("spotted");
	param_00.var_C78B = 1;
	func_13AA0(var_01,param_00,0.35);
	wait(3);
	param_00.var_C78B = undefined;
}

//Function Number: 49
func_E7FE()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self getstance() == "prone" && scripts\mp\_utility::_hasperk("specialty_improved_prone"))
		{
			wait(0.2);
			var_00 = self.var_BCF6;
			self.var_BCF6 = 3;
			scripts\mp\_weapons::func_12ED5();
			func_BA22();
			self.var_BCF6 = var_00;
			scripts\mp\_weapons::func_12ED5();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 50
func_BA22()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	self endon("changed_kit");
	while(self getstance() == "prone")
	{
		scripts\common\utility::func_136F7();
	}
}