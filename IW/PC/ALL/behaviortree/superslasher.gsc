/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\superslasher.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 135 ms
 * Timestamp: 10/26/2023 11:58:23 PM
*******************************************************************/

//Function Number: 1
superslasherfn0(param_00)
{
	return lib_0A09::func_5AEA(param_00,50);
}

//Function Number: 2
func_2AD0()
{
	if(isdefined(level.var_119E["superslasher"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::scripts\aitypes\superslasher\behaviors::superslasher_init;
	var_00.var_1581[1] = ::superslasherfn0;
	var_00.var_1581[2] = ::lib_0A09::func_FAF6;
	var_00.var_1581[3] = ::scripts\aitypes\superslasher\behaviors::func_58E1;
	var_00.var_1581[4] = ::scripts\aitypes\superslasher\behaviors::walktoroof;
	var_00.var_1581[5] = ::scripts\aitypes\superslasher\behaviors::walktoroof_init;
	var_00.var_1581[6] = ::scripts\aitypes\superslasher\behaviors::walktoroof_cleanup;
	var_00.var_1581[7] = ::scripts\aitypes\superslasher\behaviors::jumptoroof;
	var_00.var_1581[8] = ::scripts\aitypes\superslasher\behaviors::jumptoroof_init;
	var_00.var_1581[9] = ::scripts\aitypes\superslasher\behaviors::jumptoroof_cleanup;
	var_00.var_1581[10] = ::scripts\aitypes\superslasher\behaviors::func_5ABE;
	var_00.var_1581[11] = ::scripts\aitypes\superslasher\behaviors::taunt_init;
	var_00.var_1581[12] = ::scripts\aitypes\superslasher\behaviors::taunt_cleanup;
	var_00.var_1581[13] = ::scripts\aitypes\superslasher\behaviors::updateeveryframe;
	var_00.var_1581[14] = ::scripts\aitypes\superslasher\behaviors::dotrapped;
	var_00.var_1581[15] = ::scripts\aitypes\superslasher\behaviors::shouldgotoroof;
	var_00.var_1581[16] = ::scripts\aitypes\superslasher\behaviors::dostagger;
	var_00.var_1581[17] = ::scripts\aitypes\superslasher\behaviors::stagger_init;
	var_00.var_1581[18] = ::scripts\aitypes\superslasher\behaviors::stagger_cleanup;
	var_00.var_1581[19] = ::scripts\aitypes\superslasher\behaviors::shoulddowires;
	var_00.var_1581[20] = ::scripts\aitypes\superslasher\behaviors::dowires;
	var_00.var_1581[21] = ::scripts\aitypes\superslasher\behaviors::wires_init;
	var_00.var_1581[22] = ::scripts\aitypes\superslasher\behaviors::wires_cleanup;
	var_00.var_1581[23] = ::scripts\aitypes\superslasher\behaviors::shouldgotoground;
	var_00.var_1581[24] = ::scripts\aitypes\superslasher\behaviors::gotoground;
	var_00.var_1581[25] = ::scripts\aitypes\superslasher\behaviors::gotoground_init;
	var_00.var_1581[26] = ::scripts\aitypes\superslasher\behaviors::gotoground_cleanup;
	var_00.var_1581[27] = ::scripts\aitypes\superslasher\behaviors::shouldshockwave;
	var_00.var_1581[28] = ::scripts\aitypes\superslasher\behaviors::wires_stop;
	var_00.var_1581[29] = ::scripts\aitypes\superslasher\behaviors::doshockwave;
	var_00.var_1581[30] = ::scripts\aitypes\superslasher\behaviors::shockwave_init;
	var_00.var_1581[31] = ::scripts\aitypes\superslasher\behaviors::shockwave_cleanup;
	var_00.var_1581[32] = ::scripts\aitypes\superslasher\behaviors::dotauntcontinuously;
	var_00.var_1581[33] = ::lib_0A09::func_E477;
	var_00.var_1581[34] = ::scripts\aitypes\superslasher\behaviors::shouldthrowsaw;
	var_00.var_1581[35] = ::scripts\aitypes\superslasher\behaviors::dothrowsaw;
	var_00.var_1581[36] = ::scripts\aitypes\superslasher\behaviors::throwsaw_init;
	var_00.var_1581[37] = ::scripts\aitypes\superslasher\behaviors::throwsaw_cleanup;
	var_00.var_1581[38] = ::scripts\aitypes\superslasher\behaviors::shouldgroundpound;
	var_00.var_1581[39] = ::scripts\aitypes\superslasher\behaviors::dogroundpound;
	var_00.var_1581[40] = ::scripts\aitypes\superslasher\behaviors::groundpound_init;
	var_00.var_1581[41] = ::scripts\aitypes\superslasher\behaviors::groundpound_cleanup;
	var_00.var_1581[42] = ::scripts\aitypes\superslasher\behaviors::shouldjumpmove;
	var_00.var_1581[43] = ::scripts\aitypes\superslasher\behaviors::dojumpmove;
	var_00.var_1581[44] = ::scripts\aitypes\superslasher\behaviors::jumpmove_init;
	var_00.var_1581[45] = ::scripts\aitypes\superslasher\behaviors::jumpmove_cleanup;
	var_00.var_1581[46] = ::scripts\aitypes\superslasher\behaviors::func_10039;
	var_00.var_1581[47] = ::scripts\aitypes\superslasher\behaviors::melee_charge;
	var_00.var_1581[48] = ::scripts\aitypes\superslasher\behaviors::melee_charge_init;
	var_00.var_1581[49] = ::scripts\aitypes\superslasher\behaviors::melee_charge_cleanup;
	var_00.var_1581[50] = ::scripts\aitypes\superslasher\behaviors::func_5902;
	var_00.var_1581[51] = ::scripts\aitypes\superslasher\behaviors::func_B599;
	var_00.var_1581[52] = ::scripts\aitypes\superslasher\behaviors::melee_cleanup;
	var_00.var_1581[53] = ::scripts\aitypes\superslasher\behaviors::shoulddosharks;
	var_00.var_1581[54] = ::scripts\aitypes\superslasher\behaviors::dosharks;
	var_00.var_1581[55] = ::scripts\aitypes\superslasher\behaviors::sharks_init;
	var_00.var_1581[56] = ::scripts\aitypes\superslasher\behaviors::sharks_cleanup;
	var_00.var_1581[57] = ::scripts\aitypes\superslasher\behaviors::shouldstomp;
	var_00.var_1581[58] = ::scripts\aitypes\superslasher\behaviors::dostomp;
	var_00.var_1581[59] = ::scripts\aitypes\superslasher\behaviors::stomp_init;
	var_00.var_1581[60] = ::scripts\aitypes\superslasher\behaviors::stomp_cleanup;
	var_00.var_1581[61] = ::scripts\aitypes\superslasher\behaviors::shouldthrowsawfan;
	var_00.var_1581[62] = ::scripts\aitypes\superslasher\behaviors::dothrowsawfan;
	var_00.var_1581[63] = ::scripts\aitypes\superslasher\behaviors::throwsawfan_init;
	var_00.var_1581[64] = ::scripts\aitypes\superslasher\behaviors::throwsawfan_cleanup;
	var_00.var_1581[65] = ::scripts\aitypes\superslasher\behaviors::func_BBF7;
	var_00.var_1581[66] = ::scripts\aitypes\superslasher\behaviors::move_init;
	var_00.var_1581[67] = ::scripts\aitypes\superslasher\behaviors::move_cleanup;
	level.var_119E["superslasher"] = var_00;
}

//Function Number: 3
func_DEE8()
{
	func_2AD0();
	function_02D8("superslasher");
}