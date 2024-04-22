/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _sonicaoe.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 231 ms
 * Timestamp: 4/22/2024 2:22:47 AM
*******************************************************************/

//Function Number: 1
initsonicaoe()
{
	if(!isdefined(level.sonicaoeready))
	{
		precacherumble("damage_heavy");
		precacheshader("dpad_icon_sonic_blast");
		precacheshader("dpad_icon_sonic_blast_off");
		precachestring(&"SONICAOE_READY");
		precachestring(&"SONICAOE_NOTREADY");
		maps\_utility::add_hint_string("Sonic_AOE_Ready",&"SONICAOE_READY",::_sonicaoenotready);
		maps\_utility::add_hint_string("Sonic_AOE_NotReady",&"SONICAOE_NOTREADY");
		level._effect["sonic_blast"] = loadfx("vfx/map/greece/greece_sonic_charge_burst");
		level.sonicaoeready = 0;
		level.sonicaoeactive = 0;
	}
}

//Function Number: 2
enablesonicaoe(param_00)
{
	level notify("DisableSonicAoE");
	level endon("DisableSonicAoE");
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	level.player notifyonplayercommand("flash_aoe","+actionslot " + param_00);
	for(;;)
	{
		var_01 = 0;
		update_sonic_aoe_icon();
		level.sonicaoeready = 1;
		while(!var_01)
		{
			level.player waittill("flash_aoe");
			var_01 = maps\_player_exo::batteryspend(1);
			if(!var_01)
			{
				wait(0.5);
			}
		}

		level.player setviewkickscale(0.45);
		level.player setweaponhudiconoverride("actionslot" + param_00,"dpad_icon_sonic_blast_off");
		soundscripts\_snd::snd_message("start_sonic_attack_mix");
		level notify("SonicAoEStarted");
		soundscripts\_snd::snd_message("sonic_blast");
		level.sonicaoeactive = 1;
		earthquake(0.65,0.6,level.player.origin,128);
		physicsexplosionsphere(level.player.origin,512,512,1);
		level.player playrumbleonentity("damage_heavy");
		level.player thread _stunassaultdrones();
		for(var_02 = 0;var_02 < 7;var_02++)
		{
			earthquake(0.25,0.3,level.player.origin,128);
			var_03 = level.player.origin + (0,0,24) + anglestoforward(level.player.angles) * 64;
			playfx(level._effect["sonic_blast"],var_03,anglestoforward(level.player.angles),anglestoup(level.player.angles));
			soundscripts\_snd::snd_message("sonic_blast_aftershock");
			glassradiusdamage(level.player.origin,512,100,100);
			var_04 = getentarray("SonicAoECanDamage","script_noteworthy");
			var_05 = maps\_utility::get_within_range(level.player.origin,var_04,512);
			foreach(var_07 in var_05)
			{
				var_07 notify("SonicAoEDamage");
			}

			var_09 = [];
			var_09 = getaiarray("axis","neutral");
			var_0A = common_scripts\utility::get_array_of_closest(level.player.origin,var_09,undefined,undefined,512,0);
			if(var_0A.size > 0)
			{
				foreach(var_0C in var_0A)
				{
					if(!isdefined(var_0C))
					{
						continue;
					}

					if(!isalive(var_0C))
					{
						continue;
					}

					if(isdefined(var_0C.ignoresonicaoe))
					{
						continue;
					}

					if(!isdefined(var_0C.isinsonicstun))
					{
						var_0C thread track_loud_enough_achievement();
					}

					var_0D = var_0C get_stun_thread_for_ai();
					if(isdefined(var_0D))
					{
						var_0C thread [[ var_0D ]]();
					}

					wait(randomfloatrange(0.05,0.09));
				}
			}

			wait(randomfloatrange(1,1.25));
		}

		soundscripts\_snd::snd_message("sonic_blast_done");
		level.player setviewkickscale(1);
		level.sonicaoeactive = 0;
		level.sonicaoeready = 0;
		wait(0.5);
	}
}

//Function Number: 3
track_loud_enough_achievement()
{
	if(!isdefined(self.isinsonicstun))
	{
		self.isinsonicstun = 1;
	}

	wait(4);
	self.isinsonicstun = undefined;
}

//Function Number: 4
get_stun_thread_for_ai()
{
	if(isdefined(self.sonic_aoe_thread))
	{
		return self.sonic_aoe_thread;
	}
	else if(self.team == "axis")
	{
		return ::_stunenemies;
	}

	return ::_stuncivilians;
}

