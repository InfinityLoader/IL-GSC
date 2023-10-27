/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3562.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:43 AM
*******************************************************************/

//Function Number: 1
func_8841()
{
	self.var_907C = undefined;
}

//Function Number: 2
func_1181C(param_00,param_01)
{
	param_01.var_1E8E = param_00.angles;
}

//Function Number: 3
func_1181B(param_00,param_01,param_02)
{
	if(isdefined(param_02) && isdefined(param_01))
	{
		if(isplayer(param_01) && param_01 != param_02)
		{
			if(!level.teambased || param_02.team != param_01.team)
			{
				param_02 func_E7FC(param_00,param_01,param_02);
			}
		}
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 4
func_8840(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 playlocalsound("bs_shield_explo");
	}

	param_01 playsoundtoteam("bs_shield_explo_npc","axis",param_00);
	param_01 playsoundtoteam("bs_shield_explo_npc","allies",param_00);
	playfx(scripts\common\utility::getfx("hackKnife_impactWorld"),param_01.origin,anglestoforward(param_01.angles),anglestoup(param_01.angles));
}

//Function Number: 5
func_E7FC(param_00,param_01,param_02)
{
	if(isdefined(param_02.var_907C))
	{
		func_8842(param_02.var_907C);
	}

	var_03 = func_53C9(param_01);
	self.var_907C = [];
	if(isdefined(var_03))
	{
		for(var_04 = 0;var_04 < 1;var_04++)
		{
			param_02.var_907C[var_04] = func_8843(var_03[var_04],param_00.var_1E8E);
			param_02.var_907C[var_04] func_883F(param_01);
		}
	}

	self playlocalsound("ghost_prism_activate");
	self waittill("death");
	thread func_8842(param_02.var_907C);
}

//Function Number: 6
func_53C9(param_00)
{
	var_01 = getclosestpointonnavmesh(param_00.origin + anglestoforward(param_00.angles) * 64);
	var_02 = [];
	var_02 = getnodesinradius(var_01,128,64,64);
	return var_02;
}

//Function Number: 7
func_8842(param_00)
{
	if(isdefined(param_00))
	{
		foreach(var_02 in param_00)
		{
			playsoundatpos(var_02.origin,"ghost_prism_deactivate");
			var_02 notify("death");
			var_02 suicide();
		}
	}
}

//Function Number: 8
func_8843(param_00,param_01)
{
	if(lib_0D65::func_8008("squadmate") >= 5)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	if(lib_0D65::func_8010(self) >= 2)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = lib_0D65::func_81FB(1,1);
	}

	var_02 = scripts\mp\agents\_agents::func_16F2("squadmate",self.team,"reconAgent",param_00.origin,param_01,self,0,0,"hardened");
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_02.var_A6BB = "agent";
	return var_02;
}

//Function Number: 9
func_883F(param_00)
{
	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98,"");
		self.var_8C98 = undefined;
	}

	self setmodel(param_00.model);
	self method_83B7();
	self giveweapon(param_00.var_D8E1);
	if(param_00.var_F0C4 != "none")
	{
		self giveweapon(param_00.var_F0C4);
	}

	scripts\mp\_utility::_switchtoweapon(param_00.var_D8E1);
	self botsetflag("disable_attack",0);
	self.health = 50;
	thread func_1903();
	var_01 = param_00.origin + anglestoforward(param_00.angles) * 64 * 5;
	var_02 = scripts\common\trace::func_DCED(param_00.origin,var_01,level.players);
	if(!isdefined(var_02))
	{
		var_02["position"] = var_01;
	}
	else
	{
		var_02 = var_02["position"];
	}

	var_03 = getclosestpointonnavmesh(var_02);
	var_03 = getclosestnodeinsight(var_03);
	self botsetscriptgoalnode(var_03,"objective");
}

//Function Number: 10
func_1903()
{
	self waittill("death");
	var_00 = self.origin;
	var_01 = self method_8113();
	var_01 hide();
}

//Function Number: 11
func_68D5()
{
	self endon("death");
	for(;;)
	{
		wait(0.75);
		playfxontag(level.var_CAA3["shimmer"],self,"j_spineupper");
	}
}

//Function Number: 12
func_13BAD(param_00)
{
	self endon("death");
	for(;;)
	{
		if(param_00 method_81B5())
		{
			wait(0.1);
			continue;
		}

		var_01 = param_00 getcurrentweapon();
		self giveweapon(var_01);
		scripts\mp\_utility::_switchtoweapon(var_01);
		param_00 waittill("weapon_change");
	}
}