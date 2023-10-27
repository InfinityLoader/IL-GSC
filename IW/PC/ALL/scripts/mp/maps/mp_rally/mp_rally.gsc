/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_rally\mp_rally.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 1129 ms
 * Timestamp: 10/27/2023 12:14:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_rally\mp_rally_precache::main();
	scripts\mp\maps\mp_rally\gen\mp_rally_art::main();
	scripts\mp\maps\mp_rally\mp_rally_fx::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_rally");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_umbraAccurateOcclusionThreshold",1024);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	thread setupintroexploders();
	thread burninatorsetup("burninator_kill_trigger","burninator_activator");
	thread setupspinningblades();
	thread barreldroppersetup("gas_barrel_activator_trigger","gas_barrel_activator","gas_barrel_lever","gas_damage_trigger");
	thread setuppowerlines();
	thread wiggletheballoon("balloon");
	thread scripts\mp\_animation_suite::func_1FAA();
	level._effect["burn_kill"] = loadfx("vfx/iw7/levels/mp_rally/vfx_burninator_death.vfx");
	level._effect["blade_kill"] = loadfx("vfx/iw7/levels/mp_rally/vfx_body_exp.vfx");
	level._effect["shock_kill"] = loadfx("vfx/iw7/levels/mp_rally/vfx_shock_death.vfx");
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	thread apex_not_outofbounds();
	level.modifiedspawnpoints["-560 -1344 131"]["mp_tdm_spawn"]["remove"] = 1;
	level.modifiedspawnpoints["-560 -1344 131"]["mp_dom_spawn"]["remove"] = 1;
	level.modifiedspawnpoints["-560 -1344 131"]["mp_dm_spawn"]["remove"] = 1;
	thread fixcollision();
}

//Function Number: 2
fixcollision()
{
	var_00 = getent("clip64x64x128","targetname");
	var_01 = spawn("script_model",(818,1916,56));
	var_01.angles = (0,333,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = spawn("script_model",(160,784,96));
	var_02.angles = (0,330,-180);
	var_02 setmodel("mp_desert_uplink_col_01");
	var_03 = spawn("script_model",(1148,-52,64));
	var_03.angles = (0,205,0);
	var_03 setmodel("mp_desert_uplink_col_01");
}

//Function Number: 3
wiggletheballoon(param_00)
{
	level endon("game_ended");
	var_01 = getent(param_00,"targetname");
	for(;;)
	{
		var_01 rotateto((0,0,3),5,1,1);
		wait(5);
		var_01 rotateto((0,0,0),5,1,1);
		wait(5);
	}
}

//Function Number: 4
setupspinningblades()
{
	level endon("game_ended");
	var_00 = getentarray("spinning_blades","targetname");
	foreach(var_02 in var_00)
	{
		thread spinthisblade(var_02);
	}

	var_04 = getent("decapitator_kill_trigger","targetname");
	for(;;)
	{
		var_04 waittill("trigger",var_05);
		if(isdefined(var_05))
		{
			if(isdefined(var_05.var_110EA) && var_05.var_110EA == "remote_c8")
			{
				var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_05.var_222,var_04,var_05.var_222.team,var_04.origin,"MOD_MELEE","bombproj_mp");
				continue;
			}

			if(isplayer(var_05))
			{
				if(var_05 method_84D9())
				{
					continue;
				}

				var_05 suicide();
				if(var_05.var_AE62 == "archetype_scout")
				{
					playfx(level._effect["reaper_kill_robot"],var_05.origin + (0,0,0));
				}
				else
				{
					playfx(level._effect["blade_kill"],var_05.origin + (0,0,0));
				}

				continue;
			}

			if(isdefined(var_05.classname) && var_05.classname == "script_vehicle")
			{
				if(isdefined(var_05.var_110EA))
				{
					if(var_05.var_110EA == "minijackal")
					{
						var_05 notify("minijackal_end");
						continue;
					}

					if(var_05.var_110EA == "venom")
					{
						var_05 notify("venom_end",var_05.origin);
					}
				}
			}
		}
	}
}

