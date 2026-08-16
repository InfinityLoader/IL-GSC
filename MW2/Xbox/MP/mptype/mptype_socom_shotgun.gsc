/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mptype\mptype_socom_shotgun.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	switch(codescripts\character::get_random_character(5))
	{
		case 0:
			character\mp_character_seal_socom_assault_a::main();
			break;

		case 1:
			character\mp_character_seal_socom_assault_b::main();
			break;

		case 2:
			character\mp_character_seal_socom_assault_c::main();
			break;

		case 3:
			character\mp_character_seal_socom_assault_c_blk::main();
			break;

		case 4:
			character\mp_character_seal_socom_assault_d::main();
			break;
	}
}

precache()
{
	character\mp_character_seal_socom_assault_a::precache();
	character\mp_character_seal_socom_assault_b::precache();
	character\mp_character_seal_socom_assault_c::precache();
	character\mp_character_seal_socom_assault_c_blk::precache();
	character\mp_character_seal_socom_assault_d::precache();
}