//Function Number: 5
_stunenemies()
{
	var_00 = common_scripts\utility::isflashed();
	if(!var_00)
	{
		if(isdefined(self.sonic_stop_scripted_anim))
		{
			self stopanimscripted();
		}

		maps\_utility::flashbangstart(4);
	}
}

//Function Number: 6
_stuncivilians()
{
	self endon("death");
	self.iscivilianflashed = 1;
	self stopanimscripted();
	wait(randomfloatrange(0.1,0.2));
	thread _findfleelocation();
}

//Function Number: 7
_findfleelocation()
{
	self endon("death");
	var_00 = getnodesinradiussorted(self.origin,256,128,32);
	foreach(var_02 in var_00)
	{
		if(maps\_utility::players_within_distance(256,var_02.origin))
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_02);
		}
	}

	var_04 = var_00[var_00.size - 1];
	if(isdefined(var_04))
	{
		maps\_utility::set_goal_node(var_04);
		self waittill("goal");
	}
}

//Function Number: 8
_stunassaultdrones()
{
	level notify("_StunAssaultDrones");
	level endon("_StunAssaultDrones");
	self endon("death");
	while(level.sonicaoeactive)
	{
		wait(0.05);
		if(!isdefined(level.flying_attack_drones) || level.flying_attack_drones.size == 0)
		{
			continue;
		}

		foreach(var_01 in level.flying_attack_drones)
		{
			if(!isdefined(var_01) || distance2dsquared(var_01.origin,level.player.origin) > squared(1024))
			{
				continue;
			}

			var_01 notify("stun_drone");
		}
	}
}

//Function Number: 9
_sonicaoeanim()
{
	level.player disableweapons();
	level.player waittill("weapon_change");
	var_00 = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	level.player maps\_anim::anim_single_solo(var_00,"SonicAoE_On");
	level.player enableweapons();
	var_00 unlink();
	var_00 delete();
}

//Function Number: 10
displaysonicaoecontextualhints()
{
	thread _displayhelpertext();
	thread _displayrechargehelpertext();
}

//Function Number: 11
_displayhelpertext()
{
	level endon("DisableSonicAoE");
	level endon("DisableSonicAoEHints");
	for(;;)
	{
		wait(0.05);
		wait(30);
		if(level.sonicaoeready == 0 || level.sonicaoeactive == 1)
		{
			continue;
		}

		var_00 = getaiarray("axis");
		var_00 = maps\_utility::array_removedead_or_dying(var_00);
		if(isdefined(level.flying_attack_drones) && level.flying_attack_drones.size > 0)
		{
			var_00 = maps\_utility::array_merge(var_00,level.flying_attack_drones);
		}

		var_01 = common_scripts\utility::getclosest(level.player.origin,var_00,512);
		if(isdefined(var_01))
		{
			maps\_utility::display_hint_timeout("Sonic_AOE_Ready",10,undefined,undefined,undefined,200);
		}
	}
}

//Function Number: 12
_sonicaoenotready()
{
	return level.sonicaoeactive;
}

//Function Number: 13
_displayrechargehelpertext()
{
	level endon("DisableSonicAoE");
	level endon("DisableSonicAoEHints");
	for(;;)
	{
		level.player waittill("flash_aoe");
		if(level.sonicaoeready == 0)
		{
			maps\_utility::display_hint("Sonic_AOE_NotReady",undefined,undefined,undefined,200);
		}

		wait(0.05);
	}
}

//Function Number: 14
disablesonicaoe(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	level notify("DisableSonicAoE");
	if(param_01 == 1)
	{
		level.player setweaponhudiconoverride("actionslot" + param_00,"dpad_icon_sonic_blast_off");
		return;
	}

	level.player setweaponhudiconoverride("actionslot" + param_00,"dpad_icon_sonic_blast_off");
}

//Function Number: 15
update_sonic_aoe_icon(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 2;
	}

	if(!maps\_player_exo::player_exo_is_active())
	{
		level.player setweaponhudiconoverride("actionslot" + param_00,"none");
		return;
	}

	if(maps\_player_exo::get_exo_battery_percent() > 0)
	{
		level.player setweaponhudiconoverride("actionslot" + param_00,"dpad_icon_sonic_blast");
		return;
	}

	level.player setweaponhudiconoverride("actionslot" + param_00,"dpad_icon_sonic_blast_off");
}