//Function Number: 5
spinthisblade(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 rotateyaw(360,0.25,0,0);
		wait(0.25);
	}
}

//Function Number: 6
setuppowerlines()
{
	level endon("game_ended");
	var_00 = getent("power_line_death","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			if(isplayer(var_01))
			{
				if(var_01 method_84D9())
				{
					continue;
				}

				var_01 suicide();
				playfx(level._effect["shock_kill"],var_01.origin + (0,0,0));
				continue;
			}

			if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
			{
				if(isdefined(var_01.var_110EA))
				{
					if(var_01.var_110EA == "minijackal")
					{
						var_01 notify("minijackal_end");
						continue;
					}

					if(var_01.var_110EA == "venom")
					{
						var_01 notify("venom_end",var_01.origin);
					}
				}
			}
		}
	}
}

//Function Number: 7
barreldroppersetup(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	var_04 makeusable();
	var_04 sethintstring(&"MP_RALLY_ACTIVATE_BARREL");
	var_04 method_84A4(64);
	var_04 method_84A6(60);
	var_04 method_84A2(64);
	var_04 method_84A5(60);
	var_05 = getent(param_03,"targetname");
	var_05.var_A63A = spawn("script_model",(-544,-1312,352));
	var_05.var_A63A setmodel("tag_origin");
	var_05.israllytrap = 1;
	var_06 = scripts\common\utility::getstruct("gas_barrel_explosion_loc","targetname");
	var_05.explosionloc = var_06.origin;
	var_05 scripts\common\utility::trigger_off(var_05.var_336,"targetname");
	var_07 = getent(param_01,"targetname");
	var_07.initialpos = var_07.origin;
	var_07.activepos = var_07.origin + (0,0,-16);
	var_08 = getent(param_02,"targetname");
	var_08.initialpos = var_08.origin;
	var_08.activepos = var_08.origin + (0,0,-16);
	thread barreldropperloop(var_04,var_07,var_08,var_05);
	thread barrelhandelwobbel(var_07);
}

//Function Number: 8
barrelhandelwobbel(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		var_01 = randomfloatrange(-0.1,0.1);
		var_02 = randomfloatrange(-5,5);
		var_03 = randomfloatrange(-0.1,0.1);
		param_00 rotateto((var_01,var_02,var_03),2,0.25,0.25);
		wait(2);
	}
}

//Function Number: 9
barreldropperloop(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		param_00 makeunusable();
		var_05 = var_04.team;
		var_04 playlocalsound("barrel_lever");
		scripts\common\utility::exploder(30);
		param_01 moveto(param_01.activepos,1,0.5,0.5);
		param_02 moveto(param_02.activepos,1,0.5,0.5);
		playsoundatpos((-803,-1234,526),"barrel_tumble");
		wait(1);
		param_01 moveto(param_01.initialpos,1,0.5,0.5);
		param_02 moveto(param_02.initialpos,1,0.5,0.5);
		wait(1);
		var_06 = level.players;
		var_07 = level.var_1655;
		param_03 scripts\common\utility::trigger_on(param_03.var_336,"targetname");
		var_08 = scripts\common\utility::array_combine(var_06,var_07);
		foreach(var_0A in var_06)
		{
			if(!var_0A method_84D9() && !isdefined(var_0A.isrewinding) && var_0A.isrewinding == 1)
			{
				if(var_0A.team == var_05 && var_0A istouching(param_03))
				{
					var_0A suicide();
					continue;
				}

				if(var_0A istouching(param_03))
				{
					if(isdefined(var_04))
					{
						var_0A dodamage(1000,param_03.explosionloc,var_04,param_03);
						continue;
					}

					var_0A suicide();
				}
			}
		}

		if(isdefined(var_07))
		{
			foreach(var_0D in var_07)
			{
				if(var_0D istouching(param_03))
				{
					if(var_0D.var_110EA == "minijackal")
					{
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_EXPLOSIVE","bombproj_mp");
						continue;
					}

					if(var_0D.var_110EA == "venom")
					{
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_EXPLOSIVE","bombproj_mp");
						continue;
					}

					if(var_0D.var_110EA == "sentry_shock")
					{
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
						scripts\common\utility::func_136F7();
						var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,var_04,param_03,var_0D.team,param_03.origin,"MOD_MELEE","bombproj_mp");
					}
				}
			}
		}

		var_0F = scripts\mp\perks\_perkfunctions::func_7D96();
		if(isdefined(var_0F))
		{
			foreach(var_11 in var_0F)
			{
				if(var_11 istouching(param_03))
				{
					var_11 scripts\mp\killstreaks\_utility::dodamagetokillstreak(1000,var_04,param_03,var_11.team,param_03.origin,"MOD_EXPLOSIVE","bombproj_mp");
				}
			}
		}

		playsoundatpos(param_03.explosionloc,"barrel_impact");
		physicsexplosionsphere(param_03.explosionloc,160,80,150);
		scripts\common\utility::func_136F7();
		var_13 = 1;
		thread lingeringgascloudwatch(var_13,param_03,var_04,var_05);
		wait(10);
		var_13 = 0;
		param_03 scripts\common\utility::trigger_off(param_03.var_336,"targetname");
		param_00 makeusable();
	}
}

