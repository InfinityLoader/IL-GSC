/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3570.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_C7E4 = loadfx("vfx/core/mp/ability/vfx_aslt_overcharge_scrn");
	level.var_C7E5 = loadfx("vfx/core/mp/ability/vfx_aslt_overcharge_world_view");
}

//Function Number: 2
func_F7AB()
{
	self.var_D782["power_multiVisor"].var_1348E = 0;
	self.var_D782["power_multiVisor"].var_1348F[0] = "default";
	self.var_D782["power_multiVisor"].var_1348F[1] = "thermal";
	self.var_D782["power_multiVisor"].var_1348F[2] = "sitrep";
	self.var_D782["power_multiVisor"].var_1348F[3] = "phase";
	self.var_8BD7 = 0;
}

//Function Number: 3
func_E13F()
{
	self notify("removeMultiVisor");
	func_E12D();
}

//Function Number: 4
func_130A7()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	level endon("game_ended");
	thread func_E27E();
	var_00 = self.var_D782["power_multiVisor"];
	var_01 = self.var_D782["power_multiVisor"].var_1348E;
	var_02 = 4;
	func_E27F(var_01,var_02);
	scripts\common\utility::func_136F7();
	self.var_D782["power_multiVisor"].var_1348E = var_02;
	func_20D0();
	self notify("power_multi_visor_update",0);
	self playlocalsound("mp_overcharge_on");
	thread func_BDCD();
	return 1;
}

//Function Number: 5
func_BDCD()
{
	self endon("death");
	self endon("disconnect");
	self endon("removemultivisor");
	var_00 = gettime() + 10000;
	while(var_00 > gettime())
	{
		wait(0.05);
	}

	func_E27F(0,4);
}

//Function Number: 6
func_C5A5(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	level endon("game_ended");
	switch(param_00)
	{
		case 0:
			self iprintlnbold("DEFAULT");
			break;

		case 1:
			self iprintlnbold("THERMAL");
			break;

		case 2:
			self iprintlnbold("SITREP");
			break;

		case 3:
			self iprintlnbold("PHASE");
			break;

		case 4:
			break;

		default:
			self iprintlnbold("DEFAULT");
			break;
	}
}

//Function Number: 7
func_20C1(param_00)
{
	self endon("multivisor_reset");
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	thread func_E12D();
	self.var_8BD7 = 0;
}

//Function Number: 8
func_20D0()
{
	self endon("multivisor_reset");
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	self thermalvisionon();
	thread func_20CE();
	if(!self.var_8BD7)
	{
		scripts\mp\_utility::func_8387("specialty_detectexplosive");
	}

	self.var_8BD7 = 1;
	thread func_E88F();
}

//Function Number: 9
func_20E1(param_00)
{
	self endon("multivisor_reset");
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	self thermalvisionon();
	thread func_20CE();
	self.var_8BD7 = 0;
}

//Function Number: 10
func_20DB(param_00)
{
	self endon("multivisor_reset");
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	if(!self.var_8BD7)
	{
		scripts\mp\_utility::func_8387("specialty_detectexplosive");
	}

	self.var_8BD7 = 1;
}

//Function Number: 11
func_20D7(param_00)
{
	self endon("multivisor_reset");
	self endon("death");
	self endon("disconnect");
	self endon("removeMultiVisor");
	self visionsetnakedforplayer("phase_shift_mp",0);
	thread func_E88F();
	self.var_8BD7 = 0;
}

//Function Number: 12
func_E88F()
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(self.var_D782["power_multiVisor"]))
	{
		return;
	}

	while(self.var_D782["power_multiVisor"].var_1348E == 4)
	{
		foreach(var_01 in level.players)
		{
			if(lib_0DF8::func_9DDF(var_01))
			{
				var_01 showtoplayer(self);
			}
		}

		wait(0.05);
	}

	foreach(var_01 in level.players)
	{
		if(lib_0DF8::func_9DDF(var_01))
		{
			var_01 method_8429(self);
		}
	}
}

//Function Number: 13
func_E27F(param_00,param_01)
{
	if(param_00 != param_01)
	{
		self thermalvisionoff();
		self visionsetnakedforplayer("",0);
		if(self.var_8BD7)
		{
			scripts\mp\_utility::func_E150("specialty_detectexplosive");
			self.var_8BD7 = 0;
		}

		func_E12D();
	}
}

//Function Number: 14
func_E27E()
{
	self endon("power_multi_visor_update");
	self waittill("death");
	self notify("multivisor_reset");
}

//Function Number: 15
func_20CE()
{
	self setclientomnvar("ui_multiVisorOverlay",1);
}

//Function Number: 16
func_E12D()
{
	self setclientomnvar("ui_multiVisorOverlay",0);
}