/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_blackbox.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 395 ms
 * Timestamp: 4/22/2024 2:12:28 AM
*******************************************************************/

//Function Number: 1
streak_init()
{
	precacheitem("iw5_dlcgun12loot4_mp");
	precacheshader("dpad_killstreak_lost_static");
	precacheshader("overlay_blackbox_killstreak");
	level.killstreakfuncs["mp_blackbox"] = ::tryusempblackbox;
	level.mapkillstreak = "mp_blackbox";
	level.mapkillstreakpickupstring = &"MP_BLACKBOX_MAP_KILLSTREAK_PICKUP";
	level.killstreakoverlay = "overlay_blackbox_killstreak";
	level.killstreak_trail_fx = loadfx("vfx/map/mp_blackbox/trail_on_character");
	level.killstreak_chest_fx = loadfx("vfx/map/mp_blackbox/killstreak_chest_vfx");
}

//Function Number: 2
test_give_players_map_killstreak()
{
	wait(60);
	for(;;)
	{
		if(isdefined(level.players) && level.players.size > 0)
		{
			var_00 = level.players[randomintrange(0,level.players.size)];
			if(isdefined(var_00) && var_00.team != "spectator" && isdefined(var_00.killstreakmodules) && !var_00 hasweapon("iw5_dlcgun12loot4_mp") && !isbot(var_00) && !isagent(var_00))
			{
				if(!isdefined(var_00.map_killstreak_active) || !var_00.map_killstreak_active)
				{
					if(!isdefined(var_00.given_map_killstreak) || !var_00.given_map_killstreak)
					{
						var_00.given_map_killstreak = 1;
						var_00 maps\mp\killstreaks\_killstreaks::givekillstreak(level.mapkillstreak);
					}
				}
			}
		}

		wait(20);
	}
}

//Function Number: 3
tryusempblackbox(param_00,param_01)
{
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isdefined(self.map_killstreak_active) && self.map_killstreak_active)
	{
		return 0;
	}

	thread enable_alien_mode();
	return 1;
}

//Function Number: 4
setcreature()
{
	self.radar_highlight = newclienthudelem(self);
	self.radar_highlight.color = (1,0.015,0.015);
	self.radar_highlight.alpha = 1;
	self.radar_highlight setradarhighlight(60);
}

//Function Number: 5
unsetcreature()
{
	if(isdefined(self.radar_highlight))
	{
		self.radar_highlight destroy();
	}
}

//Function Number: 6
enable_alien_mode()
{
	self playsound("ks_blackbox_spore_use");
	level.perksetfuncs["specialty_exo_creature"] = ::setcreature;
	level.perkunsetfuncs["specialty_exo_creature"] = ::unsetcreature;
	self.map_killstreak_active = 1;
	disable_exo_usage();
	alien_mode_abilities();
	enable_clientfx();
	enable_fx();
	thread alien_mode_reapply_on_death();
	alien_mode_timer();
	self notify("notify_end_killstreak_mode");
	self.map_killstreak_active = 0;
	disable_alien_mode();
	disable_clientfx();
	disable_fx();
	reenable_exo_usage();
	level.perksetfuncs["specialty_exo_creature"] = undefined;
	level.perkunsetfuncs["specialty_exo_creature"] = undefined;
}

//Function Number: 7
disable_alien_mode()
{
	alien_mode_overdrive_off();
	alien_extra_health_off();
	self allowsprint(0);
	wait(0.1);
	maps\mp\_utility::_clearperks();
	self.perks = self.oldperks;
	maps\mp\perks\_perks::applyperks();
	foreach(var_01 in self.loadoutperks)
	{
		if(var_01 == "specialty_exo_blastsuppressor")
		{
			maps\mp\_utility::giveperk("specialty_exo_blastsuppressor",0);
		}
	}

	self allowsprint(1);
	self notify("stop_exo_repulsor");
	self.killstreaksdisabled = undefined;
}

