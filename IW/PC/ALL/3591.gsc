/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3591.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 12:30:49 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["telereap_trail"] = loadfx("vfx/old/_requests/mp_weapons/vfx_knife_tele_start_blue");
	level._effect["telereap_smoke"] = loadfx("vfx/core/smktrail/teleport_smoke_bomb_mp");
	level._effect["dash_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
}

//Function Number: 2
func_83B2()
{
}

//Function Number: 3
func_E17E()
{
	self notify("removeTeleReap");
	if(isdefined(self.var_11669))
	{
		scripts\mp\_utility::func_C78F(self.var_11669,self.var_11667);
		self.var_11669 = undefined;
		self.var_11667 = undefined;
	}
}

//Function Number: 4
func_130E8()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeTeleReap");
	self.var_D782["power_teleReap"].var_19 = 1;
	if(self ismantling())
	{
		self playlocalsound("mp_reap_fail");
		self.var_D782["power_teleReap"].var_19 = 0;
		return 0;
	}

	var_00 = func_11666();
	if(!var_00)
	{
		self playlocalsound("mp_reap_fail");
	}

	self.var_D782["power_teleReap"].var_19 = 0;
	return var_00;
}

//Function Number: 5
func_11666()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = 384;
	var_01 = (0,0,32);
	var_02 = self.origin + var_01;
	var_03 = anglestoforward(self.angles);
	var_04 = var_02 + var_03 * var_00;
	var_05 = getclosestpointonnavmesh(var_04);
	if(var_05[2] > self.origin[2] || !self isonground())
	{
		if(var_05[2] > self.origin[2] + 64)
		{
			var_01 = (0,0,64);
		}

		var_05 = var_05 + var_01;
		var_02 = self.origin + var_01;
		var_04 = var_05;
	}

	var_06 = [];
	var_06[0] = self;
	var_06[1] = self.var_FC9F;
	var_07 = 0.35;
	var_08 = scripts\common\trace::func_48BC(1,1,1,0,0,1);
	var_09 = scripts\common\trace::func_3A09(var_02,var_04,16,32,(0,0,0),var_06,var_08);
	var_0A = 1;
	if(var_09["fraction"] != 1)
	{
		var_0A = var_09["fraction"] - 0.05;
		if(var_0A < 0.05)
		{
			return 0;
		}

		var_04 = var_02 + var_03 * var_00 * var_0A;
		var_07 = var_09["fraction"] * 0.35;
	}

	if(!canspawn(var_04))
	{
		for(var_0B = 0;var_0B < 10;var_0B++)
		{
			var_0A = var_0A / 1.15;
			var_04 = var_02 + var_03 * var_00 * var_0A;
			if(canspawn(var_04))
			{
				break;
			}
		}
	}

	self playlocalsound("reaper_dash");
	self playsound("reaper_dash_npc");
	thread func_D504();
	scripts\mp\_utility::func_1309("iw7_erad_mp",self.origin + (0,0,1000),self.origin + (0,0,2000),self);
	self playrumbleonentity("damage_heavy");
	earthquake(0.25,0.25,self.origin,32);
	self.var_9F1B++;
	thread func_11668();
	thread func_139E6();
	func_DD92(var_04,var_01,var_07);
	return 1;
}

