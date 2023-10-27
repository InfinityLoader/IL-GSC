/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_overheat.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 8
 * Decompile Time: 132 ms
 * Timestamp: 10/27/2023 2:34:30 AM
*******************************************************************/

//Function Number: 1
func_3C6F()
{
	precacheshader("hud_temperature_gauge");
}

//Function Number: 2
overheat_enable(param_00)
{
	if(isdefined(self.var_37C2))
	{
		return;
	}

	self.var_37C2 = spawnstruct();
	self.var_37C2.turret_heat_status = 1;
	self.var_37C2.overheated = 0;
	self.var_37C2.var_3C72 = 114;
	self.var_37C2.turret_heat_rate = 1;
	self.var_37C2.turret_cool_rate = 1;
	self.var_37C2.var_3C75 = 2;
	self.var_37C2.var_3C76 = 0.2;
	self.var_37C2.overheat_flash_time_increment = 0.1;
	self.var_37C2.var_3C78 = 2;
	thread create_hud();
	thread status_meter_update(param_00);
}

//Function Number: 3
overheat_disable()
{
	self notify("disable_overheat");
	level.savehere = undefined;
	waittillframeend;
	if(isdefined(self.var_37C2.var_3C7A))
	{
		self.var_37C2.var_3C7A destroy();
	}

	if(isdefined(self.var_37C2.var_3C7B))
	{
		self.var_37C2.var_3C7B destroy();
	}

	self.var_37C2 = undefined;
}

//Function Number: 4
status_meter_update(param_00)
{
	self endon("disable_overheat");
	for(;;)
	{
		if(self.var_37C2.turret_heat_status >= self.var_37C2.var_3C72)
		{
			wait 0.05;
			continue;
		}

		if(self attackbuttonpressed() && !self.var_37C2.overheated)
		{
			self.var_37C2.turret_heat_status = self.var_37C2.turret_heat_status + self.var_37C2.turret_heat_rate;
		}
		else
		{
			self.var_37C2.turret_heat_status = self.var_37C2.turret_heat_status - self.var_37C2.turret_cool_rate;
		}

		self.var_37C2.turret_heat_status = clamp(self.var_37C2.turret_heat_status,1,self.var_37C2.var_3C72);
		func_3C7D();
		thread overheated(param_00);
		wait 0.05;
	}
}

//Function Number: 5
func_3C7D()
{
	self.var_37C2.var_3C7B scaleovertime(0.05,10,int(self.var_37C2.turret_heat_status));
	thread func_3C7F(self.var_37C2.turret_heat_status,0.05);
}

//Function Number: 6
create_hud()
{
	self endon("disable_overheat");
	var_00 = 0;
	if(maps\_utility::func_E89())
	{
		var_00 = 70;
	}

	var_01 = -10;
	var_02 = -152 + var_00;
	if(!isdefined(self.var_37C2.var_3C7A))
	{
		self.var_37C2.var_3C7A = newclienthudelem(self);
		self.var_37C2.var_3C7A.alignx = "right";
		self.var_37C2.var_3C7A.aligny = "bottom";
		self.var_37C2.var_3C7A.horzalign = "right";
		self.var_37C2.var_3C7A.vertalign = "bottom";
		self.var_37C2.var_3C7A.x = 2;
		self.var_37C2.var_3C7A.y = -120 + var_00;
		self.var_37C2.var_3C7A setshader("hud_temperature_gauge",35,150);
		self.var_37C2.var_3C7A.sort = 4;
	}

	if(!isdefined(self.var_37C2.var_3C7B))
	{
		self.var_37C2.var_3C7B = newclienthudelem(self);
		self.var_37C2.var_3C7B.alignx = "right";
		self.var_37C2.var_3C7B.aligny = "bottom";
		self.var_37C2.var_3C7B.horzalign = "right";
		self.var_37C2.var_3C7B.vertalign = "bottom";
		self.var_37C2.var_3C7B.x = var_01;
		self.var_37C2.var_3C7B.y = var_02;
		self.var_37C2.var_3C7B setshader("white",10,1);
		self.var_37C2.var_3C7B.color = (1,0.9,0);
		self.var_37C2.var_3C7B.alpha = 1;
		self.var_37C2.var_3C7B.sort = 1;
	}
}

//Function Number: 7
overheated(param_00)
{
	self endon("disable_overheat");
	if(self.var_37C2.turret_heat_status < self.var_37C2.var_3C72)
	{
		return;
	}

	if(self.var_37C2.overheated)
	{
		return;
	}

	self.var_37C2.overheated = 1;
	level.savehere = 0;
	thread maps\_utility::play_sound_on_entity("smokegrenade_explode_default");
	self.var_37C2.turret_heat_status = self.var_37C2.var_3C72;
	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret[0] turretfiredisable();
	}

	var_01 = gettime();
	var_02 = self.var_37C2.var_3C76;
	for(;;)
	{
		self.var_37C2.var_3C7B fadeovertime(var_02);
		self.var_37C2.var_3C7B.alpha = 0.2;
		wait var_02;
		self.var_37C2.var_3C7B fadeovertime(var_02);
		self.var_37C2.var_3C7B.alpha = 1;
		wait var_02;
		var_02 = var_02 + self.var_37C2.overheat_flash_time_increment;
		if(gettime() - var_01 >= self.var_37C2.var_3C75 * 1000)
		{
			break;
		}
	}

	self.var_37C2.var_3C7B.alpha = 1;
	self.var_37C2.turret_heat_status = self.var_37C2.turret_heat_status - self.var_37C2.turret_cool_rate;
	wait self.var_37C2.var_3C78;
	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret[0] turretfireenable();
	}

	level.savehere = undefined;
	self.var_37C2.overheated = 0;
}

//Function Number: 8
func_3C7F(param_00,param_01)
{
	self endon("disable_overheat");
	var_02 = [];
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = 0;
	var_07 = self.var_37C2.var_3C72 / 2;
	var_08 = self.var_37C2.var_3C72;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	if(param_01 > var_06 && param_01 <= var_07)
	{
		var_09 = int(param_01 * 100 / var_07);
		for(var_0C = 0;var_0C < var_05.size;var_0C++ = var_41[2])
		{
			var_0A = var_03[var_0C] - var_41[var_0C];
			var_0B = var_0A / 100;
			var_05[var_0C] = var_41[var_0C] + var_0B * var_09;
		}
	}
	else if(param_01 > var_07 && param_01 <= var_08)
	{
		var_09 = int(param_01 - var_07 * 100 / var_08 - var_07);
		for(var_0C = 0;var_0C < var_05.size;var_0C++ = var_41[2])
		{
			var_0A = var_04[var_0C] - var_03[var_0C];
			var_0B = var_0A / 100;
			var_05[var_0C] = var_03[var_0C] + var_0B * var_09;
		}
	}

	if(isdefined(var_02))
	{
		self.var_37C2.var_3C7B fadeovertime(var_02);
	}

	if(isdefined(self.var_37C2.var_3C7B.color))
	{
		self.var_37C2.var_3C7B.color = (var_05[0],var_05[1],var_05[2]);
	}
}