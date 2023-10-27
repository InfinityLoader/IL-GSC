/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_cagedchickens.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:45:41 AM
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
	var_00 = maps\_utility::spawn_anim_model("chicken");
	thread maps\_anim::anim_single_solo(var_00,"cage_freakout");
	var_01 = var_00 maps\_utility::getanim("cage_freakout");
	var_02 = randomfloatrange(0,1);
	var_00 setanimtime(var_01,var_02);
	for(;;)
	{
		var_00 playsound("animal_chicken_idle","sounddone");
		var_00 waittill("sounddone");
	}
}