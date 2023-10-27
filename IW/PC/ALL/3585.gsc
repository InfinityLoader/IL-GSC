/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3585.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:48 AM
*******************************************************************/

//Function Number: 1
func_10218()
{
}

//Function Number: 2
func_1181D(param_00,param_01,param_02)
{
	if(isdefined(param_02) && isdefined(param_01))
	{
		if(isplayer(param_01) && param_01 != param_02)
		{
			if(!level.teambased || param_02.team != param_01.team)
			{
				param_02 thread func_10219(param_02);
				scripts\mp\_lightarmor::func_F786(param_02,param_02.maxhealth,0);
			}
		}
	}

	param_02 thread func_10217(param_02,param_00);
	param_00 delete();
}

//Function Number: 3
func_10219(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 thread func_1021A(param_00);
	param_00 notify("adrenaline_used");
	param_00 scripts\mp\_utility::func_8387("specialty_adrenaline");
	wait(2);
	param_00 scripts\mp\_utility::func_E150("specialty_adrenaline");
	param_00 notify("siphonKnife_regen_end");
}

//Function Number: 4
func_1021A(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("siphonKnife_regen_end");
	if(!isdefined(param_00))
	{
		return;
	}

	self playlocalsound("mp_overcharge_on");
	for(;;)
	{
		var_01 = playfx(scripts\common\utility::getfx("siphonKnife_regenWorld"),self.origin + (0,0,25),anglestoforward(self.angles),anglestoup(self.angles));
		var_01 method_8429(self);
		wait(0.1);
	}
}

//Function Number: 5
func_10217(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 playlocalsound("bs_shield_explo");
	}

	param_01 playsoundtoteam("bs_shield_explo_npc","axis",param_00);
	param_01 playsoundtoteam("bs_shield_explo_npc","allies",param_00);
	playfx(scripts\common\utility::getfx("siphonKnife_impactWorld"),param_01.origin,anglestoforward(param_01.angles),anglestoup(param_01.angles));
}