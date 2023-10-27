/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\ratking.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 109 ms
 * Timestamp: 10/26/2023 11:58:23 PM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["ratking"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\ratking\behaviors::init;
	var_00.var_1581[1] = ::scripts\aitypes\ratking\behaviors::updateeveryframe;
	var_00.var_1581[2] = ::lib_0C2B::func_3E48;
	var_00.var_1581[3] = ::scripts\aitypes\ratking\behaviors::decideaction;
	var_00.var_1581[4] = ::scripts\aitypes\ratking\behaviors::doaction_tick;
	var_00.var_1581[5] = ::scripts\aitypes\ratking\behaviors::doaction_begin;
	var_00.var_1581[6] = ::scripts\aitypes\ratking\behaviors::doaction_end;
	var_00.var_1581[7] = ::scripts\aitypes\ratking\behaviors::bt_rk_isonplatform;
	var_00.var_1581[8] = ::scripts\aitypes\ratking\behaviors::followenemy_tick;
	var_00.var_1581[9] = ::scripts\aitypes\ratking\behaviors::followenemy_begin;
	var_00.var_1581[10] = ::scripts\aitypes\ratking\behaviors::followenemy_end;
	var_00.var_1581[11] = ::lib_0C2B::func_C0B6;
	level.var_119E["ratking"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("ratking");
}