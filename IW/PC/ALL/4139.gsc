/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 4139.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:32:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\sp\_doorpeek::func_59CB();
	lib_0BBD::main("veh_mil_air_ca_dropship","dropship","script_vehicle_dropship_enemy");
	lib_0BBD::main("veh_mil_air_ca_dropship","dropship_plane","script_vehicle_dropship_enemy_plane");
	lib_0BBF::func_B1C7("veh_mil_air_un_dropship_hero_player","dropship","script_vehicle_dropship_player");
	lib_0BF0::main("veh_mil_air_un_pocketdrone",undefined,"script_vehicle_support_drone");
}