/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: wall_firebox_destp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 19 ms
 * Timestamp: 4/22/2024 2:03:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\_destructible::destructible_create("wall_firebox_destp","tag_origin",50);
	common_scripts\_destructible::destructible_fx(undefined,"vfx/destructible/wall_firebox_init_xplod",1);
	common_scripts\_destructible::destructible_state("tag_origin","destp_invisible_poly_01");
}