//Function Number: 8
disable_exo_usage()
{
	if(self hasweapon("adrenaline_mp"))
	{
		self.has_overclock_ability = 1;
		self.overclock_battery_charge = self batterygetcharge("adrenaline_mp");
		self batterysetcharge("adrenaline_mp",0);
	}

	if(self hasweapon("extra_health_mp"))
	{
		self.has_stim_ability = 1;
		self.stim_battery_charge = self batterygetcharge("extra_health_mp");
		self batterysetcharge("extra_health_mp",0);
	}

	if(isdefined(level.cloakweapon) && self hasweapon(level.cloakweapon))
	{
		self.has_cloak_ability = 1;
		self.cloak_battery_charge = self batterygetcharge(maps\mp\_exo_cloak::get_exo_cloak_weapon());
		self batterysetcharge(maps\mp\_exo_cloak::get_exo_cloak_weapon(),0);
	}

	if(isdefined(level.hoverweapon) && self hasweapon(level.hoverweapon))
	{
		self.has_hover_ability = 1;
		self.hover_battery_charge = self batterygetcharge(level.hoverweapon);
		self batterysetcharge(level.hoverweapon,0);
	}

	if(self hasweapon("exomute_equipment_mp"))
	{
		self.has_mute_ability = 1;
		self.mute_battery_charge = self batterygetcharge("exomute_equipment_mp");
		self batterysetcharge("exomute_equipment_mp",0);
	}

	if(self hasweapon("exoping_equipment_mp"))
	{
		self.has_ping_ability = 1;
		self.ping_battery_charge = self batterygetcharge("exoping_equipment_mp");
		self batterysetcharge("exoping_equipment_mp",0);
	}

	if(self hasweapon("exorepulsor_equipment_mp"))
	{
		self.has_trophy_ability = 1;
		self.trophy_battery_charge = self batterygetcharge("exorepulsor_equipment_mp");
		self batterysetcharge("exorepulsor_equipment_mp",0);
	}

	if(isdefined(level.exoshieldweapon) && self hasweapon(level.exoshieldweapon))
	{
		self.has_shield_ability = 1;
		self.shield_battery_charge = self batterygetcharge(maps\mp\_exo_shield::get_exo_shield_weapon());
		self batterysetcharge(maps\mp\_exo_shield::get_exo_shield_weapon(),0);
	}
}

//Function Number: 9
reenable_exo_usage()
{
	if(isdefined(self.has_overclock_ability) && self.has_overclock_ability == 1)
	{
		self batterysetcharge("adrenaline_mp",self.overclock_battery_charge);
	}

	if(isdefined(self.has_stim_ability) && self.has_stim_ability == 1)
	{
		self batterysetcharge("extra_health_mp",self.stim_battery_charge);
	}

	if(isdefined(self.has_cloak_ability) && self.has_cloak_ability == 1)
	{
		self batterysetcharge(maps\mp\_exo_cloak::get_exo_cloak_weapon(),self.cloak_battery_charge);
	}

	if(isdefined(self.has_hover_ability) && self.has_hover_ability == 1)
	{
		self batterysetcharge(level.hoverweapon,self.hover_battery_charge);
	}

	if(isdefined(self.has_mute_ability) && self.has_mute_ability == 1)
	{
		self batterysetcharge("exomute_equipment_mp",self.mute_battery_charge);
	}

	if(isdefined(self.has_ping_ability) && self.has_ping_ability == 1)
	{
		self batterysetcharge("exoping_equipment_mp",self.ping_battery_charge);
	}

	if(isdefined(self.has_trophy_ability) && self.has_trophy_ability == 1)
	{
		self batterysetcharge("exorepulsor_equipment_mp",self.trophy_battery_charge);
	}

	if(isdefined(self.has_shield_ability) && self.has_shield_ability == 1)
	{
		self batterysetcharge(maps\mp\_exo_shield::get_exo_shield_weapon(),self.shield_battery_charge);
	}
}

//Function Number: 10
alien_mode_abilities()
{
	alien_mode_overdrive_on();
	alien_extra_health_on();
	give_alien_perks();
	self.killstreaksdisabled = 1;
	thread alien_mode_exo_repulsor_on();
	thread alien_mode_unlimited_ammo();
}

