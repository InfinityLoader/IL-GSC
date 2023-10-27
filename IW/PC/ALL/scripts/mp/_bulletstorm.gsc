/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_bulletstorm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1580 ms
 * Timestamp: 10/27/2023 12:14:41 AM
*******************************************************************/

//Function Number: 1
func_3258()
{
	level.var_3257 = [];
	level.var_3257["bubble"] = spawnstruct();
	level.var_3257["bubble"].var_49B3 = ::func_498C;
	level.var_3257["bubble"].var_741D = "prop_mp_bulletstorm";
	level.var_3257["bubble"].var_6564 = "prop_mp_bulletstorm_enemy";
	level.var_3257["section"] = spawnstruct();
	level.var_3257["section"].var_49B3 = ::func_4A0F;
	level.var_3257["section"].var_741D = "prop_mp_bulletstorm_v3";
	level.var_3257["section"].var_6564 = "prop_mp_bulletstorm_v3_enemy";
}

//Function Number: 2
func_10D76(param_00)
{
	self.var_D782["power_bulletstorm"].var_19 = 1;
	scripts\common\utility::func_1C76(0);
	self allowcrouch(0);
	self allowprone(0);
	self method_8422(0);
	self method_800E(0);
	self.var_3253 = spawnstruct();
	self.var_3253.var_4C15 = self getcurrentweapon();
	self.var_3253.var_DF66 = self getweaponammoclip(self.var_3253.var_4C15);
	self.var_3253.var_DF67 = self getweaponammostock(self.var_3253.var_4C15);
	scripts\mp\_utility::func_141E(self.var_3253.var_4C15);
	var_01 = func_811B(1);
	var_02 = self [[ level.var_3257[var_01].var_49B3 ]](param_00);
	thread func_139BF(var_01,var_02);
	thread func_139BC();
	self.var_FC99 = 1;
}

//Function Number: 3
func_139BF(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
}

//Function Number: 4
func_139BC()
{
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("death","disconnect");
	self.var_FC99 = undefined;
	self.var_3255 = undefined;
	self.var_3254 = undefined;
	self.var_3256 = undefined;
}

//Function Number: 5
func_811B(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case 1:
			var_01 = "bubble";
			break;

		case 2:
			var_01 = "section";
			break;
	}

	return var_01;
}

//Function Number: 6
func_498C(param_00)
{
	var_01 = self.origin;
	var_02 = spawn("script_model",var_01);
	var_02 setmodel(level.var_3257["bubble"].var_741D);
	var_02.health = 999999;
	var_02.var_AC75 = 4;
	var_02.var_E749 = 720;
	var_02.var_11A33 = 0;
	var_02.var_4D63 = 250;
	var_02.var_28AF = "bulletstorm_device_mp";
	var_02 setcandamage(1);
	var_02 hide();
	var_02.var_249C = [];
	if(isdefined(self.var_3255))
	{
		var_02.var_AC75 = self.var_3255;
	}

	if(isdefined(self.var_3254))
	{
		var_02.health = self.var_3254;
	}

	if(isdefined(self.var_3256))
	{
		var_02.var_E749 = self.var_3256;
	}

	var_03 = spawn("script_model",var_02.origin + (0,0,10));
	var_03 setmodel("tag_origin");
	var_03 thread func_BD2E(self);
	var_03 thread func_13B3A(var_02);
	var_04 = spawn("script_model",var_01);
	var_04 setmodel(level.var_3257["bubble"].var_6564);
	var_04 hide();
	var_04 thread func_BD2E(self);
	var_04 thread func_13B3A(var_02);
	var_02 thread func_BD2E(self);
	var_02 thread func_3259(self,var_03,var_04);
	func_10112(self,var_02,var_04);
	return var_02;
}

//Function Number: 7
func_4A0F()
{
	var_00 = self gettagorigin("j_mainroot");
	var_01 = spawn("script_model",var_00);
	var_01 setmodel("tag_origin");
	var_01 thread func_BD2E(self);
	return var_01;
}

//Function Number: 8
func_24AA(param_00,param_01)
{
	var_02[0] = (50,0,10);
	var_02[1] = (0,50,10);
	var_02[2] = (-50,0,10);
	var_02[3] = (0,-50,10);
	var_03 = 4;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = spawn("script_model",self.origin + (0,0,50));
		var_05 setmodel(level.var_3257["section"].var_741D);
		var_05 linkto(self,"tag_origin",var_02[var_04],(0,90 * var_04 + 1,0));
		var_05 thread func_13B3A(param_01);
	}
}

