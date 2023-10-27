/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\elvira.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 99 ms
 * Timestamp: 10/26/2023 11:58:21 PM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["elvira"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\elvira\behaviors::init;
	var_00.var_1581[1] = ::lib_0A07::func_97ED;
	var_00.var_1581[2] = ::scripts\aitypes\elvira\behaviors::updateeveryframe;
	var_00.var_1581[3] = ::lib_0C2B::func_3E48;
	var_00.var_1581[4] = ::scripts\aitypes\elvira\behaviors::decideaction;
	var_00.var_1581[5] = ::scripts\aitypes\dlc3\bt_action_api::doaction_tick;
	var_00.var_1581[6] = ::scripts\aitypes\dlc3\bt_action_api::doaction_begin;
	var_00.var_1581[7] = ::scripts\aitypes\dlc3\bt_action_api::doaction_end;
	level.var_119E["elvira"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("elvira");
}