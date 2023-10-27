/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3553.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:40 AM
*******************************************************************/

//Function Number: 1
func_44F9()
{
	level._effect["coneFlash_wave"] = loadfx("vfx/iw7/_requests/mp/trail_kinetic_wave");
	level._effect["coneFlash_wedge"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_wave_wedge");
	level._effect["coneFlash_explosion"] = loadfx("vfx/old/_requests/archetypes/vfx_cone_flash_exp");
	level._effect["coneFlash_explosionScreen"] = loadfx("vfx/old/_requests/archetypes/vfx_cone_flash_exp_scr");
}

//Function Number: 2
func_44FB()
{
	func_44F1();
}

//Function Number: 3
func_44FD()
{
	self notify("coneFlash_unset");
	func_44F4();
}

//Function Number: 4
func_44FF()
{
	thread func_4500();
	func_44F5();
}

//Function Number: 5
func_44F4()
{
	self notify("coneFlash_end");
}

//Function Number: 6
func_4500()
{
	self endon("coneFlash_end");
	scripts\common\utility::waittill_any_3("death","disconnect");
	thread func_44F4();
}

//Function Number: 7
func_44F5()
{
	var_00 = undefined;
	if(level.teambased)
	{
		var_00 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(self.team));
	}
	else
	{
		var_00 = level.var_3CB5;
	}

	var_01 = self gettagorigin("tag_eye");
	var_02 = self geteye() + anglestoforward(self getplayerangles()) * 454;
	var_03 = scripts\common\trace::func_48BC(0,1,1,0,0,0,0);
	var_04 = function_0287(var_01,var_02,var_03,undefined,0,"physicsquery_closest");
	if(isdefined(var_04) && var_04.size > 0)
	{
		var_02 = var_04[0]["position"];
	}

	var_05 = vectortoangles(var_02 - var_01);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoup(var_05);
	var_08 = -96 * var_06;
	var_09 = var_01 + var_08;
	thread func_44F6(var_01,var_02,var_05);
	var_0A = 0;
	foreach(var_0C in var_00)
	{
		if(!func_44FC(var_0C))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_D64B(var_0C gettagorigin("j_spineupper"),var_09,var_06,var_07,550,96,22,72))
		{
			continue;
		}

		var_04 = function_0287(self geteye(),var_0C geteye(),var_03,undefined,0,"physicsquery_closest");
		if(isdefined(var_04) && var_04.size != 0)
		{
			continue;
		}

		var_0D = var_0C gettagorigin("j_spineupper") - var_09;
		var_0E = vectordot(var_06,var_0D);
		if(var_0E <= 550)
		{
			if(var_0E <= 296)
			{
				var_0C dodamage(45,self.origin,self,self,"MOD_IMPACT","coneflash_mp");
			}
			else
			{
				var_0C dodamage(27,self.origin,self,self,"MOD_IMPACT","coneflash_mp");
			}
		}

		var_0F = min(max(var_0E,296),550);
		var_10 = 1 - var_0F - 296 / 254;
		var_11 = 0.5 * 1 + vectordot(var_06,vectornormalize(var_0D));
		thread func_44F0(var_0C,var_09,var_10,var_11);
		var_0A++;
	}

	func_44F8(var_0A);
}

//Function Number: 8
func_44F0(param_00,param_01,param_02,param_03)
{
	param_00 endon("disconnect");
	param_00 notify("flashbang",param_01,param_02,param_03,self,self.team,1.33);
	scripts\mp\_gamescore::func_11ACE(self,param_00,"power_coneFlash");
	param_00 scripts\common\utility::waittill_any_timeout_1(1.33,"death");
	if(isdefined(self))
	{
		scripts\mp\_gamescore::func_12D6F(self,param_00,"power_coneFlash");
	}
}

//Function Number: 9
func_44F8(param_00)
{
	var_01 = scripts\mp\_lightarmor::func_7F73(self);
	var_01 = min(self.maxhealth,var_01 + param_00 * 45);
	scripts\mp\_lightarmor::func_F786(self,var_01);
}

//Function Number: 10
func_44FC(param_00)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return 0;
	}

	if(param_00 == self)
	{
		return 0;
	}

	if(level.teambased && param_00.team == self.team)
	{
		return 0;
	}

	if(!lib_0DF8::func_213D(self,param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
func_44F6(param_00,param_01,param_02)
{
	self playlocalsound("kinetic_pulse");
	self playsoundtoteam("kinetic_pulse_npc","axis",self);
	self playsoundtoteam("kinetic_pulse_npc","allies",self);
	var_03 = func_44F7();
	var_03.origin = param_00;
	var_03.angles = param_02;
	var_04 = vectordot(param_01 - param_00,anglestoforward(param_02));
	var_05 = max(0.05,var_04 / 8000);
	var_03 moveto(param_01,var_05);
	var_06 = scripts\common\utility::getfx("coneFlash_explosion");
	playfxontag(var_06,var_03,"tag_origin");
}

//Function Number: 12
func_44F1()
{
	self.var_4502 = [];
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		var_01 = spawn("script_model",(10000,10000,0));
		var_01 setmodel("tag_origin");
		self.var_4502[var_00] = var_01;
	}

	thread func_44FE();
}

//Function Number: 13
func_44FE()
{
	self endon("disconnect");
	self endon("coneFlash_unset");
	for(;;)
	{
		self.var_4502[0].origin = self gettagorigin("tag_eye");
		self.var_4502[0].angles = self getplayerangles();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 14
func_44F2()
{
	if(!isdefined(self.var_4502))
	{
		return;
	}

	var_00 = scripts\common\utility::getfx("coneFlash_explosion");
	foreach(var_02 in self.var_4502)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		stopfxontag(var_00,var_02,"tag_origin");
		var_02 delete();
	}

	self.var_4502 = undefined;
}

//Function Number: 15
func_4501()
{
	scripts\common\utility::waittill_any_3("coneflash_unset","disconnect");
	func_44F2();
}

//Function Number: 16
func_44F7()
{
	var_00 = self.var_4502[0];
	var_01 = [];
	for(var_02 = 1;var_02 < 3;var_02++)
	{
		var_01[var_01.size] = self.var_4502[var_02];
	}

	var_01[var_01.size] = var_00;
	self.var_4502 = var_01;
	return var_00;
}