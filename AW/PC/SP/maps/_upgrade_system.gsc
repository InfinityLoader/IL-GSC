/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_upgrade_system.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 2:01:17 AM
*******************************************************************/

//Function Number: 1
init()
{
	maps\_upgrade_challenge::init();
	maps\_upgrade_perks::init();
}

//Function Number: 2
upgrade_is_purchased(param_00)
{
	var_01 = self getlocalplayerprofiledata("sp_upgradePurchased",param_00) == "1";
	return var_01;
}