/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_instinct.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 207 ms
 * Timestamp: 4/22/2024 2:17:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_instinct_precache::main();
	maps\createart\mp_instinct_art::main();
	maps\mp\mp_instinct_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_instinct_lighting::main();
	maps\mp\mp_instinct_aud::main();
	level.ospvisionset = "mp_instinct_osp";
	level.osplightset = "mp_instinct_osp";
	level.warbirdvisionset = "mp_instinct_osp";
	maps\mp\_compass::setupminimap("compass_map_mp_instinct");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.aerial_pathnode_offset = 350;
	level.orbitalsupportoverridefunc = ::instinctcustomospfunc;
	precachemodel("ins_crane_drilling_mechanism");
	precachemodel("ins_cave_drill");
	precachemodel("ins_generator_engine_01_fan");
	level.river_drills = getentarray("river_drill","targetname");
	level.cave_drills = getentarray("cave_drill","targetname");
	level.cave_drills_inside = getentarray("cave_drill_inside","targetname");
	level thread drilling_animation();
	level thread generator_fans();
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
	thread scriptpatchclip();
	setdvar("r_reactivemotionfrequencyscale",0.5);
	setdvar("r_reactivemotionamplitudescale",0.5);
}

//Function Number: 2
scriptpatchclip()
{
	thread treepatchclip();
}

//Function Number: 3
treepatchclip()
{
	var_00 = (0,348,0);
	var_01 = (1314,60,616);
	var_02 = 0;
	for(var_03 = 0;var_03 < 16;var_03++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",var_01 + (0,0,var_02),var_00);
		var_02 = var_02 + 64;
	}
}

//Function Number: 4
instinctcustomospfunc()
{
	level.orbitalsupportoverrides.spawnheight = 9615;
	level.orbitalsupportoverrides.toparc = -35;
	level.orbitalsupportoverrides.rightarc = 18;
	level.orbitalsupportoverrides.leftarc = 18;
}

//Function Number: 5
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","2","r_tonemapLockAutoExposureAdjust","0","r_tonemapAutoExposureAdjust","0");
		}
	}
}

//Function Number: 6
river_drilling_animation()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_03 = common_scripts\utility::spawn_tag_origin();
	wait(0.05);
	var_00 show();
	var_01 show();
	var_02 show();
	var_03 show();
	wait(0.4);
	var_00 linkto(self,"poundee",(75,0,400),(0,0,0));
	var_01 linkto(self,"poundee",(75,0,400),(90,0,90));
	var_02 linkto(self,"tag_origin",(0,0,100),(0,0,0));
	var_03 linkto(self,"tag_origin",(0,0,-100),(270,180,90));
	common_scripts\utility::noself_delaycall(1,::playfxontag,common_scripts\utility::getfx("diesel_drill_smk_loop"),var_00,"tag_origin");
	wait(0.1);
	for(;;)
	{
		earthquake(0.15,1,var_02.origin,500);
		common_scripts\utility::noself_delaycall(0.4,::playfxontag,common_scripts\utility::getfx("drill_impact_dust"),var_03,"tag_origin");
		wait(2);
		common_scripts\utility::noself_delaycall(0.4,::playfxontag,common_scripts\utility::getfx("diesel_drill_smk_ring"),var_01,"tag_origin");
	}
}

//Function Number: 7
drilling_animation()
{
	level endon("end_drill_anims");
	wait(1);
	animate_drills();
}

//Function Number: 8
animate_drills()
{
	if(isdefined(level.river_drills))
	{
		common_scripts\utility::array_thread(level.river_drills,::update_river_drill_anim);
	}

	if(isdefined(level.cave_drills))
	{
		common_scripts\utility::array_thread(level.cave_drills,::update_cave_drill_anim);
	}

	if(isdefined(level.cave_drills_inside))
	{
		common_scripts\utility::array_thread(level.cave_drills_inside,::update_cave_drill_anim_inside);
	}
}

//Function Number: 9
update_river_drill_anim()
{
	level endon("end_drill_anims");
	var_00 = randomfloat(2);
	wait(0.05);
	wait(var_00);
	maps\mp\_audio::scriptmodelplayanimwithnotify(self,"ins_drilling_machine","ps_ins_piledriver_hit","ins_piledriver_hit","end_drill_anims","stop_sequencing_notetracks","lagos_dyn_event");
	thread river_drilling_animation();
}

//Function Number: 10
update_cave_drill_anim()
{
	var_00 = randomfloat(2);
	wait(0.05);
	wait(var_00);
	maps\mp\_audio::scriptmodelplayanimwithnotify(self,"ins_cave_drill_idle","ins_piledriver_cave_hit","ins_piledriver_cave_hit","end_drill_anims","stop_sequencing_notetracks","lagos_dyn_event");
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "impact_fx")
	{
		wait(0.5);
		thread maps\mp\mp_instinct_fx::cave_drill_rock_impact_fx();
	}
}

//Function Number: 11
update_cave_drill_anim_inside()
{
	level endon("end_drill_anims");
	var_00 = randomfloat(2);
	wait(var_00);
	maps\mp\_audio::scriptmodelplayanimwithnotify(self,"ins_cave_drill_idle","ins_piledriver_cave_hit","ins_piledriver_cave_hit","end_drill_anims","stop_sequencing_notetracks","lagos_dyn_event");
}

//Function Number: 12
generator_fans()
{
	var_00 = getentarray("generator_fans","targetname");
	foreach(var_02 in var_00)
	{
		var_02 scriptmodelplayanim("ins_generator_fan");
	}
}