/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playercards.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 36 ms
 * Timestamp: 10/27/2023 2:25:43 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_01 = var_00 maps\mp\gametypes\_persistence::func_2B58("cardIcon");
		var_02 = tablelookupbyrow("mp/cardIconTable.csv",var_01,0);
		var_00 setcardicon(var_02);
		var_03 = var_00 maps\mp\gametypes\_persistence::func_2B58("cardTitle");
		var_04 = tablelookupbyrow("mp/cardTitleTable.csv",var_03,0);
		var_00 setcardtitle(var_04);
		var_05 = var_00 maps\mp\gametypes\_persistence::func_2B58("cardNameplate");
		var_00 setcardnameplate(var_05);
	}
}