/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: security_camera_scanner_destp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 2:03:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\_destructible::destructible_create("security_camera_scanner_destp","tag_origin",10);
	common_scripts\_destructible::destructible_fx_spawn_immediate("tag_fx","vfx/destructible/security_cam_scanner",1,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_fx","vfx/destructible/security_cam_scanner_xplod",1);
	common_scripts\_destructible::destructible_state("tag_origin","security_camera_01");
}