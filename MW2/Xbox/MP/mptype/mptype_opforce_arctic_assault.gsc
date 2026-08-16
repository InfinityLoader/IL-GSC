/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_arctic_assault.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\mp_character_opforce_arctic_assault_a::main();
			break;

		case 1:
			character\mp_character_opforce_arctic_assault_b::main();
			break;

		case 2:
			character\mp_character_opforce_arctic_assault_c::main();
			break;
	}
}

precache()
{
	character\mp_character_opforce_arctic_assault_a::precache();
	character\mp_character_opforce_arctic_assault_b::precache();
	character\mp_character_opforce_arctic_assault_c::precache();
}