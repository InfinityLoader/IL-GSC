/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_delta_multicam_assault.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:28:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	switch(codescripts\character::get_random_character(4))
	{
		case 0:
			character\mp_character_delta_elite_assault_aa::main();
			break;

		case 1:
			character\mp_character_delta_elite_assault_ab::main();
			break;

		case 2:
			character\mp_character_delta_elite_assault_ba::main();
			break;

		case 3:
			character\mp_character_delta_elite_assault_bb::main();
			break;
	}
}

//Function Number: 2
precache()
{
	character\mp_character_delta_elite_assault_aa::precache();
	character\mp_character_delta_elite_assault_ab::precache();
	character\mp_character_delta_elite_assault_ba::precache();
	character\mp_character_delta_elite_assault_bb::precache();
}