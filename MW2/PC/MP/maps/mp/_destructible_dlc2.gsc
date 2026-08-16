/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_destructible_dlc2.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	level.func["precacheMpAnim"] = ::precachempanim;
	level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
	common_scripts\_destructible_dlc2::main();
}