//Function Number: 11
give_alien_perks()
{
	self.oldperks = self.perks;
	self setviewkickscale(0.5);
	maps\mp\_utility::giveperk("specialty_exo_slamboots",0);
	maps\mp\_utility::giveperk("specialty_radarimmune",0);
	maps\mp\_utility::giveperk("specialty_exoping_immune",0);
	maps\mp\_utility::giveperk("specialty_hard_shell",0);
	maps\mp\_utility::giveperk("specialty_throwback",0);
	maps\mp\_utility::giveperk("_specialty_blastshield",0);
	self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale",45) / 100;
	if(isdefined(level.hardcoremode) && level.hardcoremode)
	{
		self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC",90) / 100;
	}

	maps\mp\_utility::giveperk("specialty_lightweight",0);
	maps\mp\_utility::giveperk("specialty_explosivedamage",0);
	maps\mp\_utility::giveperk("specialty_blindeye",0);
	maps\mp\_utility::giveperk("specialty_plainsight",0);
	maps\mp\_utility::giveperk("specialty_coldblooded",0);
	maps\mp\_utility::giveperk("specialty_spygame",0);
	maps\mp\_utility::giveperk("specialty_heartbreaker",0);
	maps\mp\_utility::giveperk("specialty_moreminimap",0);
	maps\mp\_utility::giveperk("specialty_silentkill",0);
	maps\mp\_utility::giveperk("specialty_quickswap",0);
	maps\mp\_utility::giveperk("specialty_fastoffhand",0);
	maps\mp\_utility::giveperk("specialty_sprintreload",0);
	maps\mp\_utility::giveperk("specialty_sprintfire",0);
	maps\mp\_utility::giveperk("specialty_empimmune",0);
	maps\mp\_utility::giveperk("specialty_stun_resistance",0);
	self.stunscaler = 0.1;
	self setviewkickscale(0.2);
	self.ammopickup_scalar = 0.2;
	maps\mp\_utility::giveperk("specialty_scavenger",0);
	maps\mp\_utility::giveperk("specialty_bulletresupply",0);
	maps\mp\_utility::giveperk("specialty_extraammo",0);
	maps\mp\_utility::giveperk("specialty_hardline",0);
	maps\mp\_utility::giveperk("specialty_exo_creature",0);
}

//Function Number: 12
alien_extra_health_on()
{
	thread maps\mp\perks\_perkfunctions::setlightarmor();
	self.maxhealth = int(self.maxhealth * 3);
	self.ignoreregendelay = 1;
	self.healthregenlevel = 0.99;
	self notify("damage");
	maps\mp\_extrahealth::killstimfx();
}

//Function Number: 13
alien_extra_health_off()
{
	thread maps\mp\perks\_perkfunctions::unsetlightarmor();
	if(isdefined(level.ishorde))
	{
		self.maxhealth = self.classmaxhealth + self.hordearmor * 40;
	}
	else
	{
		self.maxhealth = int(self.maxhealth / 3);
	}

	if(self.health > self.maxhealth)
	{
		self.health = self.maxhealth;
	}

	self.healthregenlevel = undefined;
	maps\mp\_extrahealth::killstimfx();
}

//Function Number: 14
alien_mode_overdrive_on()
{
	if(isdefined(self.overclock_on) && self.overclock_on == 1)
	{
		thread maps\mp\_adrenaline::stopadrenaline(1);
	}

	self.adrenaline_speed_scalar = 1.12;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = self.adrenaline_speed_scalar + maps\mp\_utility::lightweightscalar() - 1;
	}
	else
	{
		self.movespeedscaler = self.adrenaline_speed_scalar;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_00 = self getclientomnvar("ui_horde_player_class");
		self.movespeedscaler = min(level.classsettings[var_00]["speed"] + 0.25,10);
	}

	maps\mp\gametypes\_weapons::updatemovespeedscale();
	thread maps\mp\_adrenaline::killoverclockfx();
}

//Function Number: 15
alien_mode_overdrive_off()
{
	self notify("EndAdrenaline");
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}
	else
	{
		self.movespeedscaler = level.baseplayermovescale;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_00 = self getclientomnvar("ui_horde_player_class");
		self.movespeedscaler = level.classsettings[var_00]["speed"];
	}

	maps\mp\gametypes\_weapons::updatemovespeedscale();
	self.adrenaline_speed_scalar = undefined;
}

//Function Number: 16
alien_mode_exo_ping_on()
{
	if(isdefined(self.exo_ping_on) && self.exo_ping_on == 1)
	{
		thread maps\mp\_exo_ping::stop_exo_ping();
	}

	var_00 = 1;
	var_01 = 2;
	thread maps\mp\_threatdetection::detection_highlight_hud_effect(self,60 + var_00);
	while(self.map_killstreak_active)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03) || !isalive(var_03) || self.team == var_03.team)
			{
				continue;
			}

			var_04 = var_03;
			var_04 maps\mp\_threatdetection::addthreatevent([self],var_00 + 0.05,"PAINT_KILLSTREAK",1,0);
		}

		wait(var_00);
	}
}

