/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_abilities.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 114 ms
 * Timestamp: 10/27/2023 1:33:26 AM
*******************************************************************/

//Function Number: 1
func_3CFE(param_00,param_01)
{
	param_01 = common_scripts\utility::func_803F(isdefined(param_01),param_01,1);
	foreach(var_03 in param_00)
	{
		if(param_01)
		{
			var_03 = maps\mp\perks\_perks::func_8817(var_03);
		}

		maps\mp\_utility::func_3CFB(var_03,0);
	}
}

//Function Number: 2
func_3D0E(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_lightweight_3";
			break;

		case 2:
			var_01[var_01.size] = "specialty_lightweight_3";
			var_01[var_01.size] = "specialty_fastreload";
			break;

		case 3:
			var_01[var_01.size] = "specialty_lightweight_4";
			var_01[var_01.size] = "specialty_marathon";
			var_01[var_01.size] = "specialty_fastreload";
			break;

		case 4:
			var_01[var_01.size] = "specialty_lightweight_7";
			var_01[var_01.size] = "specialty_marathon";
			var_01[var_01.size] = "specialty_fastreload";
			break;

		case 5:
			var_01[var_01.size] = "specialty_lightweight_7";
			var_01[var_01.size] = "specialty_marathon";
			var_01[var_01.size] = "specialty_stalker";
			var_01[var_01.size] = "specialty_fastreload";
			break;
	}

	self.pers["loadoutPerks"] = var_01;
	func_3CFE(var_01);
}

//Function Number: 3
func_3CED(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_bulletaccuracy_10";
			break;

		case 2:
			var_01[var_01.size] = "specialty_bulletaccuracy_10";
			var_01[var_01.size] = "specialty_reducedsway";
			break;

		case 3:
			var_01[var_01.size] = "specialty_bulletaccuracy_10";
			var_01[var_01.size] = "specialty_reducedsway";
			var_01[var_01.size] = "specialty_quickswap";
			break;

		case 4:
			var_01[var_01.size] = "specialty_bulletaccuracy_10";
			var_01[var_01.size] = "specialty_reducedsway";
			var_01[var_01.size] = "specialty_quickswap";
			var_01[var_01.size] = "specialty_marksman_10";
			break;

		case 5:
			var_01[var_01.size] = "specialty_bulletaccuracy_10";
			var_01[var_01.size] = "specialty_reducedsway";
			var_01[var_01.size] = "specialty_quickswap";
			var_01[var_01.size] = "specialty_marksman_10";
			var_01[var_01.size] = "specialty_quickdraw";
			break;
	}

	var_02 = common_scripts\utility::array_combine(var_01,self.pers["loadoutPerks"]);
	self.pers["loadoutPerks"] = var_02;
	func_3CFE(var_01);
}

//Function Number: 4
func_3D0F(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_spygame";
			break;

		case 2:
			var_01[var_01.size] = "specialty_blindeye";
			var_01[var_01.size] = "specialty_spygame";
			break;

		case 3:
			var_01[var_01.size] = "specialty_spygame";
			var_01[var_01.size] = "specialty_blindeye";
			var_01[var_01.size] = "specialty_coldblooded";
			break;

		case 4:
			var_01[var_01.size] = "specialty_spygame";
			var_01[var_01.size] = "specialty_quieter";
			var_01[var_01.size] = "specialty_blindeye";
			var_01[var_01.size] = "specialty_coldblooded";
			var_01[var_01.size] = "specialty_heartbreaker";
			break;

		case 5:
			var_01[var_01.size] = "specialty_spygame";
			var_01[var_01.size] = "specialty_quieter";
			var_01[var_01.size] = "specialty_blindeye";
			var_01[var_01.size] = "specialty_coldblooded";
			var_01[var_01.size] = "specialty_heartbreaker";
			var_01[var_01.size] = "specialty_quieter";
			break;
	}

	var_02 = common_scripts\utility::array_combine(var_01,self.pers["loadoutPerks"]);
	self.pers["loadoutPerks"] = var_02;
	func_3CFE(var_01);
}

