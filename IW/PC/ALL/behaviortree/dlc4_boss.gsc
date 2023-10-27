/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\dlc4_boss.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 100 ms
 * Timestamp: 10/26/2023 11:58:21 PM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["dlc4_boss"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\dlc4_boss\behaviors::initbehaviors;
	var_00.var_1581[1] = ::scripts\aitypes\dlc4_boss\behaviors::entrance_tick;
	var_00.var_1581[2] = ::scripts\aitypes\dlc4_boss\behaviors::entrance_begin;
	var_00.var_1581[3] = ::scripts\aitypes\dlc4_boss\behaviors::entrance_end;
	var_00.var_1581[4] = ::scripts\aitypes\dlc4_boss\behaviors::updateeveryframe;
	var_00.var_1581[5] = ::lib_0C2B::func_3E48;
	var_00.var_1581[6] = ::scripts\aitypes\dlc4_boss\behaviors::decideaction;
	var_00.var_1581[7] = ::scripts\aitypes\dlc4\bt_action_api::doaction_tick;
	var_00.var_1581[8] = ::scripts\aitypes\dlc4\bt_action_api::doaction_begin;
	var_00.var_1581[9] = ::scripts\aitypes\dlc4\bt_action_api::doaction_end;
	level.var_119E["dlc4_boss"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("dlc4_boss");
}