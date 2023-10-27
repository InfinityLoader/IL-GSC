/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3578.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:30:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["plasmaSpear_trail"] = loadfx("vfx/old/_requests/mp_weapons/vfx_trail_life_link");
	level._effect["plasmaSpear_death"] = loadfx("vfx/old/_requests/mp_weapons/vfx_muz_plasma_blast_w");
	level._effect["plasmaSpear_trail2"] = loadfx("vfx/old/_requests/mp_weapons/vfx_trail_knife_tele");
	level._effect["plasmaSpear_trail2_enemy"] = loadfx("vfx/old/_requests/mp_weapons/vfx_trail_knife_tele_red");
}

//Function Number: 2
func_838F()
{
	self.var_CC58 = [];
	self.var_CC58[0] = scripts\common\utility::spawn_tag_origin();
	self.var_CC58[1] = scripts\common\utility::spawn_tag_origin();
	self.var_C243 = 0;
}

//Function Number: 3
func_E158()
{
	self notify("removePlasmaSpear");
	foreach(var_01 in self.var_CC58)
	{
		var_01 delete();
	}
}

//Function Number: 4
func_CC59(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removePlasmaSpear");
	self notify("powers_spear_used");
	var_01 = (0,0,32);
	if(self.var_C243)
	{
		var_02 = self.var_CC58[1];
		self.var_C3FF = self.var_CC5A;
		self.var_CC5A = param_00;
	}
	else
	{
		var_02 = self.var_CC58[0];
		self.var_CC5A = param_00;
	}

	var_02.origin = self.origin + var_01;
	self.var_C243++;
	var_02 show();
	thread func_CF18(var_02);
	param_00 scripts\common\utility::waittill_notify_or_timeout("missile_stuck",4);
	param_00 playsound("plasma_spear_impact");
	self notify("powers_spear_used");
	thread func_BCD5(param_00,var_02,var_01);
	thread func_CC56(param_00,var_02);
	thread func_13A80(param_00,var_02);
	thread func_13A54(param_00,var_02);
}

//Function Number: 5
func_BCD5(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("removePlasmaSpear");
	param_01.var_BCEC = 0;
	param_01.var_115F6 = 0;
	var_03 = 589824;
	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		var_04 = level.players;
		if(self.var_C243 > 1)
		{
			var_05 = param_00 gettagorigin("tag_end");
			var_06 = self.var_C3FF gettagorigin("tag_end");
			var_04[var_04.size] = param_00;
			var_04[var_04.size] = self.var_C3FF;
			var_03 = 1048576;
		}
		else
		{
			var_05 = param_00 gettagorigin("tag_end");
			var_06 = self.origin + param_02;
			var_04[var_04.size] = param_00;
			var_03 = 589824;
		}

		var_07 = scripts\common\trace::func_DCF1(var_06,var_05,level.players);
		var_08 = distancesquared(var_06,var_05);
		if(var_08 < var_03)
		{
			var_09 = 1;
		}
		else
		{
			var_09 = 0;
		}

		if(!var_07 || !var_09)
		{
			param_01.origin = var_05;
			param_01.var_115F6 = 0;
			var_0A = scripts\common\utility::func_DCC8(1);
			var_0B = vectortoangles(var_0A);
			var_0C = anglestoforward(var_0B);
			var_0D = var_05 + var_0C * randomintrange(64,128);
			param_01 moveto(var_0D,0.1);
			wait(0.1);
			continue;
		}

		param_01.var_115F6 = 1;
		if(scripts\common\utility::func_B8F8(param_01.var_BCEC,2) == 0)
		{
			param_01 moveto(var_05,0.25);
		}
		else
		{
			param_01 moveto(var_06,0.25);
		}

		param_01.var_BCEC++;
		wait(0.25);
	}
}

//Function Number: 6
func_CF18(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removePlasmaSpear");
	wait(0.05);
	if(isdefined(param_00))
	{
		param_00 playsoundonmovingent("plasma_spear_energy");
		if(level.teambased)
		{
			function_029A(level._effect["plasmaSpear_trail2"],param_00,"tag_origin",self.team);
			wait(0.05);
			function_029A(level._effect["plasmaSpear_trail2_enemy"],param_00,"tag_origin",scripts\mp\_utility::getotherteam(self.team));
			return;
		}

		playfxontagforclients(level._effect["plasmaSpear_trail2"],param_00,"tag_origin",self);
		wait(0.15);
		foreach(var_02 in level.players)
		{
			if(var_02 == self)
			{
				continue;
			}

			playfxontagforclients(level._effect["plasmaSpear_trail2_enemy"],param_00,"tag_origin",var_02);
			wait(0.15);
		}
	}
}

//Function Number: 7
func_13A54(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	stopfxontag(level._effect["plasmaSpear_trail2"],param_01,"tag_origin");
	stopfxontag(level._effect["plasmaSpear_trail2_enemy"],param_01,"tag_origin");
	self.var_C243--;
	param_01 hide();
}

//Function Number: 8
func_13A80(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	self.var_C243--;
	if(isdefined(param_01))
	{
		param_01 hide();
	}
}

//Function Number: 9
func_CC56(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(param_01))
		{
			return;
		}

		if(param_01.var_115F6)
		{
			var_02 = func_808B(32,param_01);
		}
		else
		{
			var_02 = func_808B(64,param_01);
		}

		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			var_05 = gettime();
			if(isdefined(var_04.var_118F4) && var_04.var_118F4 > var_05 + 500)
			{
				continue;
			}

			var_04.var_118F4 = var_05;
			var_04 thread [[ level.callbackplayerdamage ]](param_01,self,50,0,"MOD_MELEE","throwingreaper_mp",param_01.origin,undefined,"none",0);
			param_01 playsoundtoplayer("plasma_shock",var_04);
			var_04 playsoundonmovingent("plasma_shock_npc");
		}

		wait(0.05);
	}
}

//Function Number: 10
func_808B(param_00,param_01)
{
	var_02 = [];
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	foreach(var_04 in level.players)
	{
		if(!isdefined(param_01))
		{
			return;
		}

		if(var_04 == self)
		{
			continue;
		}

		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team != scripts\mp\_utility::getotherteam(self.team))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_04))
		{
			continue;
		}

		if(param_00 != 0)
		{
			var_05 = scripts\common\utility::func_56F4(param_01.origin,var_04.origin);
			var_06 = param_00 * param_00;
			if(var_05 > var_06)
			{
				continue;
			}
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}