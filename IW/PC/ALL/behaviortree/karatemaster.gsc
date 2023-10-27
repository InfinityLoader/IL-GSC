/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\karatemaster.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 99 ms
 * Timestamp: 10/26/2023 11:58:22 PM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["karatemaster"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\karatemaster\behaviors::init;
	var_00.var_1581[1] = ::scripts\aitypes\karatemaster\behaviors::updateeveryframe;
	var_00.var_1581[2] = ::lib_0C2B::func_3E48;
	var_00.var_1581[3] = ::scripts\aitypes\karatemaster\behaviors::func_10039;
	var_00.var_1581[4] = ::scripts\aitypes\karatemaster\behaviors::func_5902;
	var_00.var_1581[5] = ::scripts\aitypes\karatemaster\behaviors::func_B599;
	var_00.var_1581[6] = ::scripts\aitypes\karatemaster\behaviors::melee_cleanup;
	var_00.var_1581[7] = ::scripts\aitypes\karatemaster\behaviors::shouldteleport;
	var_00.var_1581[8] = ::scripts\aitypes\karatemaster\behaviors::doteleport;
	var_00.var_1581[9] = ::scripts\aitypes\karatemaster\behaviors::teleport_init;
	var_00.var_1581[10] = ::scripts\aitypes\karatemaster\behaviors::teleport_cleanup;
	var_00.var_1581[11] = ::scripts\aitypes\karatemaster\behaviors::followenemy_tick;
	var_00.var_1581[12] = ::scripts\aitypes\karatemaster\behaviors::followenemy_begin;
	var_00.var_1581[13] = ::scripts\aitypes\karatemaster\behaviors::followenemy_end;
	var_00.var_1581[14] = ::lib_0C2B::func_C0B6;
	level.var_119E["karatemaster"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("karatemaster");
}