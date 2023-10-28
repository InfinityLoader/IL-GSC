/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\zclassic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:41 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/zombies/_zm_stats;

//Function Number: 1
main()
{
	maps/mp/gametypes_zm/_zm_gametype::main();
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level._game_module_custom_spawn_init_func = maps/mp/gametypes_zm/_zm_gametype::custom_spawn_init_func;
	level._game_module_stat_update_func = maps/mp/zombies/_zm_stats::survival_classic_custom_stat_update;
	maps/mp/gametypes_zm/_zm_gametype::post_gametype_main("zclassic");
}

//Function Number: 2
onprecachegametype()
{
	level.playersuicideallowed = 1;
	level.canplayersuicide = ::canplayersuicide;
	level.suicide_weapon = "death_self_zm";
	precacheitem("death_self_zm");
	maps/mp/gametypes_zm/_zm_gametype::rungametypeprecache("zclassic");
}

//Function Number: 3
onstartgametype()
{
	maps/mp/gametypes_zm/_zm_gametype::rungametypemain("zclassic",maps/mp/gametypes_zm/_zm_gametype::zclassic_main);
}