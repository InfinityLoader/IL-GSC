/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _upgrade_system.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:23:35 AM
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