//Function Number: 6
func_139E6()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_reap");
	level endon("game_ended");
	var_00 = [];
	for(;;)
	{
		var_01 = func_808B(384);
		foreach(var_03 in var_01)
		{
			var_04 = 0;
			if(distancesquared(self.origin,var_03.origin) > 2048)
			{
				continue;
			}

			if(scripts\common\utility::func_9F11(var_03))
			{
				continue;
			}

			if(var_03 scripts\mp\_utility::func_9D48("archetype_heavy"))
			{
				var_05 = self getvelocity();
				var_06 = var_05 * -1;
				var_03 setvelocity(var_06);
			}

			foreach(var_08 in var_00)
			{
				if(var_08 == var_03)
				{
					var_04 = 1;
				}
			}

			if(var_04)
			{
				continue;
			}

			var_03 playrumbleonentity("artillery_rumble");
			self playrumbleonentity("artillery_rumble");
			var_03 dodamage(150,self.origin,self,self,"MOD_MELEE");
			playrumbleonposition("artillery_rumble",self.origin);
			earthquake(0.5,0.5,self.origin,256);
			playsoundatpos(self.origin,"slide_impact");
			var_00[var_00.size] = var_03;
			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 7
func_627D()
{
	self.var_FCA5 = 1;
	self.var_FC9F.angles = self.angles + (0,90,0);
	self.var_FC9F.origin = lib_0D6E::func_36DB(64);
	self.var_FC9F show();
	self.var_FC9F setcandamage(1);
	thread lib_0D6E::func_BCEE(64);
	thread lib_0D6E::func_FC9C();
	self method_80AA();
	self allowjump(0);
	self allowprone(0);
}

//Function Number: 8
func_DD92(param_00,param_01,param_02)
{
	var_03 = self.origin + param_01;
	var_04 = scripts\common\utility::spawn_tag_origin();
	thread func_DD91(self,var_04);
	func_DD93(param_00,var_04,param_01,param_02);
	wait(0.25);
	self.var_9F1B--;
	self notify("stop_reap");
}

//Function Number: 9
func_DD93(param_00,param_01,param_02,param_03)
{
	var_04 = self.origin + param_02;
	var_05 = var_04 - param_00;
	var_06 = lengthsquared(var_05);
	var_07 = self method_8123();
	var_08 = lengthsquared(var_04 - param_00);
	self playerlinkto(param_01,"tag_origin");
	self playlocalsound("synaptic_dash");
	self playsound("synaptic_dash_npc");
	if(param_03 < 0.1)
	{
		var_09 = 0;
	}
	else
	{
		var_09 = 0.1;
	}

	if(param_03 <= 0)
	{
		param_03 = 0.1;
	}

	if(!isdefined(self.var_11667))
	{
		param_01 moveto(param_00,param_03,var_09,0);
		wait(param_03);
	}
	else
	{
		var_0A = func_8089(var_04);
		param_01 moveto(var_0A + param_02,param_03,var_09,0);
		wait(param_03 / 4);
		var_0A = func_8089(var_04);
		param_01 moveto(var_0A + param_02,param_03,0,0);
		wait(param_03 / 4);
		var_0A = func_8089(var_04);
		param_01 moveto(var_0A + param_02,param_03,0,0);
		wait(param_03 / 2);
	}

	wait(0.1);
	self unlink();
	self setvelocity(var_07 * 1.3);
	self setstance("stand");
}

//Function Number: 10
func_8089(param_00)
{
	var_01 = self.var_11667.origin - param_00;
	var_02 = distance(param_00,self.var_11667.origin);
	var_03 = vectortoangles(var_01);
	var_04 = anglestoforward(var_03);
	var_05 = param_00 + var_04 * var_02 + 100;
	if(capsuletracepassed(var_05,24,48,self,0,0))
	{
		return var_05;
	}

	return self.var_11667.origin;
}

//Function Number: 11
func_D504()
{
	self endon("disconnect");
	level endon("game_ended");
	playfxontag(scripts\common\utility::getfx("telereap_trail"),self,"TAG_EYE");
	wait(0.5);
	stopfxontag(scripts\common\utility::getfx("telereap_trail"),self,"TAG_EYE");
}

//Function Number: 12
func_DD91(param_00,param_01)
{
	param_00 scripts\common\utility::waittill_any_3("death","disconnect","stop_reap");
	scripts\common\utility::func_136F7();
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 13
func_808B(param_00)
{
	var_01 = [];
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == self)
		{
			continue;
		}

		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team != scripts\mp\_utility::getotherteam(self.team))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_03))
		{
			continue;
		}

		if(param_00 != 0)
		{
			var_04 = scripts\common\utility::func_56F4(self.origin,var_03.origin);
			var_05 = param_00 * param_00;
			if(var_04 > var_05)
			{
				continue;
			}
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 14
func_42A4(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = 100;
	var_02 = [];
	foreach(var_04 in param_00)
	{
		var_05 = var_04.origin - self.origin;
		var_06 = anglestoforward(self getplayerangles());
		var_07 = vectordot(var_05,var_06);
		if(var_07 <= 0)
		{
			continue;
		}

		var_08 = vectornormalize(var_05);
		var_09 = vectornormalize(var_06);
		var_07 = vectordot(var_08,var_09);
		var_04.var_5AC7 = var_07;
		var_02[var_02.size] = var_07;
	}

	var_0B = scripts\mp\_utility::func_DB9F(var_02);
	var_0C = [];
	for(var_0D = 0;var_0D < var_0B.size;var_0D++)
	{
		foreach(var_0F in param_00)
		{
			if(isdefined(var_0F.var_5AC7) && var_0F.var_5AC7 == var_0B[var_0D])
			{
				var_0C[var_0C.size] = var_0F;
			}
		}
	}

	return var_0C;
}

//Function Number: 15
func_11668()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = [];
	var_01 = [];
	self.var_11667 = undefined;
	var_00 = func_808B(384);
	var_02 = 0;
	if(isdefined(var_00) && var_00.size > 0)
	{
		if(var_00.size > 1)
		{
			var_01 = func_42A4(var_00);
		}
		else
		{
			var_01 = var_00;
		}
	}

	foreach(var_04 in var_01)
	{
		var_05 = var_04.origin - self.origin;
		var_06 = anglestoforward(self getplayerangles());
		var_07 = vectordot(var_05,var_06);
		if(var_07 <= 0)
		{
			continue;
		}

		var_08 = vectornormalize(var_05);
		var_09 = vectornormalize(var_06);
		var_07 = vectordot(var_08,var_09);
		if(var_07 < 0.9)
		{
			continue;
		}

		var_0A = self geteye();
		var_0B = var_04 geteye();
		var_0C = [];
		var_0C[0] = self;
		var_0C[1] = var_04;
		var_0D = scripts\common\trace::func_DCF1(var_0A,var_0B,var_0C);
		if(!var_0D)
		{
			continue;
		}

		self.var_11667 = var_04;
		var_02 = 1;
		break;
	}

	if(!var_02)
	{
		self.var_11667 = undefined;
	}
}