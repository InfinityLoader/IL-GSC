/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3575.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:30:46 AM
*******************************************************************/

//Function Number: 1
func_CA2B()
{
	func_CA29(1);
}

//Function Number: 2
func_CA2C()
{
	self endon("death");
	self endon("disconnect");
	self endon("periphVis_end");
	self.var_CA7D = 1;
	self setclientomnvar("ui_ringradar_enabled",1);
	scripts\mp\_utility::func_D915("ring radar on",self);
	self setscriptablepartstate("periphVis","activeOn",0);
	thread func_CA2D();
	scripts\mp\_powers::func_4575(4.5,"periphVis_update");
	thread func_CA29();
}

//Function Number: 3
func_CA29(param_00)
{
	self endon("disconnect");
	self notify("periphVis_end");
	self notify("periphVis_update",0);
	if(scripts\mp\_utility::func_9FB3(param_00))
	{
		self setclientomnvar("ui_ringradar_enabled",0);
		self setscriptablepartstate("periphVis","neutral",0);
	}
	else
	{
		self setclientomnvar("ui_ringradar_enabled",2);
		wait(0.75);
		self setscriptablepartstate("periphVis","activeOff",0);
	}

	self.var_CA7D = undefined;
	scripts\mp\_utility::func_D915("ring radar off",self);
}

//Function Number: 4
func_CA2A()
{
	if(scripts\mp\_utility::func_9FB3(self.var_CA7D))
	{
		thread func_CA29(1);
	}
}

//Function Number: 5
func_CA2D()
{
	self endon("disconnect");
	self endon("periphVis_end");
	scripts\common\utility::waittill_any_3("death","phase_shift_start");
	thread func_CA29(1);
}