//Function Number: 5
func_3CDE(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_paint";
			var_01[var_01.size] = "specialty_paint_pro";
			break;

		case 2:
			var_01[var_01.size] = "specialty_paint";
			var_01[var_01.size] = "specialty_paint_pro";
			var_01[var_01.size] = "specialty_scavenger";
			break;

		case 3:
			var_01[var_01.size] = "specialty_paint";
			var_01[var_01.size] = "specialty_paint_pro";
			var_01[var_01.size] = "specialty_scavenger";
			var_01[var_01.size] = "specialty_detectexplosive";
			break;

		case 4:
			var_01[var_01.size] = "specialty_selectivehearing";
			var_01[var_01.size] = "specialty_paint";
			var_01[var_01.size] = "specialty_paint_pro";
			var_01[var_01.size] = "specialty_scavenger";
			var_01[var_01.size] = "specialty_detectexplosive";
			break;

		case 5:
			var_01[var_01.size] = "specialty_autospot";
			var_01[var_01.size] = "specialty_selectivehearing";
			var_01[var_01.size] = "specialty_paint";
			var_01[var_01.size] = "specialty_paint_pro";
			var_01[var_01.size] = "specialty_scavenger";
			var_01[var_01.size] = "specialty_detectexplosive";
			break;
	}

	var_02 = common_scripts\utility::array_combine(var_01,self.pers["loadoutPerks"]);
	self.pers["loadoutPerks"] = var_02;
	func_3CFE(var_01);
}

//Function Number: 6
giveresistanceperks(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_stun_resistance_6";
			break;

		case 2:
			var_01[var_01.size] = "specialty_stun_resistance_6";
			var_01[var_01.size] = "_specialty_blastshield";
			self.blastshieldmod = 0.65;
			break;

		case 3:
			var_01[var_01.size] = "specialty_stun_resistance_6";
			var_01[var_01.size] = "_specialty_blastshield";
			var_01[var_01.size] = "specialty_delaymine";
			self.blastshieldmod = 0.65;
			break;

		case 4:
			var_01[var_01.size] = "specialty_stun_resistance_6";
			var_01[var_01.size] = "_specialty_blastshield";
			var_01[var_01.size] = "specialty_delaymine";
			var_01[var_01.size] = "specialty_sharp_focus";
			self.blastshieldmod = 0.65;
			break;

		case 5:
			var_01[var_01.size] = "specialty_stun_resistance_10";
			var_01[var_01.size] = "_specialty_blastshield";
			var_01[var_01.size] = "specialty_delaymine";
			var_01[var_01.size] = "specialty_sharp_focus";
			self.blastshieldmod = 0.85;
			break;
	}

	var_02 = common_scripts\utility::array_combine(var_01,self.pers["loadoutPerks"]);
	self.pers["loadoutPerks"] = var_02;
	func_3CFE(var_01);
}

//Function Number: 7
func_3CE9(param_00)
{
	var_01 = [];
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			var_01[var_01.size] = "specialty_extraammo";
			break;

		case 2:
			var_01[var_01.size] = "specialty_extraammo";
			var_01[var_01.size] = "specialty_extra_equipment";
			break;

		case 3:
			var_01[var_01.size] = "specialty_extraammo";
			var_01[var_01.size] = "specialty_extra_equipment";
			var_01[var_01.size] = "specialty_fastsprintrecovery";
			break;

		case 4:
			var_01[var_01.size] = "specialty_extraammo";
			var_01[var_01.size] = "specialty_extra_equipment";
			var_01[var_01.size] = "specialty_extra_deadly";
			var_01[var_01.size] = "specialty_fastsprintrecovery";
			break;

		case 5:
			var_01[var_01.size] = "specialty_extraammo";
			var_01[var_01.size] = "specialty_extra_equipment";
			var_01[var_01.size] = "specialty_extra_deadly";
			var_01[var_01.size] = "specialty_fastsprintrecovery";
			var_01[var_01.size] = "specialty_hardline";
			break;
	}

	var_02 = common_scripts\utility::array_combine(var_01,self.pers["loadoutPerks"]);
	self.pers["loadoutPerks"] = var_02;
	func_3CFE(var_01);
}