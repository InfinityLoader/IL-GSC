/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2867.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:21 AM
*******************************************************************/

//Function Number: 1
func_95F3()
{
	scripts\common\utility::func_16DC("setsaveddvar",::function_01C5);
	scripts\common\utility::func_16DC("useanimtree",::method_83D0);
	scripts\common\utility::func_16DC("setanim",::method_82A2);
	scripts\common\utility::func_16DC("setanimknob",::method_82A4);
	scripts\common\utility::func_16DC("setflaggedanimknob",::method_82E2);
	scripts\common\utility::func_16DC("setflaggedanimknobrestart",::method_82E7);
	scripts\common\utility::func_16DC("setanimlimited",::method_82AC);
	scripts\common\utility::func_16DC("setanimtime",::method_82B0);
	scripts\common\utility::func_16DC("getanimtime",::method_8102);
	scripts\common\utility::func_16DC("getanimlength",::getanimlength);
	scripts\common\utility::func_16DC("clearanim",::method_806F);
	scripts\common\utility::func_16DC("kill",::method_81D0);
	scripts\common\utility::func_16DC("magicgrenade",::function_0135);
	scripts\common\utility::func_16DC("connectPaths",::connectpaths);
	scripts\common\utility::func_16DC("disconnectPaths",::disconnectpaths);
	scripts\common\utility::func_16DC("makeEntitySentient",::method_81F1);
	scripts\common\utility::func_16DC("laserForceOn",::method_81D6);
	scripts\common\utility::func_16DC("laserForceOff",::method_81D5);
	scripts\common\utility::func_16DC("badPlaceDelete",::badplace_delete);
	scripts\common\utility::func_16DC("badPlaceCylinder",::badplace_cylinder);
	scripts\common\utility::func_16DC("freeEntitySentient",::method_80F7);
	scripts\common\utility::func_16DC("stat_track_kill_func",::method_81D5);
	scripts\common\utility::func_16DC("laserForceOff",::method_81D5);
	scripts\common\utility::func_16DC("getspawner",::getspawner);
	level.var_5A5E = 1;
	level.var_2681 = 1;
	level.var_7FF9 = ::function_00B3;
	level.var_7FF3 = ::function_00B4;
	level.var_179C = ::method_8000;
	level.var_8134 = ::function_00C8;
}