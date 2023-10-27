/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_overheat.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 94 ms
 * Timestamp: 10/27/2023 2:20:14 AM
*******************************************************************/

//Function Number: 1
init_overheat()
{
	precacheshader("hud_temperature_gauge");
}

//Function Number: 2
overheat_enable(param_00)
{
	if(isdefined(self.overheat))
	{
		return;
	}

	self.overheat = spawnstruct();
	self.overheat.turret_heat_status = 1;
	self.overheat.overheated = 0;
	self.overheat.turret_heat_max = 114;
	self.overheat.turret_heat_rate = 1;
	self.overheat.turret_cool_rate = 1;
	self.overheat.overheat_time = 2;
	self.overheat.overheat_flash_time = 0.2;
	self.overheat.overheat_flash_time_increment = 0.1;
	self.overheat.gun_usage_delay_after_overheat = 2;
	thread create_hud();
	thread status_meter_update(param_00);
}

//Function Number: 3
overheat_disable()
{
	self notify("disable_overheat");
	level.savehere = undefined;
	waittillframeend;
	if(isdefined(self.overheat.overheat_bg))
	{
		self.overheat.overheat_bg destroy();
	}

	if(isdefined(self.overheat.overheat_status))
	{
		self.overheat.overheat_status destroy();
	}

	self.overheat = undefined;
}

//Function Number: 4
status_meter_update(param_00)
{
	self endon("disable_overheat");
	for(;;)
	{
		if(self.overheat.turret_heat_status >= self.overheat.turret_heat_max)
		{
			wait 0.05;
			continue;
		}

		if(self attackbuttonpressed() && !self.overheat.overheated)
		{
			self.overheat.turret_heat_status = self.overheat.turret_heat_status + self.overheat.turret_heat_rate;
		}
		else
		{
			self.overheat.turret_heat_status = self.overheat.turret_heat_status - self.overheat.turret_cool_rate;
		}

		self.overheat.turret_heat_status = clamp(self.overheat.turret_heat_status,1,self.overheat.turret_heat_max);
		update_overheat_meter();
		thread overheated(param_00);
		wait 0.05;
	}
}

//Function Number: 5
update_overheat_meter()
{
	self.overheat.overheat_status scaleovertime(0.05,10,int(self.overheat.turret_heat_status));
	thread overheat_setcolor(self.overheat.turret_heat_status,0.05);
}

//Function Number: 6
create_hud()
{
	self endon("disable_overheat");
	var_00 = 0;
	if(maps\_utility::is_coop())
	{
		var_00 = 70;
	}

	var_01 = -10;
	var_02 = -152 + var_00;
	if(!isdefined(self.overheat.overheat_bg))
	{
		self.overheat.overheat_bg = newclienthudelem(self);
		self.overheat.overheat_bg.alignx = "right";
		self.overheat.overheat_bg.aligny = "bottom";
		self.overheat.overheat_bg.horzalign = "right";
		self.overheat.overheat_bg.vertalign = "bottom";
		self.overheat.overheat_bg.x = 2;
		self.overheat.overheat_bg.y = -120 + var_00;
		self.overheat.overheat_bg setshader("hud_temperature_gauge",35,150);
		self.overheat.overheat_bg.sort = 4;
	}

	if(!isdefined(self.overheat.overheat_status))
	{
		self.overheat.overheat_status = newclienthudelem(self);
		self.overheat.overheat_status.alignx = "right";
		self.overheat.overheat_status.aligny = "bottom";
		self.overheat.overheat_status.horzalign = "right";
		self.overheat.overheat_status.vertalign = "bottom";
		self.overheat.overheat_status.x = var_01;
		self.overheat.overheat_status.y = var_02;
		self.overheat.overheat_status setshader("white",10,1);
		self.overheat.overheat_status.color = (1,0.9,0);
		self.overheat.overheat_status.alpha = 1;
		self.overheat.overheat_status.sort = 1;
	}
}

//Function Number: 7
overheated(param_00)
{
	self endon("disable_overheat");
	if(self.overheat.turret_heat_status < self.overheat.turret_heat_max)
	{
		return;
	}

	if(self.overheat.overheated)
	{
		return;
	}

	self.overheat.overheated = 1;
	level.savehere = 0;
	thread maps\_utility::play_sound_on_entity("smokegrenade_explode_default");
	self.overheat.turret_heat_status = self.overheat.turret_heat_max;
	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret[0] turretfiredisable();
	}

	var_01 = gettime();
	var_02 = self.overheat.overheat_flash_time;
	for(;;)
	{
		self.overheat.overheat_status fadeovertime(var_02);
		self.overheat.overheat_status.alpha = 0.2;
		wait var_02;
		self.overheat.overheat_status fadeovertime(var_02);
		self.overheat.overheat_status.alpha = 1;
		wait var_02;
		var_02 = var_02 + self.overheat.overheat_flash_time_increment;
		if(gettime() - var_01 >= self.overheat.overheat_time * 1000)
		{
			break;
		}
	}

	self.overheat.overheat_status.alpha = 1;
	self.overheat.turret_heat_status = self.overheat.turret_heat_status - self.overheat.turret_cool_rate;
	wait self.overheat.gun_usage_delay_after_overheat;
	if(isdefined(param_00.mgturret))
	{
		param_00.mgturret[0] turretfireenable();
	}

	level.savehere = undefined;
	self.overheat.overheated = 0;
}

//Function Number: 8
overheat_setcolor(param_00,param_01)
{
	self endon("disable_overheat");
	var_02 = [];
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = 0;
	var_07 = self.overheat.turret_heat_max / 2;
	var_08 = self.overheat.turret_heat_max;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	if(param_01 > var_06 && param_01 <= var_07)
	{
		var_09 = int(param_01 * 100 / var_07);
		for(var_0C = 0;var_0C < var_05.size;var_0C++ = var_7B[2])
		{
			var_0A = var_03[var_0C] - var_7B[var_0C];
			var_0B = var_0A / 100;
			var_05[var_0C] = var_7B[var_0C] + var_0B * var_09;
		}
	}
	else if(param_01 > var_07 && param_01 <= var_08)
	{
		var_09 = int(param_01 - var_07 * 100 / var_08 - var_07);
		for(var_0C = 0;var_0C < var_05.size;var_0C++ = var_7B[2])
		{
			var_0A = var_04[var_0C] - var_03[var_0C];
			var_0B = var_0A / 100;
			var_05[var_0C] = var_03[var_0C] + var_0B * var_09;
		}
	}

	if(isdefined(var_02))
	{
		self.overheat.overheat_status fadeovertime(var_02);
	}

	if(isdefined(self.overheat.overheat_status.color))
	{
		self.overheat.overheat_status.color = (var_05[0],var_05[1],var_05[2]);
	}
}