//Function Number: 9
func_BD2E(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	self endon("shield_lifetime_hit");
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(isdefined(self))
		{
			self.origin = param_00.origin;
		}
	}
}

//Function Number: 10
func_3259(param_00,param_01,param_02)
{
	self endon("stop_bulletstorm");
	thread func_139B8(param_00);
	thread func_13B61(param_00);
	thread func_139BA(param_00);
	thread func_139BE(param_00);
	var_03 = "hitbulletstorm";
	thread func_10A10(self.var_E749,4,1,1);
	param_01 thread func_10A10(self.var_E749,4,1,1);
	param_02 thread func_10A10(self.var_E749,4,1,1);
	for(;;)
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		playfx(scripts\common\utility::getfx("bulletstorm_shield_hit"),var_07);
		playsoundatpos(var_07,"bs_shield_impact");
		var_05 scripts\mp\_damagefeedback::func_12E84(var_03);
	}
}

//Function Number: 11
func_10112(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!lib_0DF8::func_9DDF(var_04))
		{
			var_04 func_12E6B(param_00.team,param_01,param_02);
		}
	}
}

//Function Number: 12
func_12E6B(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(self.team == param_00)
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = param_02;
	}

	if(isdefined(var_03))
	{
		var_03 showtoplayer(self);
		thread func_139BD(param_00,var_03,param_01,param_02);
		thread func_139BB(param_00,var_03,param_01,param_02);
	}
}

//Function Number: 13
func_139BD(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	param_01 endon("death");
	self waittill("joined_team");
	param_01 method_8429(self);
	scripts\common\utility::func_136F7();
	func_12E6B(param_00,param_02,param_03);
}

//Function Number: 14
func_139BB(param_00,param_01,param_02,param_03)
{
}

//Function Number: 15
func_139B8(param_00)
{
	self endon("stop_bulletstorm");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	self notify("stop_bulletstorm",1);
}

//Function Number: 16
func_13B61(param_00)
{
	self waittill("stop_bulletstorm",var_01);
	if(isdefined(param_00))
	{
		var_02 = param_00 gettagorigin("j_mainroot");
		func_10D75(param_00,self.var_11A33,var_02,self.var_4D63);
		param_00.var_FC99 = undefined;
		param_00 setclientomnvar("ui_bulletstorm_update",-1);
		param_00.var_3255 = undefined;
		param_00.var_3254 = undefined;
		param_00.var_3256 = undefined;
		param_00.var_D782["power_bulletstorm"].var_19 = 0;
		var_03 = -1;
		if(var_01)
		{
			var_03 = 0;
		}

		param_00 notify("powers_bulletstorm_update",var_03);
		param_00 scripts\common\utility::func_1C76(1);
		param_00 allowcrouch(1);
		param_00 allowprone(1);
		param_00 method_8422(1);
		param_00 method_800E(1);
		var_04 = param_00.var_3253.var_4C15;
		var_05 = param_00.var_3253.var_DF66;
		var_06 = param_00.var_3253.var_DF67;
		param_00 giveweapon(var_04,0,0,0,1);
		param_00 setweaponammoclip(var_04,var_05);
		param_00 setweaponammostock(var_04,var_06);
		param_00 scripts\mp\_utility::_switchtoweaponimmediate(var_04);
	}

	self delete();
}

//Function Number: 17
func_139BE(param_00)
{
	self endon("stop_bulletstorm");
	for(;;)
	{
		param_00 waittill("multi_use_activated",var_01);
		if(var_01 == "power_bulletstorm")
		{
			self notify("stop_bulletstorm",1);
		}
	}
}

//Function Number: 18
func_139BA(param_00)
{
	self endon("stop_bulletstorm");
	var_01 = 0.25;
	for(;;)
	{
		if(self.var_AC75 >= 1)
		{
			param_00 setclientomnvar("ui_bulletstorm_update",int(self.var_AC75));
		}
		else
		{
			break;
		}

		wait(0.05);
		if(self.var_AC75 > 1)
		{
			self.var_AC75 = self.var_AC75 - 0.05;
			self notify("powers_bulletstorm_update",self.var_AC75 * var_01);
		}
	}

	self notify("shield_lifetime_hit");
	self notify("stop_bulletstorm",1);
}

