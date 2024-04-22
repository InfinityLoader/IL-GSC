/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_exo_punch_door.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 169 ms
 * Timestamp: 4/22/2024 2:34:38 AM
*******************************************************************/

//Function Number: 1
exo_door_init()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",4);
	setsaveddvar("r_hudoutlinecloaklumscale",0.5);
	setsaveddvar("r_hudoutlineAlpha0",1);
	setsaveddvar("r_hudoutlineAlpha1",0);
	setsaveddvar("r_hudoutlinecloakblurradius",0.45);
	setsaveddvar("r_hudoutlinecloakDarkenscale",1);
	setsaveddvar("r_hudoutlinecloaklumscale",1);
	setsaveddvar("r_hudoutlinehaloblurradius",1);
	setsaveddvar("r_hudoutlinehalodarkenscale",1);
	setsaveddvar("r_hudoutlinehaloLumscale",1);
	level.broken_door = 0;
	var_00 = [];
	var_01 = getentarray("door_exo_punch_intact","targetname");
	var_01 = common_scripts\utility::array_add(var_01,getent("door_exo_punch_intact","script_noteworthy"));
	var_00 = getscriptablearray("door_exo_punch_breakable","targetname");
	var_02 = getentarray("exo_punch_door_trigger","targetname");
	var_03 = getentarray("exo_punch_door_clip","targetname");
	var_04 = getentarray("exo_punch_door_usetrigger","targetname");
	foreach(var_06 in var_04)
	{
		var_06 sethintstring(&"RECOVERY_PROMPT_MELEE_BREACH");
	}

	if(common_scripts\utility::flag("training_round_2") == 0)
	{
		foreach(var_09 in var_01)
		{
			var_09.trig = common_scripts\utility::getclosest(var_09.origin,var_02,100);
			var_09.broken = common_scripts\utility::getclosest(var_09.origin,var_00,100);
			var_09.clip = common_scripts\utility::getclosest(var_09.origin,var_03,100);
			var_09.usetrig = common_scripts\utility::getclosest(var_09.origin,var_04,100);
			var_09.broken hide();
			var_09.clip notsolid();
			var_09.clip common_scripts\utility::delaycall(2,::connectpaths);
		}

		common_scripts\utility::array_thread(var_01,::common_scripts\utility::hide_notsolid);
		common_scripts\utility::flag_wait("training_round_2");
		common_scripts\utility::flag_wait("flag_obj_rescue2_living_room");
		foreach(var_09 in var_01)
		{
			var_09.clip solid();
			var_09.clip common_scripts\utility::delaycall(2,::disconnectpaths);
			var_09 thread monitor_door_punch();
			if(isdefined(var_09.usetrig))
			{
				var_09.button = var_09.usetrig maps\_shg_utility::hint_button_trigger("rs",300);
			}
		}

		common_scripts\utility::array_thread(var_01,::common_scripts\utility::show_solid);
	}
	else
	{
		common_scripts\utility::flag_wait("flag_obj_rescue2_living_room");
		foreach(var_09 in var_02)
		{
			var_09.trig = common_scripts\utility::getclosest(var_09.origin,var_02,100);
			var_09.broken = common_scripts\utility::getclosest(var_09.origin,var_00,100);
			var_09.clip = common_scripts\utility::getclosest(var_09.origin,var_03,100);
			var_09.usetrig = common_scripts\utility::getclosest(var_09.origin,var_04,100);
			var_09 thread monitor_door_punch();
			if(isdefined(var_09.usetrig))
			{
				var_09.button = var_09.usetrig maps\_shg_utility::hint_button_trigger("rs",300);
			}
		}
	}

	var_0F = getentarray("front_door_clip","targetname");
	common_scripts\utility::array_call(var_0F,::notsolid);
	var_10 = getentarray("front_door","targetname");
	foreach(var_09 in var_10)
	{
		var_09 common_scripts\utility::hide_notsolid();
	}

	foreach(var_14 in var_0F)
	{
		var_14 common_scripts\utility::delaycall(2,::connectpaths);
	}

	var_16 = getent("living_room_door_clip","targetname");
	var_16 notsolid();
	var_17 = getent("training_s1_flash_door","targetname");
	var_17 common_scripts\utility::hide_notsolid();
	var_16 common_scripts\utility::delaycall(2,::connectpaths);
	var_18 = getent("french_door_clip","targetname");
	var_18 notsolid();
	var_19 = getent("french_door","targetname");
	var_19 common_scripts\utility::hide_notsolid();
	var_18 common_scripts\utility::delaycall(2,::connectpaths);
	level.player thread monitor_last_weapon();
	edi_anims();
	common_scripts\utility::flag_wait("training_s2_gideon_smash_french_door");
	foreach(var_09 in var_01)
	{
		if(isdefined(var_09.script_noteworthy) && var_09.script_noteworthy == "door_exo_punch_intact")
		{
			if(level.broken_door == 0)
			{
				var_09.button thread maps\_shg_utility::hint_button_clear();
			}
		}
	}
}

//Function Number: 2
exo_door_logic()
{
}

//Function Number: 3
monitor_last_weapon()
{
	self endon("death");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(var_00 != "none" && isdefined(var_00))
		{
			self.old_weapon = var_00;
		}

		wait 0.05;
	}
}