//Function Number: 10
lingeringgascloudwatch(param_00,param_01,param_02,param_03)
{
	while(param_00)
	{
		param_01 waittill("trigger",var_04);
		if(isplayer(var_04))
		{
			if(isdefined(var_04.isrewinding) && var_04.isrewinding == 1)
			{
				continue;
			}

			if(!isdefined(var_04.isindoomjuice))
			{
				thread playeringaswatcher(var_04,param_00,param_01,param_02,param_03);
				continue;
			}

			if(!var_04.isindoomjuice)
			{
				thread playeringaswatcher(var_04,param_00,param_01,param_02,param_03);
			}
		}
	}
}

//Function Number: 11
playeringaswatcher(param_00,param_01,param_02,param_03,param_04)
{
	param_00.isindoomjuice = 1;
	while(param_01 && param_00.isindoomjuice)
	{
		if(scripts\mp\_utility::func_9EF0(param_00))
		{
			break;
		}

		if(param_00 istouching(param_02))
		{
			if(param_00.team == param_04)
			{
				if(param_00.health > 20)
				{
					param_00 dodamage(20,param_02.explosionloc,param_02);
				}
				else
				{
					param_00 suicide();
				}
			}
			else if(isdefined(param_03))
			{
				param_00 dodamage(20,param_02.explosionloc,param_03);
			}
			else if(param_00.health > 20)
			{
				param_00 dodamage(20,param_02.explosionloc,param_02);
			}
			else
			{
				param_00 suicide();
			}

			continue;
		}

		param_00.isindoomjuice = 0;
		wait(1);
	}
}

//Function Number: 12
burninatorsetup(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02.bigredbutton = getent(param_01,"targetname");
	var_02.bigredbutton makeusable();
	var_02.bigredbutton sethintstring(&"MP_RALLY_ACTIVATE_FIRE");
	var_02.bigredbutton method_84A4(64);
	var_02.bigredbutton method_84A6(60);
	var_02.bigredbutton method_84A2(64);
	var_02.bigredbutton method_84A5(60);
	var_02.var_A63A = spawn("script_model",(956,996,268));
	var_02.var_A63A setmodel("tag_origin");
	var_02.israllytrap = 1;
	thread burninatortriggerwatch(var_02);
	var_02.flameon = 0;
}

//Function Number: 13
burninatortriggerwatch(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00.bigredbutton waittill("trigger",var_01);
		param_00.bigredbutton makeunusable();
		scripts\common\utility::exploder(22);
		wait(2);
		param_00.flameon = 1;
		thread watchforvictims(param_00,var_01);
		thread burninantordestroyequipment(param_00,var_01);
		wait(10);
		param_00.flameon = 0;
		param_00.bigredbutton makeusable();
	}
}

