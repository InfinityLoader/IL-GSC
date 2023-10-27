/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_cagedchickens.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:34:17 AM
*******************************************************************/

//Function Number: 1
initchickens()
{
	waittillframeend;
	var_00 = getentarray("caged_chicken","targetname");
	common_scripts\utility::array_thread(var_00,::spawnchicken);
}

//Function Number: 2
spawnchicken()
{
	var_00 = maps\_utility::func_E4F("chicken");
	thread maps\_anim::func_E0E(var_00,"cage_freakout");
	var_01 = var_00 maps\_utility::getanim("cage_freakout");
	var_02 = randomfloatrange(0,1);
	var_00 setanimtime(var_01,var_02);
	for(;;)
	{
		var_00 playsound("animal_chicken_idle","sounddone");
		var_00 waittill("sounddone");
	}
}