//Function Number: 4
exo_punch_outline_think()
{
	self endon("death");
	self endon("exo_door_punched");
	thread exo_door_punch_cleanup();
	for(;;)
	{
		if(distance(self.origin,level.player.origin) < 350)
		{
			if(!target_istarget(self))
			{
				target_set(self);
				target_hidefromplayer(self,level.player);
			}

			if(target_istarget(self) && target_isincircle(self,level.player,65,120) && !isdefined(self.script_noteworthy))
			{
				self hudoutlineenable(6,1);
			}
			else if(!isdefined(self.script_noteworthy))
			{
				self hudoutlinedisable();
			}

			if(isdefined(self.script_noteworthy) && target_istarget(self) && target_isincircle(self,level.player,65,120) && common_scripts\utility::flag("training_s2_gideon_smash_french_door") == 0)
			{
				self hudoutlineenable(6,1);
			}
			else if(isdefined(self.script_noteworthy))
			{
				self hudoutlinedisable();
			}
		}
		else if(target_istarget(self))
		{
			target_remove(self);
		}

		wait 0.05;
	}
}

//Function Number: 5
exo_door_punch_cleanup()
{
	self waittill("exo_door_punched");
}

//Function Number: 6
monitor_door_punch()
{
	self.broken hide();
	self.clip disconnectpaths();
	for(;;)
	{
		self.trig waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_01 == level.player && var_04 == "MOD_MELEE_ALT" || var_04 == "MOD_MELEE")
		{
			if(isdefined(self.button))
			{
				self.button thread maps\_shg_utility::hint_button_clear();
			}

			if(self.trig.script_noteworthy == "kitchen")
			{
				maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"flag_vo_training_s2_joker_entering_kitchen");
			}

			if(self.trig.script_noteworthy == "living_room")
			{
				maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"flag_vo_training_s2_joker_living_room");
			}

			if(self.trig.script_noteworthy == "front_entrance")
			{
				maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"flag_vo_training_s2_joker_front_entrance");
			}

			level.player playrumbleonentity("light_1s");
			level.player switchtoweaponimmediate(level.player.old_weapon);
			self notify("exo_door_punched");
			self.direction = var_02;
			self.land_point = var_03;
			self.original_origin = self.origin;
			var_05 = common_scripts\utility::spawn_tag_origin();
			if(self.model == "rec_french_door_01_pristine_rig")
			{
				var_05.angles = self.angles + (0,90,0);
				playfxontag(common_scripts\utility::getfx("recovery_dust_burst_round_french"),var_05,"tag_origin");
				var_05 thread clear_door_effect();
			}
			else
			{
				playfxontag(common_scripts\utility::getfx("recovery_dust_burst_round_high"),var_05,"tag_origin");
				var_05 thread clear_door_effect();
			}

			break;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("training_s2_living_room_alert");
	var_06 = self.broken;
	var_06 show();
	self hide();
	self.origin = self.origin - (0,0,10000);
	self.clip.origin = self.clip.origin - (0,0,10000);
	self.clip connectpaths();
	exo_door_smash();
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "door_exo_punch_intact")
	{
		level.broken_door = 1;
	}
}

//Function Number: 7
clear_door_effect()
{
	wait(10);
	self delete();
}

//Function Number: 8
exo_door_smash()
{
	var_00 = self.direction;
	var_01 = self.broken;
	var_02 = (randomintrange(-5,5),randomintrange(-5,5),randomintrange(-10,10));
	var_01 setscriptablepartstate("root","destroyed");
	wait(0.1);
	physicsexplosionsphere(var_01.origin,100,5,10);
	level.player notify("exo_door_punched");
	var_03 = getaiarray("axis");
	foreach(var_05 in var_03)
	{
		var_05 thread monitor_door_impact(self);
		var_05 thread monitor_door_react(self);
	}
}

//Function Number: 9
monitor_door_impact(param_00)
{
	var_01 = param_00;
	self endon("death");
	var_01 endon("physics_finished");
	while(distance(self.origin,var_01.origin) > 80)
	{
		wait 0.05;
	}

	var_02 = vectornormalize(self gettagorigin("tag_eye") - param_00.original_origin);
	var_02 = vectornormalize(var_02 + (randomfloat(0.5),randomfloat(0.5),randomfloat(0.5)));
	self startragdollfromimpact("torso_lower",var_02 * randomintrange(2400,2800));
	thread common_scripts\utility::delaycall(2,::kill);
}

//Function Number: 10
monitor_door_react(param_00)
{
	var_01 = param_00;
	self endon("death");
	var_01 endon("physics_finished");
	while(distance(self.origin,var_01.origin) > 200)
	{
		wait 0.05;
	}

	maps\_utility::flashbangstart(randomfloatrange(1,4));
}

//Function Number: 11
edi_anims()
{
	level.scr_anim["generic"]["exo_punch_react_1"] = %corner_standr_flinchb;
	level.scr_anim["generic"]["exo_punch_react_2"] = %corner_standr_flinch;
	level.scr_anim["generic"]["exo_punch_react_3"] = %exposed_crouch_pain_flinch;
	level.scr_anim["generic"]["exo_punch_react_4"] = %ny_harbor_bulkhead_door_breach_stunned_guy2;
	level.door_punch_flinches = ["exo_punch_react_1","exo_punch_react_2","exo_punch_react_3","exo_punch_react_4"];
}