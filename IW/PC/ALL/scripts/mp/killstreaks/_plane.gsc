/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_plane.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 967 ms
 * Timestamp: 10/27/2023 12:29:19 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_CC46))
	{
		level.var_CC46 = [];
	}

	if(!isdefined(level.var_CC43))
	{
		level.var_CC43 = [];
	}

	level.var_6BE0 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_7545 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_7546 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_7547 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_7548 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

//Function Number: 2
func_7EBE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 + param_01 * -1 * param_02;
	var_09 = param_00 + param_01 * param_02;
	if(param_03)
	{
		var_08 = var_08 * (1,1,0);
		var_09 = var_09 * (1,1,0);
	}

	var_08 = var_08 + (0,0,param_04);
	var_09 = var_09 + (0,0,param_04);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / param_05;
	var_0A = abs(0.5 * var_0A + param_06);
	var_0C = var_0A / param_05;
	var_0D["startPoint"] = var_08;
	var_0D["endPoint"] = var_09;
	var_0D["attackTime"] = var_0C;
	var_0D["flyTime"] = var_0B;
	return var_0D;
}

//Function Number: 3
func_5857(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = func_CC47(param_00,param_01,param_03,param_07,param_08);
	var_09 endon("death");
	var_0A = 150;
	var_0B = param_04 + (randomfloat(2) - 1 * var_0A,randomfloat(2) - 1 * var_0A,0);
	var_09 func_CC45(var_0B,param_06,param_05,param_08);
	var_09 func_CC42();
}

//Function Number: 4
func_CC47(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_05 = 100;
	var_06 = param_02 + (randomfloat(2) - 1 * var_05,randomfloat(2) - 1 * var_05,0);
	var_07 = level.var_CC43[param_04];
	var_08 = undefined;
	var_08 = spawn("script_model",var_06);
	var_08.team = param_01.team;
	var_08.origin = var_06;
	var_08.angles = vectortoangles(param_03);
	var_08.var_AC68 = param_00;
	var_08.var_110EA = param_04;
	var_08.var_222 = param_01;
	var_08 setmodel(var_07.var_B923[param_01.team]);
	if(isdefined(var_07.var_4464))
	{
		var_08 func_F7BF(var_07.var_4464,var_07.var_4463);
	}

	var_08 thread func_898C();
	var_08 thread func_898E();
	func_10E02(var_08);
	if(!isdefined(var_07.var_C06E))
	{
		var_08 thread func_D4FA();
	}

	var_08 playloopsound(var_07.var_93B9);
	var_08 func_49DF(param_04);
	return var_08;
}

//Function Number: 5
func_CC45(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_CC43[param_03];
	self moveto(param_00,param_01,0,0);
	if(isdefined(var_04.var_C4C6))
	{
		self thread [[ var_04.var_C4C6 ]](param_00,param_01,param_02,self.var_222,param_03);
	}

	if(isdefined(var_04.var_10407))
	{
		thread func_D520(var_04.var_10407,0.5 * param_01);
	}

	wait(0.65 * param_01);
	if(isdefined(var_04.var_C750))
	{
		self stoploopsound();
		self playloopsound(var_04.var_C750);
	}

	if(isdefined(var_04.var_C74F))
	{
		self scriptmodelplayanimdeltamotion(var_04.var_C74F);
	}

	wait(0.35 * param_01);
}

//Function Number: 6
func_CC42()
{
	var_00 = level.var_CC43[self.var_110EA];
	if(isdefined(var_00.var_C52E))
	{
		thread [[ var_00.var_C52E ]](self.var_222,self,self.var_110EA);
	}

	if(isdefined(self.var_7424))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_7424);
		scripts\mp\objidpoolmanager::returnminimapid(self.var_6576);
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	func_11098(self);
	self notify("delete");
	self delete();
}

//Function Number: 7
func_8998(param_00)
{
	self endon("death");
	for(;;)
	{
		if(param_00 scripts\mp\killstreaks\_emp_common::isemped())
		{
			self notify("death");
			return;
		}

		level waittill("emp_update");
	}
}

//Function Number: 8
func_898E()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	var_00 = anglestoforward(self.angles) * 200;
	playfx(level.var_6BE0,self.origin,var_00);
	thread func_CC42();
}

