/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_aalauncher.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 338 ms
 * Timestamp: 10/27/2023 12:27:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("aa_launcher",::func_6D69,undefined,::func_5FBC,undefined,::func_11378);
	scripts\mp\_laserguidedlauncher::func_AC0B("vfx/core/mp/killstreaks/vfx_maaws_split","vfx/core/mp/killstreaks/vfx_maaws_homing");
}

//Function Number: 2
func_7D8F()
{
	return "iw6_maaws_mp";
}

//Function Number: 3
func_7D8D()
{
	return "iw6_maawschild_mp";
}

//Function Number: 4
func_7D8E()
{
	return "iw6_maawshoming_mp";
}

//Function Number: 5
func_5FBC(param_00)
{
	param_00.var_14FF = 2;
	return 1;
}

//Function Number: 6
func_6D69(param_00)
{
	param_00.var_14FF = param_00.var_14FF - 1;
	var_01 = param_00.var_14FF <= 0;
	return var_01;
}

//Function Number: 7
func_11378(param_00)
{
	self setweaponammoclip(param_00.var_394,param_00.var_14FF);
	thread func_B9B1(param_00);
}

//Function Number: 8
func_B9B1(param_00)
{
	self endon("death");
	self endon("disconnect");
	self waittill("weapon_change",var_01);
	thread scripts\mp\_laserguidedlauncher::func_AC08(func_7D8F(),func_7D8D(),func_7D8E());
	self waittill("weapon_change");
	scripts\mp\_laserguidedlauncher::func_AC07();
}