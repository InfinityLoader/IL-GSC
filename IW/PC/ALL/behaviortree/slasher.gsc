/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\slasher.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 100 ms
 * Timestamp: 10/26/2023 11:58:23 PM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["slasher"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\slasher\behaviors::initslasher;
	var_00.var_1581[1] = ::scripts\aitypes\slasher\behaviors::updateslashereveryframe;
	var_00.var_1581[2] = ::lib_0C2B::func_3E48;
	var_00.var_1581[3] = ::scripts\aitypes\slasher\behaviors::decideslasheraction;
	var_00.var_1581[4] = ::scripts\aitypes\slasher\behaviors::doslasheraction_tick;
	var_00.var_1581[5] = ::scripts\aitypes\slasher\behaviors::doslasheraction_begin;
	var_00.var_1581[6] = ::scripts\aitypes\slasher\behaviors::doslasheraction_end;
	var_00.var_1581[7] = ::scripts\aitypes\slasher\behaviors::followenemy_tick;
	var_00.var_1581[8] = ::scripts\aitypes\slasher\behaviors::followenemy_begin;
	var_00.var_1581[9] = ::scripts\aitypes\slasher\behaviors::followenemy_end;
	var_00.var_1581[10] = ::scripts\aitypes\slasher\behaviors::findenemy_tick;
	var_00.var_1581[11] = ::scripts\aitypes\slasher\behaviors::findenemy_begin;
	var_00.var_1581[12] = ::scripts\aitypes\slasher\behaviors::findenemy_end;
	level.var_119E["slasher"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("slasher");
}