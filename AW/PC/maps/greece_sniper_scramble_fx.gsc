/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_sniper_scramble_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 340 ms
 * Timestamp: 4/22/2024 2:31:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread precachefx();
	common_scripts\utility::flag_init("SniperDashFXTrigger1");
	thread sniperdashburstfx1();
	common_scripts\utility::flag_init("SniperDashFXTrigger2");
	thread sniperdashburstfx2();
	common_scripts\utility::flag_init("SniperDashFXTrigger3");
	thread sniperdashburstfx3();
	common_scripts\utility::flag_init("SniperDashFXTrigger4");
	thread sniperdashburstfx4();
	common_scripts\utility::flag_init("SniperDashFXTrigger5");
	thread sniperdashburstfx5();
	common_scripts\utility::flag_init("SniperDashFXTrigger6");
	thread sniperdashburstfx6();
}

//Function Number: 2
precachefx()
{
	level._effect["smoke_screen"] = loadfx("vfx/map/greece/greece_smoke_screen_wind_15sec");
	level._effect["railgun_sniper_tracer"] = loadfx("vfx/muzzleflash/sniper_railgun_tracer");
	level._effect["railgun_sniper_glint"] = loadfx("vfx/lensflare/scope_glint2_greece");
	level._effect["bottles_misc1_destruct"] = loadfx("fx/props/bottles_misc1_destruct");
	level._effect["bottles_misc2_destruct"] = loadfx("fx/props/bottles_misc2_destruct");
	level._effect["bottles_misc3_destruct"] = loadfx("fx/props/bottles_misc3_destruct");
	level._effect["bottles_misc4_destruct"] = loadfx("fx/props/bottles_misc4_destruct");
	level._effect["bottles_misc5_destruct"] = loadfx("fx/props/bottles_misc5_destruct");
	level._effect["stinger_rocket_explosion"] = loadfx("vfx/map/greece/greece_rocket_explosion_default");
	level._effect["scramble_blood_impact_splat"] = loadfx("vfx/map/greece/greece_flesh_impact_blood_splat2");
	level._effect["restaurant_fish_tank_water_splash"] = loadfx("vfx/water/greece_fishtank_splash_des");
	level._effect["restaurant_fish_tank_bubbles"] = loadfx("vfx/water/greece_fishtank_bubbles");
	level._effect["manga_rocket_trail"] = loadfx("vfx/trail/smoketrail_rpg_greece");
	level._effect["manga_rocket_explosion"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_burst");
	level._effect["vehicle_tire_smoke_3"] = loadfx("vfx/map/greece/greece_veh_tire_damage_smk_3");
	level._effect["move_truck_fire"] = loadfx("vfx/map/greece/greece_vehicle_move_truck_fire");
}

//Function Number: 3
sniperdoorhitfx1(param_00)
{
	playfxontag(common_scripts\utility::getfx("sniper_door_hit"),param_00,"tag_hole1");
}

//Function Number: 4
sniperdoorhitfx2(param_00)
{
	playfxontag(common_scripts\utility::getfx("sniper_door_hit"),param_00,"tag_hole2");
}

//Function Number: 5
smokescreenemitterfx()
{
	common_scripts\_exploder::exploder(145);
}

//Function Number: 6
windowgapjumpglassshatter()
{
	common_scripts\_exploder::exploder(150);
	var_00 = common_scripts\utility::getstruct("ScramblePlayerGapJumpGlassRef","targetname");
	level waittill("ScramblePlayerBreakWindowGapJump");
	glassradiusdamage(var_00.origin,64,1000,1000);
	level.player playrumbleonentity("damage_light");
	earthquake(0.6,0.4,var_00.origin,40);
	screenshake(var_00.origin,0.2,0.2,0.2,0.4,0,-1,40);
}

//Function Number: 7
windowhoteljumpglassshatter(param_00)
{
	wait(param_00);
	var_01 = getent("ScramblePlayerHotelJumpRef","targetname");
	glassradiusdamage(var_01.origin,64,1000,1000);
	var_02 = getglass("ScrambleHotelGlass");
	if(!isglassdestroyed(var_02))
	{
		earthquake(0.2,0.2,var_02.origin,20);
		screenshake(var_02.origin,0.1,0.1,0.1,0.2,0,-1,20);
	}
}

//Function Number: 8
sniperdashburstfx1()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger1");
		common_scripts\_exploder::exploder("151");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger1");
	}

	wait(5);
}

//Function Number: 9
sniperdashburstfx2()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger2");
		common_scripts\_exploder::exploder("152");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger2");
	}

	wait(5);
}

//Function Number: 10
sniperdashburstfx3()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger3");
		common_scripts\_exploder::exploder("153");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger3");
	}

	wait(5);
}

//Function Number: 11
sniperdashburstfx4()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger4");
		common_scripts\_exploder::exploder("154");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger4");
	}

	wait(5);
}

//Function Number: 12
sniperdashburstfx5()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger5");
		common_scripts\_exploder::exploder("155");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger5");
	}

	wait(5);
}

//Function Number: 13
sniperdashburstfx6()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("SniperDashFXTrigger6");
		common_scripts\_exploder::exploder("156");
		common_scripts\utility::flag_waitopen("SniperDashFXTrigger6");
	}

	wait(5);
}

//Function Number: 14
snipercafewallburstfx()
{
	common_scripts\_exploder::exploder(160);
}

//Function Number: 15
snipertowerexplosionfx()
{
	common_scripts\_exploder::exploder(200);
}

//Function Number: 16
snipertowerresidualfx()
{
	common_scripts\_exploder::exploder(201);
}

//Function Number: 17
ragdollonfirefx()
{
	playfxontag(common_scripts\utility::getfx("character_fire_torso"),self,"J_SpineUpper");
}

//Function Number: 18
movetruckfirefx()
{
	var_00 = getent("ScrambleExitTruck","targetname");
	var_00.animname = "exit_truck";
	playfxontag(common_scripts\utility::getfx("move_truck_fire"),var_00,"TAG_ORIGIN");
	soundscripts\_snd::snd_message("exit_truck_fire",var_00);
}

//Function Number: 19
movetrucktiresmokefx()
{
	var_00 = getent("ScrambleExitTruck","targetname");
	var_00.animname = "exit_truck";
	playfxontag(common_scripts\utility::getfx("vehicle_tire_smoke_3"),var_00,"TAG_ORIGIN");
}

//Function Number: 20
fishbubblesfx()
{
	common_scripts\_exploder::exploder(999);
}

//Function Number: 21
killfishbubblesfx()
{
	common_scripts\_exploder::kill_exploder(999);
}