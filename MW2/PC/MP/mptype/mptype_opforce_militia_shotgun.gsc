/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_militia_shotgun.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(2))
	{
		case 0:
			character\mp_character_militia_shotgun_aa_blk::main();
			break;

		case 1:
			character\mp_character_militia_shotgun_aa_wht::main();
			break;
	}
}

precache()
{
	character\mp_character_militia_shotgun_aa_blk::precache();
	character\mp_character_militia_shotgun_aa_wht::precache();
}