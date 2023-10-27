/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: destructible_scripts/vehicle_civ_domestic_sedan_01_glass.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 1:58:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\_destructible::destructible_create("vehicle_civ_domestic_sedan_01_glass","tag_origin",0);
	common_scripts\_destructible::destructible_part("window1",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window1","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window2",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window2","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window3",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window3","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window4",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window4","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window5",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window5","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window6",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window6","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window7",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window7","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
	common_scripts\_destructible::destructible_part("window8",undefined,50,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("window8","vfx/glass/car_window_shatter_01");
	common_scripts\_destructible::destructible_state();
}