//Function Number: 14
burninantordestroyequipment(param_00,param_01)
{
	while(param_00.flameon)
	{
		var_02 = level.var_1655;
		var_03 = scripts\mp\perks\_perkfunctions::func_7D96();
		if(isdefined(var_03))
		{
			foreach(var_05 in var_03)
			{
				if(var_05 istouching(param_00))
				{
					var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000,param_01,param_00,var_05.team,param_00.origin,"MOD_EXPLOSIVE","bombproj_mp");
				}
			}
		}

		if(isdefined(var_02))
		{
			foreach(var_05 in var_02)
			{
				if(var_05.var_110EA == "sentry_shock" && var_05 istouching(param_00))
				{
					var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000,param_01,param_00,var_05.team,param_00.origin,"MOD_MELEE","bombproj_mp");
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 15
watchforvictims(param_00,param_01)
{
	level endon("game_ended");
	while(param_00.flameon)
	{
		param_00 waittill("trigger",var_02);
		if(!param_00.flameon)
		{
			break;
		}

		if(isdefined(var_02))
		{
			if(isplayer(var_02))
			{
				if(var_02 method_84D9())
				{
					continue;
				}

				if(isdefined(var_02.isrewinding) && var_02.isrewinding == 1)
				{
					continue;
				}

				burninatorplaydeathfx(param_00,var_02,param_01);
				scripts\common\utility::func_136F7();
				scripts\common\utility::func_136F7();
				continue;
			}

			if(isdefined(var_02.classname) && var_02.classname == "script_vehicle")
			{
				if(isdefined(var_02.var_110EA))
				{
					if(var_02.var_110EA == "minijackal")
					{
						var_02 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000,param_01,param_00,var_02.team,param_00.origin,"MOD_EXPLOSIVE","bombproj_mp");
						continue;
					}

					if(var_02.var_110EA == "venom")
					{
						var_02 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000,param_01,param_00,var_02.team,param_00.origin,"MOD_EXPLOSIVE","bombproj_mp");
					}
				}
			}
		}
	}
}

//Function Number: 16
burninatorplaydeathfx(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_01.team != param_02.team)
	{
		param_01 dodamage(10000,param_00.origin,param_02,param_00);
	}
	else
	{
		param_01 suicide();
	}

	scripts\common\utility::func_136F7();
	scripts\common\utility::func_136F7();
	var_03 = anglestoforward(param_01.angles);
	var_04 = param_01 method_8113();
	if(isdefined(var_04))
	{
		var_04 hide(1);
		var_04.var_CA6C = 1;
		if(param_01.var_AE62 == "archetype_scout")
		{
			playfx(level._effect["reaper_kill_robot"],param_01.origin + (0,0,0));
			return;
		}

		playfx(level._effect["burn_kill"],param_01.origin + (0,0,0),var_03);
	}
}

//Function Number: 17
setupintroexploders()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread fireintroexploders();
		var_00 thread watchforkillstreakuse();
	}
}

//Function Number: 18
fireintroexploders()
{
	self waittill("mapCamera_start");
	wait(0.5);
	scripts\common\utility::exploder(10,self);
	wait(1);
	scripts\common\utility::exploder(15,self);
}

//Function Number: 19
watchforkillstreakuse()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killstreak_use_finished",var_00,var_01);
		if(!scripts\common\utility::istrue(var_01))
		{
			continue;
		}

		if(!killstreakactivateflares(var_00))
		{
			continue;
		}

		scripts\common\utility::exploder(15);
	}
}

//Function Number: 20
killstreakactivateflares(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "thor":
		case "nuke":
		case "precision_airstrike":
		case "bombardment":
		case "jackal":
		case "sentry_shock":
		case "minijackal":
		case "remote_c8":
			var_01 = 1;
			break;
	}

	return var_01;
}

//Function Number: 21
firebroshotexploders()
{
	self waittill("bro_shot_start");
	wait(0.5);
	scripts\common\utility::exploder(15,self);
}

//Function Number: 22
apex_not_outofbounds()
{
	level.outofboundstriggerpatches = [];
	var_00 = getent("apex_unoutofbounds","targetname");
	level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_00;
	level waittill("game_ended");
	foreach(var_00 in level.outofboundstriggerpatches)
	{
		if(isdefined(var_00))
		{
			var_00 delete();
		}
	}
}