//Function Number: 19
func_10D75(param_00,param_01,param_02,param_03)
{
	if(param_01 > 0)
	{
		var_04 = getdvarint("scr_bulletstorm_explosion",1);
		playfx(scripts\common\utility::getfx("bulletstorm_explode"),param_02);
		playfx(scripts\common\utility::getfx("bulletstorm_explode2"),param_02);
		if(var_04 == 1)
		{
			param_00 playlocalsound("bs_shield_explo");
			param_00 playsound("bs_shield_explo_npc");
		}
		else
		{
			param_00 playlocalsound("bs_shield_explo");
			param_00 playsound("bs_shield_explo_npc");
		}

		param_00 thread scripts\mp\_shellshock::func_858A(undefined,0);
		param_01 = int(clamp(param_01,20,150));
		param_03 = int(clamp(param_03,50,250));
		foreach(var_06 in level.players)
		{
			if(var_06 == param_00)
			{
				continue;
			}

			if(var_06.team == param_00.team)
			{
				continue;
			}

			var_07 = func_811A(var_04,param_02,param_03,param_00,var_06,param_01);
			if(var_07.var_38BF)
			{
				if(var_04 == 1)
				{
					if(var_07.var_4D70 >= var_06.health)
					{
						var_06.var_4C87 = 1;
					}

					var_06 dodamage(var_07.var_4D70,param_02,param_00,self,"MOD_EXPLOSIVE");
					var_06 thread func_139B9(param_02,param_03,1);
					continue;
				}

				param_00 notify("stun_hit");
				var_06 notify("concussed",param_00);
				var_06 shellshock("concussion_grenade_mp",var_07.var_5FE9);
				var_06.var_44ED = gettime() + var_07.var_5FE9 * 1000;
				param_00 thread scripts\mp\_damagefeedback::func_12E84("stun");
			}
		}
	}
}

//Function Number: 20
func_13B3A(param_00)
{
	level endon("game_ended");
	param_00 waittill("stop_bulletstorm");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 21
func_10A10(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(isdefined(self))
	{
		self rotateyaw(param_00,param_01,param_02,param_03);
	}

	wait(param_01);
	thread func_10A10(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 22
func_5116(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	wait(param_00);
	physicsexplosionsphere(param_01,param_02,param_02,param_03);
}

//Function Number: 23
func_139B9(param_00,param_01,param_02)
{
	self endon("disconnect");
	self waittill("start_instant_ragdoll",var_03,var_04);
	scripts\common\utility::func_136F7();
	physicsexplosionsphere(param_00,param_01 + 40,param_01 + 20,param_02);
}

//Function Number: 24
func_5105(param_00,param_01)
{
	level endon("game_ended");
	wait(param_00);
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 25
func_811A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.var_38BF = 0;
	var_06.var_4D70 = 0;
	var_06.var_5FE9 = 0;
	var_07 = distance(param_01,param_04.origin);
	if(var_07 <= param_02)
	{
		if(var_07 <= 50)
		{
			var_06.var_38BF = 1;
		}
		else
		{
			var_08 = [];
			var_08[var_08.size] = "physicscontents_solid";
			var_08[var_08.size] = "physicscontents_glass";
			var_08[var_08.size] = "physicscontents_vehicle";
			var_09 = physics_createcontents(var_08);
			var_0A = [];
			var_0B = function_0287(param_01,param_04.origin,var_09,var_0A,0,"physicsquery_any");
			if(!var_0B)
			{
				var_06.var_38BF = 1;
			}
		}

		if(var_06.var_38BF)
		{
			if(param_00 == 1)
			{
				var_06.var_4D70 = param_05 - param_05 / param_02 / var_07;
			}
			else
			{
				var_0C = 1 - var_07 / param_02;
				if(var_0C < 0)
				{
					var_0C = 0;
				}

				var_0D = 2 + 4 * var_0C;
				var_06.var_5FE9 = scripts\mp\perks\_perkfunctions::func_20E0(param_03,param_04,var_0D);
			}
		}
	}

	return var_06;
}