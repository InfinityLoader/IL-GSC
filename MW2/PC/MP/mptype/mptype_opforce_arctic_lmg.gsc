/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_arctic_lmg.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\mp_character_opforce_arctic_lmg::main();
			break;

		case 1:
			character\mp_character_opforce_arctic_lmg_b::main();
			break;

		case 2:
			character\mp_character_opforce_arctic_lmg_c::main();
			break;
	}
}

precache()
{
	character\mp_character_opforce_arctic_lmg::precache();
	character\mp_character_opforce_arctic_lmg_b::precache();
	character\mp_character_opforce_arctic_lmg_c::precache();
}