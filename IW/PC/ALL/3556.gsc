/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3556.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:30:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["slam_sml"] = loadfx("vfx/old/_requests/archetypes/vfx_heavy_slam_s");
	level._effect["slam_lrg"] = loadfx("vfx/old/_requests/archetypes/vfx_heavy_slam_l");
	level._effect["dash_dust"] = loadfx("vfx/core/screen/vfx_scrnfx_tocam_slidedust_m");
	level._effect["dash_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_dash_trail");
}

//Function Number: 2
func_835F()
{
}

//Function Number: 3
func_E0E9()
{
	self notify("removeDash");
}

//Function Number: 4
func_4D90()
{
	if(isbot(self))
	{
		return;
	}

	self endon("removeDash");
	self endon("death");
	self endon("disconnect");
	self.var_D782["power_dash"].var_19 = 1;
	var_00 = func_4D88(self);
	var_01 = func_4D8C(self,var_00);
	self.var_D782["power_dash"].var_19 = 0;
	return var_01;
}

//Function Number: 5
func_4D91(param_00)
{
	return param_00 isonground() == 0 && param_00 getstance() != "prone";
}

//Function Number: 6
func_4D88(param_00)
{
	var_01 = param_00 getnormalizedmovement();
	var_02 = anglestoright(param_00.angles);
	var_03 = anglestoforward(param_00.angles);
	var_04 = var_03 * var_01[0] + var_02 * var_01[1];
	var_05 = param_00.origin + var_04 * 175;
	return param_00 method_8007(param_00.origin + (0,0,20),var_05,16,80,0,0);
}

//Function Number: 7
func_4D8C(param_00,param_01)
{
	var_02 = lengthsquared(param_00.origin - param_01);
	if(var_02 < 576)
	{
		return 0;
	}

	var_03 = param_00 scripts\common\utility::spawn_tag_origin();
	thread func_4D89(param_00,var_03);
	func_4D8D(param_00,param_01,var_03);
	param_00 notify("dash_finished");
	return 1;
}

//Function Number: 8
func_4D8D(param_00,param_01,param_02)
{
	var_03 = param_00.origin - param_01;
	var_04 = lengthsquared(var_03);
	var_05 = self method_8123();
	var_06 = 0;
	if(var_04 >= 28224)
	{
		var_06 = 1;
	}

	if(param_00 isonground())
	{
		param_00 setstance("crouch");
	}

	param_00 playerlinkto(param_02,"tag_origin");
	func_4D8F("dash_dust");
	self playlocalsound("synaptic_dash");
	self playsound("synaptic_dash_npc");
	param_02 moveto(param_01,0.35,0.01,0);
	wait(0.35);
	if(0)
	{
		param_00 func_4D87();
	}

	wait(0.1);
	param_00 setvelocity(var_05 * 1.2);
	param_00 unlink();
	param_00 setstance("stand");
}

//Function Number: 9
func_4D8E()
{
	self endon("disconnect");
	playfxontag(scripts\common\utility::getfx("dash_trail"),self,"TAG_EYE");
	wait(0.35);
	stopfxontag(scripts\common\utility::getfx("dash_trail"),self,"TAG_EYE");
}

//Function Number: 10
func_4D87()
{
	var_00 = [];
	foreach(var_02 in level.var_3CB5)
	{
		if(!isdefined(var_02) || !isalive(var_02) || !scripts\mp\_utility::func_9DD6(var_02))
		{
			continue;
		}

		if(distancesquared(var_02.origin,self.origin) < 254016)
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(isdefined(var_00[0]))
	{
		var_00 = sortbydistance(var_00,self.origin);
		var_04 = var_00[0];
		var_05 = self gettagorigin("TAG_EYE");
		var_06 = var_04.origin;
		var_07 = vectortoangles(var_04.origin - self.origin);
		self setplayerangles(var_07);
	}
}

//Function Number: 11
func_4D89(param_00,param_01)
{
	param_00 scripts\common\utility::waittill_any_3("death","disconnect","dash_finished");
	scripts\common\utility::func_136F7();
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 12
func_4D92(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	wait(param_01);
	return 1;
}

//Function Number: 13
func_4D8F(param_00)
{
	thread func_4D8E();
	var_01 = (235.004,521.706,1.95469);
	var_02 = (270,0,0);
	var_03 = anglestoup(var_02);
	var_04 = anglestoforward(var_02);
	var_05 = function_01E1(level._effect[param_00],var_01,self,var_04,var_03);
	triggerfx(var_05);
	wait(0.05);
	var_05 delete();
}