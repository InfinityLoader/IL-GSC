/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_opforce_airborne_shotgun.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\mp_character_airborne_shotgun::main();
			break;

		case 1:
			character\mp_character_airborne_shotgun_b::main();
			break;

		case 2:
			character\mp_character_airborne_shotgun_c::main();
			break;
	}
}

precache()
{
	character\mp_character_airborne_shotgun::precache();
	character\mp_character_airborne_shotgun_b::precache();
	character\mp_character_airborne_shotgun_c::precache();
}