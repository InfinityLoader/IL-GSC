/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3543.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:30:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_2850 = [];
	level.var_2850["wave"] = loadfx("vfx/iw7/_requests/mp/trail_kinetic_wave");
	level.var_2850["wedge"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_wave_wedge");
	level.var_2850["halo"] = loadfx("vfx/iw7/_requests/mp/vfx_light_barrier_halo");
	level.var_2850["body"] = loadfx("vfx/iw7/_requests/mp/vfx_light_barrier_body");
	level.var_2850["start"] = loadfx("vfx/iw7/_requests/mp/vfx_barrier_start");
	level.var_2850["shot"] = loadfx("vfx/iw7/_requests/mp/vfx_barrier_trail");
	level.var_2850["activate"] = loadfx("vfx/iw7/_requests/mp/vfx_barrier_activate");
}

//Function Number: 2
func_E0D3()
{
	self notify("remove_barrier");
}

//Function Number: 3
func_E83A()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_barrier");
	self playlocalsound("kinetic_pulse");
	self playsound("kinetic_pulse_npc");
	thread func_284F();
}

//Function Number: 4
func_284E(param_00,param_01)
{
	self endon("disconnect");
	scripts\mp\_gamescore::func_11AC9(param_00,self,"power_barrier");
	var_02 = "j_spinelower";
	var_03 = "body";
	if(param_01)
	{
		self.var_8BF8 = 1;
		self iprintlnbold("BARRIER AND HEADGEAR APPLIED");
		playfxontag(level.var_2850["halo"],self,"j_head");
	}

	self.var_8BD3 = 1;
	self iprintlnbold("BARRIER APPLIED");
	scripts\mp\_lightarmor::func_F786(self,35);
	playfxontag(level.var_2850[var_03],self,var_02);
	thread func_2852(param_00,param_01);
	while(isdefined(self.var_ACAE))
	{
		wait(0.05);
	}

	thread func_2851(param_00,param_01);
}

//Function Number: 5
func_2851(param_00,param_01)
{
	stopfxontag(level.var_2850["halo"],self,"j_head");
	stopfxontag(level.var_2850["body"],self,"j_spinelower");
	if(param_01)
	{
		self.var_8BF8 = undefined;
	}

	self.var_8BD3 = undefined;
	scripts\mp\_gamescore::func_12D6E(param_00,self,"power_barrier");
}

//Function Number: 6
func_2852(param_00,param_01)
{
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("death");
	if(scripts\mp\_utility::func_9F19())
	{
		thread func_2851(param_00,param_01);
	}
}

//Function Number: 7
func_284F()
{
	var_00 = 0.2;
	var_01 = undefined;
	var_02 = scripts\common\utility::spawn_tag_origin(self.origin + (0,0,64));
	var_03 = spawn("script_model",var_02.origin);
	var_03 linkto(var_02);
	scripts\common\utility::func_136F7();
	var_04 = func_68D8(var_02);
	playfxontag(level.var_2850["shot"],var_02,"tag_origin");
	var_02 moveto(var_04["position"],var_00);
	wait(var_00);
	if(isdefined(var_04["entity"]) && isplayer(var_04["entity"]) && !isdefined(var_04["entity"].var_8BD3) && var_04["entity"].team == self.team)
	{
		var_05 = self method_8409(var_04["entity"] gettagorigin("tag_eye"),65,25);
		var_04["entity"] thread func_284E(self,var_05);
		playfx(level.var_2850["activate"],var_04["position"] + (0,0,20));
		self notify("powers_barrier_used",1);
	}
	else
	{
		self notify("powers_barrier_used",0);
	}

	var_03 delete();
	var_02 delete();
}

//Function Number: 8
func_68D8(param_00)
{
	var_01 = rotatepointaroundvector(anglestoup(self getplayerangles()),anglestoforward(self getplayerangles()),0);
	var_02 = self.origin + var_01 * 768;
	var_03 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(self.team));
	var_04 = scripts\common\utility::array_combine(var_03,func_7E0D());
	var_05 = scripts\common\utility::array_add(var_04,self);
	var_06 = scripts\common\trace::func_109DD(self.origin + (0,0,64),var_02,12,var_05);
	if(!isdefined(var_06) || var_06["hittype"] != "hittype_entity")
	{
		var_06["position"] = var_02;
	}

	return var_06;
}

//Function Number: 9
func_7E0D()
{
	var_00 = [];
	foreach(var_02 in level.var_C928)
	{
		if(!isplayer(var_02))
		{
			var_00 = scripts\common\utility::array_add(var_00,var_02);
		}
	}

	return var_00;
}