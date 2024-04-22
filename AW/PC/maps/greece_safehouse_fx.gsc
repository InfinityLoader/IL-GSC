/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_safehouse_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 218 ms
 * Timestamp: 4/22/2024 2:31:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread precachefx();
}

//Function Number: 2
precachefx()
{
	level._effect["foliage_dub_potted_spikey_plant"] = loadfx("fx/props/foliage_dub_potted_spikey_plant");
	level._effect["knife_kill_fx"] = loadfx("fx/maps/warlord/intro_blood_throat_stab");
	level._effect["sniper_drone_fan_distortion"] = loadfx("vfx/distortion/sniper_drone_runner");
	level._effect["paint_grenade"] = loadfx("vfx/explosion/paint_grenade");
	level._effect["steam_coffee"] = loadfx("vfx/steam/steam_coffee_slow");
}

//Function Number: 3
intro_tablet_touch_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("tablet_touch_green"),param_00,"body_animate_jnt");
}

//Function Number: 4
outro_tablet_touch_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("tablet_touch_red"),param_00,"body_animate_jnt");
}

//Function Number: 5
intro_drone_tablet_touch_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("tablet_touch_green2"),param_00,"body_animate_jnt");
}

//Function Number: 6
outro_drone_tablet_touch_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("tablet_touch_red2"),param_00,"body_animate_jnt");
}

//Function Number: 7
broom_sweep_dust_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("broom_sweeping_dust"),param_00,"TAG_ORIGIN");
}

//Function Number: 8
guarddustdrag()
{
	common_scripts\_exploder::exploder(70);
}

//Function Number: 9
sniperdroneprep()
{
	common_scripts\_exploder::exploder(100);
	wait(3.5);
	common_scripts\_exploder::exploder(101);
}

//Function Number: 10
dronedraftplants()
{
	common_scripts\_exploder::exploder(120);
}

//Function Number: 11
ambientcloudsloadin()
{
	common_scripts\_exploder::exploder(130);
}

//Function Number: 12
ambientcloudskill()
{
	common_scripts\_exploder::kill_exploder(130);
}

//Function Number: 13
safehousesonicdustfx()
{
	common_scripts\_exploder::exploder(132);
}

//Function Number: 14
safehousegatebashfx()
{
	common_scripts\_exploder::exploder(140);
}