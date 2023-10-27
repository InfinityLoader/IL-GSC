/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playercards.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 2:41:54 AM
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
		if(!isai(var_00))
		{
			var_01 = 0;
			var_02 = 0;
			var_03 = 0;
			if(maps\mp\_utility::invirtuallobby())
			{
				var_04 = var_00 method_8568();
				var_01 = function_02FA(var_04,common_scripts\utility::getstatsgroup_common(),"emblemPatchIndex");
				var_03 = function_02FA(var_04,common_scripts\utility::getstatsgroup_common(),"applyEmblemToCharacter");
				var_02 = function_02FA(var_04,common_scripts\utility::getstatsgroup_common(),"callingCardIndex");
			}
			else
			{
				var_01 = var_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"emblemPatchIndex");
				var_03 = var_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"applyEmblemToCharacter");
				var_02 = var_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"callingCardIndex");
			}

			var_00.playercardpatch = var_01;
			var_00 method_8577(var_03);
			var_00.playercardbackground = var_02;
		}
	}
}