/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_prone.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 231 ms
 * Timestamp: 10/27/2023 2:18:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	animscripts/utility::func_D15("cover_prone");
	if(weaponclass(self.weapon) == "rocketlauncher")
	{
		animscripts/combat::main();
		return;
	}

	if(isdefined(self.a.var_10DF) && self.a.var_10DF == "prone_saw")
	{
		animscripts/cover_wall::func_FA5("saw_bipod_prone","weapon_saw_MG_Setup");
	}
	else if(isdefined(self.node.turret))
	{
		animscripts/cover_wall::func_FA7();
	}

	if(isdefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512))
	{
		thread animscripts/combat::main();
		return;
	}

	func_10E6();
	self.var_CAF = self.node;
	self orientmode("face angle",self.var_CAF.angles[1]);
	self.a.var_10E0 = 1;
	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
	if(self.a.pose != "prone")
	{
		func_10EA("prone");
	}
	else
	{
		animscripts/utility::func_10E1(0);
	}

	thread animscripts/combat_utility::aimidlethread();
	func_10EC(0.2);
	self setanim(%prone_aim_5,1,0.1);
	self orientmode("face angle",self.var_CAF.angles[1]);
	self animmode("zonly_physics");
	func_10E3();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 2
func_067F()
{
	self.a.var_10E0 = undefined;
}

//Function Number: 3
func_0F5E()
{
	self endon("killanimscript");
	self endon("kill_idle_thread");
	for(;;)
	{
		var_00 = animscripts/utility::func_CA8("prone_idle");
		self setflaggedanimlimited("idle",var_00);
		self waittillmatch("end","idle");
		self clearanim(var_00,0.2);
	}
}

//Function Number: 4
func_10E2(param_00)
{
	self updateprone(%prone_aim_feet_45up,%prone_aim_feet_45down,1,param_00,1);
	self setanim(%exposed_aiming,1,0.2);
}

//Function Number: 5
func_10E3()
{
	self endon("killanimscript");
	thread animscripts/track::func_CA9();
	thread animscripts/shoot_behavior::func_CD7("normal");
	var_00 = gettime() > 2500;
	for(;;)
	{
		animscripts/utility::func_A69();
		func_10E2(0.05);
		if(!var_00)
		{
			wait 0.05 + randomfloat(1.5);
			var_00 = 1;
			continue;
		}

		if(!isdefined(self.var_CB1))
		{
			if(func_10E7())
			{
				continue;
			}

			wait 0.05;
			continue;
		}

		var_01 = lengthsquared(self.origin - self.var_CB1);
		if(self.a.pose != "crouch" && self isstanceallowed("crouch") && var_01 < squared(400))
		{
			if(var_01 < squared(285))
			{
				func_10EA("crouch");
				thread animscripts/combat::main();
				return;
			}
		}

		if(func_10E7())
		{
			continue;
		}

		if(func_10E5(0))
		{
			continue;
		}

		if(animscripts/combat_utility::func_10E4())
		{
			animscripts/combat_utility::func_F06();
			self clearanim(%add_fire,0.2);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 6
func_10E5(param_00)
{
	return animscripts/combat_utility::func_F54(param_00,animscripts/utility::func_D4D("reload"));
}

//Function Number: 7
func_10E6()
{
	self setdefaultaimlimits(self.node);
	var_00 = [];
	self.a.array = var_7B;
}

//Function Number: 8
func_0F61(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_02 = animscripts/utility::func_CA8("grenade_safe");
	}
	else
	{
		var_02 = animscripts/utility::func_CA8("grenade_exposed");
	}

	self animmode("zonly_physics");
	self.keepclaimednodeifvalid = 1;
	var_03 = (32,20,64);
	var_04 = animscripts/combat_utility::func_FA1(param_00,var_02);
	self.keepclaimednodeifvalid = 0;
	return var_04;
}

//Function Number: 9
func_10E7()
{
	if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
	{
		if(func_0F61(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.enemy))
	{
		return func_0F61(self.enemy,850);
	}

	return 0;
}

//Function Number: 10
func_10E8()
{
	if(!isdefined(self.weapon) || !weaponisauto(self.weapon))
	{
		return 0;
	}

	if(isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 256)
	{
		return 0;
	}

	if(isdefined(self.enemy) && self cansee(self.enemy) && !isdefined(self.var_73C) && animscripts/shared::func_10E9() < 20)
	{
		return animscripts/move::func_FDE();
	}

	return 0;
}

//Function Number: 11
func_10EA(param_00)
{
	if(param_00 == self.a.pose)
	{
		return;
	}

	self clearanim(%root,0.3);
	animscripts/combat_utility::func_F85();
	if(func_10E8())
	{
		var_01 = animscripts/utility::func_D4D(self.a.pose + "_2_" + param_00 + "_firing");
	}
	else
	{
		var_01 = animscripts/utility::func_D4D(self.a.pose + "_2_" + var_01);
	}

	if(param_00 == "prone")
	{
	}

	self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
	animscripts/shared::donotetracks("trans");
	self setanimknoballrestart(animscripts/utility::func_D4D("straight_level"),%body,1,0.25);
	func_10EC(0.25);
}

//Function Number: 12
func_10EB(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 13
func_10EC(param_00)
{
	self setanimknoball(%prone_aim_5,%body,1,param_00);
	self setanimlimited(%prone_aim_2_add,1,param_00);
	self setanimlimited(%prone_aim_4_add,1,param_00);
	self setanimlimited(%prone_aim_6_add,1,param_00);
	self setanimlimited(%prone_aim_8_add,1,param_00);
}

//Function Number: 14
func_10B0(param_00,param_01)
{
	self clearanim(%root,0.3);
	var_02 = undefined;
	if(func_10E8())
	{
		if(param_00 == "crouch")
		{
			var_02 = %prone_2_crouch_firing;
		}
		else if(param_00 == "stand")
		{
			var_02 = %prone_2_stand_firing;
		}
	}
	else if(param_00 == "crouch")
	{
		var_02 = %prone_2_crouch;
	}
	else if(param_00 == "stand")
	{
		var_02 = %prone_2_stand_nodelta;
	}

	if(isdefined(self.var_10ED))
	{
		var_02 = self.var_10ED;
	}

	if(isdefined(self.var_10EE))
	{
		param_01 = self.var_10EE;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	animscripts/utility::func_F7D(getanimlength(var_02) / 2);
	self setflaggedanimknoballrestart("trans",var_02,%body,1,0.2,param_01);
	animscripts/shared::donotetracks("trans");
	self clearanim(var_02,0.1);
}