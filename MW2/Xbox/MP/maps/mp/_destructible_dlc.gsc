/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_destructible_dlc.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	level.func["precacheMpAnim"] = ::precachempanim;
	level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
	common_scripts\_destructible_dlc::main();
}