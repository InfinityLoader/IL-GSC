/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_henchmen_assault.gsc
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
			character\mp_character_opforce_hench_assault_a::main();
			break;

		case 1:
			character\mp_character_opforce_hench_assault_b::main();
			break;

		case 2:
			character\mp_character_opforce_hench_assault_c::main();
			break;

		case 3:
			character\mp_character_opforce_hench_assault_d::main();
			break;
	}
}

//Function Number: 2
precache()
{
	character\mp_character_opforce_hench_assault_a::precache();
	character\mp_character_opforce_hench_assault_b::precache();
	character\mp_character_opforce_hench_assault_c::precache();
	character\mp_character_opforce_hench_assault_d::precache();
}