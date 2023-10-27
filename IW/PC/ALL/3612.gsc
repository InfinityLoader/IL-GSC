/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3612.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:30:54 AM
*******************************************************************/

//Function Number: 1
func_200A()
{
	level._effect["impact_shock"] = loadfx("vfx/iw7/core/impact/custom/vfx_imp_cstm_antigrav_barrel.vfx");
	level._effect["fuse_shock"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_barrel_buildup.vfx");
	level._effect["antigrav_explosion"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_barrel_blow.vfx");
	var_00 = getentarray("phys_antigrav_destructible","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_2007();
	}
}

//Function Number: 2
func_2007()
{
	self endon("barrel_death");
	self endon("barrel_delete");
	lib_0E1D::func_2840("antigrav",120,350,9100,15000,80,28);
	thread func_2008();
	var_00 = 3;
	var_01 = 0;
	var_02 = 120;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E);
		if(isdefined(var_06) && isai(var_06))
		{
			continue;
		}

		if(isdefined(var_06) && isdefined(var_06.var_9D62))
		{
			continue;
		}

		if(isdefined(var_0E) && scripts\common\utility::func_13C07(var_0E) == "sniper")
		{
			var_05 = 999999;
			var_00 = 0;
		}

		var_02 = int(var_02 - var_05);
		if(var_02 <= 0 && !isdefined(self.var_C528))
		{
			var_02 = 50;
		}

		if(var_02 <= 0)
		{
			break;
		}

		self.var_2836 = var_02;
		if(var_02 <= 50)
		{
			if(!var_01)
			{
				if(!var_04)
				{
					var_04 = 1;
					if(soundexists("antigrav_battery_damaged_warning_lp"))
					{
						thread scripts\sp\_utility::func_CD81("antigrav_battery_damaged_warning_lp","tag_origin",1,1);
					}
				}

				playfxontag(scripts\common\utility::getfx("fuse_shock"),self,"tag_origin");
				var_01 = 1;
				self.var_C528 = 1;
			}

			var_0F = var_02 / 50;
			var_00 = var_00 * var_0F;
			thread lib_0E1D::func_2835(var_00);
		}

		if(isdefined(var_07))
		{
			var_10 = length(var_07);
			if(var_10 > 20)
			{
				var_11 = vectornormalize(var_07);
				var_12 = 20;
				if(isdefined(var_09) && var_09 == "MOD_IMPACT")
				{
					var_12 = 3;
				}

				var_07 = var_11 * var_12;
			}

			self physicslaunchserver(var_08,var_07 * 1000);
		}

		if(!isdefined(var_09))
		{
			continue;
		}

		var_13 = strtok(var_09,"_");
		if(!scripts\common\utility::func_2286(var_13,"BULLET"))
		{
			continue;
		}

		var_14 = scripts\common\utility::spawn_tag_origin(var_08);
		var_15 = vectornormalize(self.origin - var_08);
		var_16 = vectortoangles(var_15 * -1);
		var_14.angles = scripts\common\utility::func_6EE1(var_16);
		var_14 linkto(self);
		if(!var_03)
		{
			var_03 = 1;
			if(soundexists("antigrav_battery_damaged_lp"))
			{
				var_14 thread scripts\sp\_utility::func_CD81("antigrav_battery_damaged_lp","tag_origin",1,1);
			}
		}

		playfxontag(scripts\common\utility::getfx("impact_shock"),var_14,"tag_origin");
		self.var_109DB = scripts\common\utility::array_add(self.var_109DB,var_14);
	}

	while(isdefined(self.var_5945))
	{
		scripts\common\utility::func_136F7();
	}

	self notify("barrel_death");
}

//Function Number: 3
func_2008()
{
	self endon("barrel_delete");
	self waittill("barrel_death");
	physicsexplosionsphere(self.origin,self.var_CAF6,0,2);
	earthquake(0.4,0.8,self.origin,700);
	thread lib_0E1D::func_2831(350,self.origin);
	thread lib_0E21::func_200B();
	thread scripts\sp\_detonategrenades::func_DBDB(self.origin);
	var_00 = 0.3;
	var_01 = sortbydistance(level.var_CAF7,self.origin);
	foreach(var_03 in var_01)
	{
		if(var_03 == self)
		{
			continue;
		}

		var_04 = distance(self.origin,var_03.origin);
		if(var_04 > self.var_CAF6)
		{
			continue;
		}

		var_05 = self.var_CAF6 - var_04;
		var_06 = var_05 / self.var_CAF6;
		var_07 = var_00 * var_06;
		if(var_04 <= self.var_CAF6)
		{
			var_03 thread lib_0E1D::func_2837(self.origin,var_04,var_07);
		}

		if(var_04 <= 340)
		{
			var_03 thread func_2009(self.origin,var_04,var_07);
		}
	}

	radiusdamage(self.origin,2,1,0,self);
	scripts\common\utility::func_136F7();
	if(soundexists("antigrav_battery_explode"))
	{
		function_0178("antigrav_battery_explode",self.origin);
	}

	playfx(scripts\common\utility::getfx("antigrav_explosion"),self.origin);
	foreach(var_0A in self.var_109DB)
	{
		killfxontag(scripts\common\utility::getfx("impact_shock"),var_0A,"tag_origin");
		scripts\common\utility::func_136F7();
		if(isdefined(var_0A))
		{
			var_0A delete();
		}
	}

	killfxontag(scripts\common\utility::getfx("fuse_shock"),self,"tag_origin");
	scripts\common\utility::func_136F7();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 4
func_2009(param_00,param_01,param_02)
{
	self endon("barrel_death");
	self endon("barrel_delete");
	wait(param_02);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C528))
	{
		return;
	}

	var_03 = 95;
	var_04 = 340;
	if(param_01 <= 90)
	{
		var_05 = 20;
		var_06 = 90 - param_01 / var_04;
		var_07 = 70 + var_06 * var_05;
	}
	else
	{
		var_06 = var_07 - var_03 / var_07;
		var_07 = var_07 * var_04;
	}

	self notify("damage",var_07);
}