//Function Number: 17
alien_mode_exo_repulsor_on()
{
	if(!isdefined(level.exo_repulsor_impact))
	{
		level.exo_repulsor_impact = loadfx("vfx/explosion/exo_repulsor_impact");
	}

	if(!isdefined(level.exo_repulsor_activate_vfx))
	{
		level.exo_repulsor_activate_vfx = loadfx("vfx/unique/repulsor_bubble");
	}

	if(!isdefined(level.exo_repulsor_deactivate_vfx))
	{
		level.exo_repulsor_deactivate_vfx = loadfx("vfx/unique/repulsor_bubble_deactivate");
	}

	if(!isdefined(level.exo_repulsor_player_vfx_active))
	{
		level.exo_repulsor_player_vfx_active = loadfx("vfx/unique/exo_repulsor_emitter");
	}

	if(!isdefined(level.exo_repulsor_player_vfx_inactive))
	{
		level.exo_repulsor_player_vfx_inactive = loadfx("vfx/unique/exo_repulsor_inactive");
	}

	if(isdefined(self.repulsoractive) && self.repulsoractive == 1)
	{
		thread maps\mp\_exo_repulsor::stop_repulsor(1);
	}

	thread alien_mode_repulsor_on();
}

//Function Number: 18
alien_mode_repulsor_on()
{
	level endon("game_ended");
	self endon("stop_exo_repulsor");
	maps\mp\_exo_repulsor::exorepulsorinit();
	for(;;)
	{
		for(var_00 = 0;var_00 < level.grenades.size;var_00++)
		{
			var_01 = level.grenades[var_00];
			if(!isdefined(var_01.weaponname))
			{
				continue;
			}

			if(isdefined(var_01.weaponname) && maps\mp\_utility::is_exo_ability_weapon(var_01.weaponname))
			{
				continue;
			}

			if(!isdefined(var_01.owner))
			{
				continue;
			}

			if(isdefined(var_01.owner) && var_01.owner == self)
			{
				continue;
			}

			if(level.teambased && isdefined(var_01.owner.team) && var_01.owner.team == self.team)
			{
				continue;
			}

			var_02 = distance(var_01.origin,self.origin);
			if(var_02 < 385)
			{
				if(sighttracepassed(self geteye(),var_01.origin,0,self))
				{
					var_03 = var_01.origin - self.origin;
					var_04 = vectortoangles(var_03);
					var_05 = anglestoup(var_04);
					var_06 = anglestoforward(var_04);
					var_07 = vectornormalize(var_06);
					var_08 = var_01.origin - 0.2 * var_02 * var_07;
					playfx(level.exo_repulsor_impact,var_08,var_07,var_05);
					var_01 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");
					if(var_01.weaponname == "explosive_drone_mp")
					{
						var_01 notify("mp_exo_repulsor_repel");
						var_01 thread maps\mp\_explosive_drone::explosivegrenadedeath();
					}
					else
					{
						var_01 delete();
					}

					self.projectilesstopped++;
					maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
				}
			}
		}

		for(var_00 = 0;var_00 < level.missiles.size;var_00++)
		{
			var_09 = level.missiles[var_00];
			if(!isdefined(var_09.owner))
			{
				continue;
			}

			if(isdefined(var_09.owner) && var_09.owner == self)
			{
				continue;
			}

			if(level.teambased && isdefined(var_09.owner.team) && var_09.owner.team == self.team)
			{
				continue;
			}

			var_0A = distance(var_09.origin,self.origin);
			if(var_0A < 385)
			{
				if(sighttracepassed(self geteye(),var_09.origin,0,self))
				{
					var_0B = var_09.origin - self.origin;
					var_0C = vectortoangles(var_0B);
					var_0D = anglestoup(var_0C);
					var_0E = anglestoforward(var_0C);
					var_0F = vectornormalize(var_0E);
					var_08 = var_09.origin - 0.2 * var_0A * var_0F;
					playfx(level.exo_repulsor_impact,var_08,var_0F,var_0D);
					var_09 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");
					if(isdefined(var_09.weaponname) && var_09.weaponname == "iw5_exocrossbow_mp")
					{
						stopfxontag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"),var_09.fx_origin,"tag_origin");
					}

					var_09 delete();
					self.projectilesstopped++;
					maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
				}
			}
		}

		for(var_00 = 0;var_00 < level.explosivedrones.size;var_00++)
		{
			var_10 = level.explosivedrones[var_00];
			if(isdefined(var_10))
			{
				if(!isdefined(var_10.owner))
				{
					continue;
				}

				if(isdefined(var_10.owner) && var_10.owner == self)
				{
					continue;
				}

				if(level.teambased && isdefined(var_10.owner.team) && var_10.owner.team == self.team)
				{
					continue;
				}

				var_11 = distance(var_10.origin,self.origin);
				if(var_11 < 385)
				{
					if(sighttracepassed(self geteye(),var_10.origin,0,self))
					{
						var_12 = var_10.origin - self.origin;
						var_13 = vectortoangles(var_12);
						var_14 = anglestoup(var_13);
						var_15 = anglestoforward(var_13);
						var_16 = vectornormalize(var_15);
						var_08 = var_10.origin - 0.2 * var_11 * var_16;
						playfx(level.exo_repulsor_impact,var_08,var_16,var_14);
						var_10 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");
						if(isdefined(var_10.explosivedrone))
						{
							var_10.explosivedrone delete();
						}

						var_10 delete();
						self.projectilesstopped++;
						maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
					}
				}
			}
		}

		foreach(var_18 in level.trackingdrones)
		{
			if(!isdefined(var_18.owner))
			{
				continue;
			}

			if(isdefined(var_18.owner) && var_18.owner == self)
			{
				continue;
			}

			if(level.teambased && isdefined(var_18.owner.team) && var_18.owner.team == self.team)
			{
				continue;
			}

			var_19 = distance(var_18.origin,self.origin);
			if(var_19 < 385)
			{
				if(sighttracepassed(self geteye(),var_18.origin,0,self))
				{
					var_1A = var_18.origin - self.origin;
					var_1B = vectortoangles(var_1A);
					var_1C = anglestoup(var_1B);
					var_1D = anglestoforward(var_1B);
					var_1E = vectornormalize(var_1D);
					var_08 = var_18.origin - 0.2 * var_19 * var_1E;
					playfx(level.exo_repulsor_impact,var_08,var_1E,var_1C);
					var_18 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");
					if(!isremovedentity(var_18) && isdefined(var_18))
					{
						var_18 notify("death");
						maps\mp\_utility::decrementfauxvehiclecount();
					}

					self.projectilesstopped++;
					maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
				}
			}
		}

		if(self.projectilesstopped >= 2)
		{
			if(!isdefined(level.ishorde))
			{
				thread maps\mp\_events::fourplayevent();
			}

			self.projectilesstopped = self.projectilesstopped - 2;
		}

		wait(0.05);
	}

	thread maps\mp\_exo_repulsor::stop_repulsor(1);
}

