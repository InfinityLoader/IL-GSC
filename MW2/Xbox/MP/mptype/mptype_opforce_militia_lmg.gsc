/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_militia_lmg.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\mp_character_militia_lmg_aa_blk::main();
			break;

		case 1:
			character\mp_character_militia_lmg_ab_blk::main();
			break;

		case 2:
			character\mp_character_militia_lmg_ac_blk::main();
			break;
	}
}

precache()
{
	character\mp_character_militia_lmg_aa_blk::precache();
	character\mp_character_militia_lmg_ab_blk::precache();
	character\mp_character_militia_lmg_ac_blk::precache();
}