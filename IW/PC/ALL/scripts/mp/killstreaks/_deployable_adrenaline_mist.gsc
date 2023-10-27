/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployable_adrenaline_mist.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 106 ms
 * Timestamp: 10/27/2023 12:28:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_92B8 = "deployable_adrenaline_mist";
	var_00.var_39B = "deployable_adrenaline_mist_marker_mp";
	var_00.var_110EA = "deployable_adrenaline_mist";
	var_00.var_85E7 = ::scripts\mp\_adrenalinemist::func_18A5;
	level.var_2F30["deployable_adrenaline_mist"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_adrenaline_mist",::func_128DD);
}

//Function Number: 2
func_128DD(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_adrenaline_mist");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_adrenaline_mist",self.origin);
	return 1;
}