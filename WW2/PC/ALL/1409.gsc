/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1409.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:04 AM
*******************************************************************/

//Function Number: 1
func_17FD()
{
	lib_054D::func_7BC6(::func_29A5);
	common_scripts\utility::func_92C("tesla blood shock","vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
	common_scripts\utility::func_92C("tesla_blood_explosion","vfx/explosion/zmb_tesla_blood_explosion");
	common_scripts\utility::func_92C("tesla_blood_ambience","vfx/zombie/tesla_guns/zmb_npc_tesla_tube_blood_idle");
}

//Function Number: 2
func_29A5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = self;
	if(!lib_0547::func_5565(param_05,"teslagun_zm_blood"))
	{
		return;
	}

	if(lib_0547::func_5565(param_04,"MOD_MELEE"))
	{
		return;
	}

	if(param_02 == lib_0580::func_4382())
	{
		return;
	}

	lib_0580::func_98FD(param_00,param_01,var_0B,"j_head",param_04,param_05,::func_7788,"tesla blood shock");
}

//Function Number: 3
func_3B9D(param_00)
{
	var_01 = self;
	playfx(common_scripts\utility::func_44F5("tesla_blood_explosion"),var_01.var_116 + (0,0,24));
	var_02 = maps/mp/gametypes/zombies::func_1E59() * 2;
	lib_0580::func_98E9(var_01.var_116,func_4184(),param_00.var_721C,undefined,"teslagun_zm_blood",(0.5803922,0.1921569,0.3372549),var_02);
	var_01 lib_0378::func_8D74("aud_ww_blood_explode");
}

//Function Number: 4
func_7788(param_00,param_01)
{
	var_02 = self;
	if(isdefined(var_02.var_A4B))
	{
		var_03 = lib_0547::func_A51(var_02.var_A4B);
		if(isdefined(var_03) && common_scripts\utility::func_562E(var_03.shockbyteslablood))
		{
			var_04 = lib_0580::func_8317(param_00,param_01.var_721C,::func_3B9D);
			var_02 thread lib_0547::func_7D1A("tesla_shock",[var_04],4);
			return;
		}
	}

	var_03 thread lib_0580::func_98EE(param_01,var_02.var_721C,"MOD_ENERGY","teslagun_zm_blood",1);
}

//Function Number: 5
func_4184()
{
	return 210;
}