//Function Number: 19
alien_mode_unlimited_ammo()
{
	self endon("notify_end_killstreak_mode");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		self waittill("reload");
		self setweaponammostock(var_00,weaponstartammo(var_00));
	}
}

//Function Number: 20
alien_mode_reapply_on_death()
{
	self endon("notify_end_killstreak_mode");
	for(;;)
	{
		self waittill("death");
		disable_alien_mode();
		self waittill("spawned_player");
		waittillframeend;
		alien_mode_abilities();
		enable_fx();
		thread aud_play_respawn_squish();
	}
}

//Function Number: 21
alien_mode_timer()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	wait(60);
}

//Function Number: 22
enable_clientfx()
{
	self setclutoverrideenableforplayer("clut_mp_blackbox_ks",0.2);
}

//Function Number: 23
disable_clientfx()
{
	self setclutoverridedisableforplayer(0.5);
}

//Function Number: 24
enable_fx()
{
	playfxontag(level.killstreak_chest_fx,self,"j_spine4");
	playfxontag(level.killstreak_trail_fx,self,"tag_origin");
}

//Function Number: 25
disable_fx()
{
	stopfxontag(level.killstreak_trail_fx,self,"tag_origin");
	stopfxontag(level.killstreak_chest_fx,self,"j_spine4");
}

//Function Number: 26
aud_play_respawn_squish()
{
	wait(0.5);
	self playsound("ks_blackbox_spore_respawn");
}