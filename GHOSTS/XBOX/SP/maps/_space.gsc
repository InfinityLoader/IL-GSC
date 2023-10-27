/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_space.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 221 ms
 * Timestamp: 10/27/2023 1:37:26 AM
*******************************************************************/

//Function Number: 1
func_6101()
{
	precachematerial("hud_space_helmet_overlay");
}

//Function Number: 2
func_6FD0()
{
}

//Function Number: 3
set_glass_zero_gravity()
{
	function_0168("glass_angular_vel","1 5");
	function_0168("glass_linear_vel","20 40");
	function_0168("glass_fall_gravity",0);
	function_0168("glass_simple_duration",10000);
}

//Function Number: 4
func_5F13()
{
	if(!issplitscreen())
	{
		thread player_space_breathe_sound();
	}
	else if(self == level.player)
	{
		thread player_space_breathe_sound();
	}

	thread func_5EF7();
}

//Function Number: 5
player_space_breathe_sound()
{
	self endon("death");
	self endon("disable_space");
	self notify("start_space_breathe");
	self endon("start_space_breathe");
	self endon("stop_space_breathe");
	for(;;)
	{
		wait(0.05);
		self notify("space_breathe_sound_starting");
		self waittill("space_breathe_sound_done");
	}
}

//Function Number: 6
stop_player_space()
{
	self notify("stop_space_breathe");
	self stoplocalsound("scuba_breathe_player");
}

//Function Number: 7
debug_org()
{
	wait(0.5);
}

//Function Number: 8
func_5EF7()
{
	self endon("death");
	self endon("disable_space");
	self endon("stop_space_breathe");
	waittillframeend;
	self.var_5FAC = spawn("script_model",self.origin + (0,0,0));
	self.var_5FAC setmodel("tag_origin");
	self.var_5FAC.angles = self.angles;
	self.var_5FAC.origin = self geteye() - (0,0,10);
	self.var_5FAC method_8021(self,"tag_origin",(5,0,-55),(0,0,0),1);
	thread func_6D1B(self.var_5FAC);
	for(;;)
	{
		self waittill("space_breathe_sound_starting");
		wait(2.1);
		if(common_scripts\utility::func_1DE9())
		{
			self waittill("space_breathe_sound_starting");
		}
	}
}

//Function Number: 9
func_6D1B(param_00)
{
	self waittill("stop_space_breathe");
	param_00 method_8022(self);
	param_00 delete();
}

//Function Number: 10
func_5D93(param_00)
{
	self endon("stop_space_breathe");
}

//Function Number: 11
space_hud_enable(param_00)
{
	wait(0.05);
	if(param_00 == 1)
	{
		function_0168("hud_showStance","0");
		function_0168("compass","0");
	}

	function_0168("hud_drawhud","1");
	function_0168("hud_showStance","1");
	function_0168("compass","1");
}

//Function Number: 12
func_5F17(param_00)
{
	self.var_434C = maps\_hud_util::create_client_overlay("hud_space_helmet_overlay",1,self);
	self.var_434C.foreground = 0;
	self.var_434C.sort = -99;
}

//Function Number: 13
func_5F18(param_00)
{
	if(isdefined(self.hud_space_helmet_rim))
	{
		self.hud_space_helmet_rim maps\_hud_util::destroyelem();
	}

	if(isdefined(self.var_434C))
	{
		self.var_434C maps\_hud_util::destroyelem();
	}
}