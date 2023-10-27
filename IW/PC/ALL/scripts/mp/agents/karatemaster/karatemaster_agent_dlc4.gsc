/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\karatemaster\karatemaster_agent_dlc4.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 140 ms
 * Timestamp: 10/27/2023 12:11:17 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\karatemaster::func_DEE8();
	scripts\asm\karatemaster_dlc4\mp\states::func_2371();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	scripts\mp\agents\karatemaster\karatemaster_agent::func_FAB0();
}