//Function Number: 9
func_898C()
{
	self endon("end_remote");
	scripts\mp\_damage::func_B9C6(800,"helicopter",::func_898F,::func_B938,1);
}

//Function Number: 10
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 11
func_898F(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_CC43[self.var_110EA];
	scripts\mp\_damage::func_C548(self.var_110EA,param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_52DA,var_04.var_3774);
	scripts\mp\_missions::func_3DE3(param_00,self,param_01);
}

//Function Number: 12
func_D4FA()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_left_wingtip");
	wait(0.5);
	playfxontag(level.var_7548,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.var_7547,self,"tag_left_wingtip");
}

//Function Number: 13
func_806A()
{
	var_00 = getent("airstrikeheight","targetname");
	if(isdefined(var_00))
	{
		return var_00.origin[2];
	}

	var_01 = 950;
	if(isdefined(level.var_1AF8))
	{
		var_01 = var_01 * level.var_1AF8;
	}

	return var_01;
}

//Function Number: 14
func_8069(param_00)
{
	var_01 = spawnstruct();
	var_01.height = func_806A();
	var_02 = getent("airstrikeheight","targetname");
	if(isdefined(var_02) && isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "fixedposition")
	{
		var_01.var_1157A = var_02.origin;
		var_01.var_6F25 = anglestoforward(var_02.angles);
		if(randomint(2) == 0)
		{
			var_01.var_6F25 = var_01.var_6F25 * -1;
		}
	}
	else
	{
		var_03 = anglestoforward(self.angles);
		var_04 = anglestoright(self.angles);
		var_01.var_1157A = self.origin + param_00 * var_03;
		var_01.var_6F25 = -1 * var_04;
	}

	return var_01;
}

//Function Number: 15
func_7EA5(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 16
func_10E02(param_00)
{
	var_01 = param_00 getentitynumber();
	level.var_CC46[var_01] = param_00;
}

//Function Number: 17
func_11098(param_00)
{
	var_01 = param_00 getentitynumber();
	level.var_CC46[var_01] = undefined;
}

//Function Number: 18
func_F1AA(param_00,param_01,param_02)
{
	var_03 = level.var_B339 / 6.46875;
	if(level.splitscreen)
	{
		var_03 = var_03 * 1.5;
	}

	var_04 = level.var_CC43[param_01];
	if(isdefined(var_04.var_F1CA))
	{
		self playlocalsound(game["voice"][self.team] + var_04.var_F1CA);
	}

	scripts\mp\_utility::func_1197(param_01,"map_artillery_selector",var_04.var_3ED0,var_03);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_05,var_06);
	if(!var_04.var_3ED0)
	{
		var_06 = randomint(360);
	}

	self setblurforplayer(0,0.3);
	if(isdefined(var_04.var_93BA))
	{
		self playlocalsound(game["voice"][self.team] + var_04.var_93BA);
	}

	self thread [[ param_02 ]](param_00,var_05,var_06,param_01);
	return 1;
}

//Function Number: 19
func_F7BF(param_00,param_01)
{
	var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_02 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",(0,0,0),param_00);
		scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_02,self);
	}

	self.var_7424 = var_02;
	var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_03 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_03,"active",(0,0,0),param_01);
		scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03,self);
	}

	self.var_6576 = var_03;
	if(level.teambased)
	{
		if(var_02 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(var_02,self.team);
		}

		if(var_03 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(var_03,scripts\mp\_utility::getotherteam(self.team));
			return;
		}

		return;
	}

	var_04 = self.var_222 getentitynumber();
	if(var_02 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_02,var_04);
	}

	if(var_03 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_03,var_04);
	}
}

//Function Number: 20
func_D520(param_00,param_01)
{
	self endon("death");
	wait(param_01);
	self playsoundonmovingent(param_00);
}

//Function Number: 21
func_49DF(param_00)
{
	var_01 = level.var_CC43[param_00];
	if(isdefined(var_01.var_A640))
	{
		var_02 = anglestoforward(self.angles);
		var_03 = spawn("script_model",self.origin + (0,0,100) - var_02 * 200);
		var_03.var_10DFF = gettime();
		var_03 setscriptmoverkillcam("airstrike");
		var_03 linkto(self,"tag_origin",var_01.var_A640,(0,0,0));
		self.var_A63A = var_03;
	}
}