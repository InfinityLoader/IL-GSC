/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _underwater.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 342 ms
 * Timestamp: 4/22/2024 2:23:33 AM
*******************************************************************/

//Function Number: 1
friendly_bubbles()
{
	self endon("death");
	self notify("stop_friendly_bubbles");
	self endon("stop_friendly_bubbles");
	thread friendly_bubbles_cleanup();
	thread friendly_bubbles_cleanup_on_death();
	var_00 = "TAG_EYE";
	self.scuba_org = common_scripts\utility::spawn_tag_origin();
	self.scuba_org linkto(self,"tag_eye",(5,0,-6),(-90,0,0));
	for(;;)
	{
		wait(3.5 + randomfloat(3));
		playfxontag(common_scripts\utility::getfx("scuba_bubbles_friendly"),self.scuba_org,"tag_origin");
	}
}

//Function Number: 2
friendly_bubbles_stop()
{
	self notify("stop_friendly_bubbles");
	self.scuba_org delete();
}

//Function Number: 3
friendly_bubbles_cleanup_on_death()
{
	common_scripts\utility::waittill_either("death","stop_friendly_bubbles");
	self.scuba_org delete();
}

//Function Number: 4
friendly_bubbles_cleanup()
{
	self endon("death");
	self waittillmatch("surfacing","single anim");
	self notify("stop_friendly_bubbles");
}

//Function Number: 5
underwater_hud_enable(param_00)
{
	wait(0.05);
	if(param_00 == 1)
	{
		setsaveddvar("hud_drawhud","1");
		setsaveddvar("hud_showStance","0");
		return;
	}

	setsaveddvar("hud_drawhud","1");
	setsaveddvar("hud_showStance","1");
}

//Function Number: 6
player_underwater_start(param_00)
{
	if(isdefined(param_00) && param_00 == 1)
	{
		self.scuba_assisted = 1;
		player_scuba();
		player_scuba_mask();
		return;
	}

	self.scuba_assisted = 0;
	player_underwater_breath();
}

//Function Number: 7
player_underwater_end()
{
	if(isdefined(self.scuba_assisted) && self.scuba_assisted == 1)
	{
		stop_player_scuba();
		player_scuba_mask_disable();
		return;
	}

	stop_player_underwater_breath();
}

//Function Number: 8
player_scuba()
{
	if(!issplitscreen())
	{
		thread player_scuba_breathe_sound();
	}
	else if(self == level.player)
	{
		thread player_scuba_breathe_sound();
	}

	thread player_scuba_bubbles();
}

//Function Number: 9
player_scuba_breathe_sound()
{
	self endon("death");
	self notify("start_scuba_breathe");
	self endon("start_scuba_breathe");
	self endon("stop_scuba_breathe");
	for(;;)
	{
		wait(0.05);
		self notify("scuba_breathe_sound_starting");
		if(self issprinting())
		{
			self playlocalsound("scuba_breathe_player_sprint","scuba_breathe_sound_done");
		}
		else
		{
			self playlocalsound("scuba_breathe_player","scuba_breathe_sound_done");
		}

		self waittill("scuba_breathe_sound_done");
	}
}

//Function Number: 10
stop_player_scuba()
{
	self notify("stop_scuba_breathe");
	self stoplocalsound("scuba_breathe_player");
}

//Function Number: 11
player_scuba_bubbles()
{
	if(getdvarint("demo_mode"))
	{
		return;
	}

	self endon("death");
	self endon("stop_scuba_breathe");
	waittillframeend;
	self.playerfxorg = spawn("script_model",self.origin + (0,0,0));
	self.playerfxorg setmodel("tag_origin");
	self.playerfxorg.angles = self.angles;
	self.playerfxorg.origin = self geteye() - (0,0,10);
	self.playerfxorg linktoplayerview(self,"tag_origin",(5,0,-55),(0,0,0),1);
	thread scuba_fx_cleanup(self.playerfxorg);
	for(;;)
	{
		self waittill("scuba_breathe_sound_starting");
		wait(2.1);
		thread player_bubbles_fx(self.playerfxorg);
		if(common_scripts\utility::cointoss())
		{
			self waittill("scuba_breathe_sound_starting");
		}
	}
}

//Function Number: 12
scuba_fx_cleanup(param_00)
{
	self waittill("stop_scuba_breathe");
	param_00 unlinkfromplayerview(self);
	param_00 delete();
}

//Function Number: 13
player_bubbles_fx(param_00)
{
	self endon("stop_scuba_breathe");
	playfxontag(common_scripts\utility::getfx("scuba_bubbles"),param_00,"TAG_ORIGIN");
}

//Function Number: 14
player_scuba_mask(param_00,param_01)
{
	if(getdvarint("sg_scuba_mask_off") == 1)
	{
		return;
	}

	if(getdvarint("demo_mode"))
	{
		return;
	}

	var_02 = "halo_overlay_scuba";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self.hud_scubamask = maps\_hud_util::create_client_overlay(var_02,1,self);
	self.hud_scubamask.foreground = 0;
	self.hud_scubamask.sort = -99;
	self.scubamask_distortion = spawn("script_model",level.player.origin);
	self.scubamask_distortion setmodel("tag_origin");
	self.scubamask_distortion.origin = self.origin;
	self.scubamask_distortion linktoplayerview(self,"tag_origin",(10,0,0),(0,180,0),1);
	playfxontag(common_scripts\utility::getfx("scuba_mask_distortion"),self.scubamask_distortion,"tag_origin");
	self.hud_scubamask_model = spawn("script_model",level.player geteye());
	self.hud_scubamask_model setmodel("shpg_udt_headgear_player_a");
	self.hud_scubamask_model linktoplayerview(self,"tag_origin",(-0.3,0,-1.2),(0,90,-4),1);
	if(getdvarint("demo_mode"))
	{
		self.hud_scubamask_model delete();
		stopfxontag(common_scripts\utility::getfx("scuba_mask_distortion"),self.scubamask_distortion,"tag_origin");
	}
}

//Function Number: 15
player_scuba_mask_disable(param_00)
{
	if(getdvarint("sg_scuba_mask_off") == 1)
	{
		return;
	}

	if(getdvarint("demo_mode"))
	{
		return;
	}

	if(isdefined(self.hud_scubamask))
	{
		self.hud_scubamask maps\_hud_util::destroyelem();
		self.scubamask_distortion unlinkfromplayerview(self);
		self.scubamask_distortion delete();
		self.hud_scubamask_model unlinkfromplayerview(self);
		self.hud_scubamask_model delete();
	}
}

//Function Number: 16
player_underwater_breath()
{
	set_default_breath_values();
	self.is_drowning = 0;
	thread handle_player_breath();
}

//Function Number: 17
stop_player_underwater_breath()
{
	self notify("stop_freeswim_breathe");
	self.is_drowning = 0;
}

//Function Number: 18
set_default_breath_values()
{
	if(!isdefined(level.player_breath_amount_use_rate))
	{
		level.player_breath_amount_use_rate = 6.666667;
	}

	if(!isdefined(level.player_breath_amount_fill_rate))
	{
		level.player_breath_amount_fill_rate = 50;
	}
}

//Function Number: 19
override_breath_values(param_00,param_01)
{
	level.player_breath_amount_use_rate = 100 / param_00;
	level.player_breath_amount_fill_rate = 100 / param_01;
}

//Function Number: 20
handle_player_breath()
{
	self endon("death");
	self notify("handle_player_breath");
	self endon("handle_player_breath");
	if(!isdefined(self.player_breath_amount))
	{
		self.player_breath_amount = 100;
	}

	var_00 = gettime();
	var_01 = var_00;
	self.player_breath_fulltime = 0;
	if(!isdefined(self.no_breath_hud) || !self.no_breath_hud)
	{
		thread player_breath_hud();
	}

	for(;;)
	{
		var_00 = gettime();
		var_02 = var_00 - var_01 / 1000;
		if(isdefined(self.underwater) && self.underwater)
		{
			self.player_breath_amount = max(self.player_breath_amount - level.player_breath_amount_use_rate * var_02,0);
		}
		else
		{
			self.player_breath_amount = min(self.player_breath_amount + level.player_breath_amount_fill_rate * var_02,100);
		}

		if(self.player_breath_amount <= 0)
		{
			thread player_drowning_damage_thread();
		}
		else
		{
			self notify("stop_drowning");
		}

		var_01 = var_00;
		if(self.player_breath_amount == 100)
		{
			self.player_breath_fulltime = self.player_breath_fulltime + 0.05;
		}
		else
		{
			self.player_breath_fulltime = 0;
		}

		if(self.player_breath_fulltime >= 1)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 21
player_breath_hud()
{
	self endon("death");
	self notify("player_breath_hud");
	self endon("player_breath_hud");
	var_00 = 0.5;
	var_01 = 100;
	if(!isdefined(level.player_breath_elem))
	{
		level.player_breath_elem = level.player maps\_hud_util::createclientprogressbar(level.player,60,"white","black",100,10);
		level.player_breath_elem maps\_hud_util::setpoint("RIGHT",undefined,-65,var_01 + 12);
		level.player_breath_elem maps\_hud_util::updatebar(1);
		level.player_breath_elem.alpha = var_00;
		level.player_breath_elem.bar.alpha = var_00;
		level.player_breath_elem.bar.color = (0,0,1);
		level.player_breath_elem.text = level.player maps\_hud_util::createclientfontstring("default",1.2);
		level.player_breath_elem.text maps\_hud_util::setpoint("RIGHT",undefined,-60,var_01);
		level.player_breath_elem.text settext("O2");
		level.player_breath_elem.text.alpha = var_00;
	}

	wait(0.05);
	while(self.player_breath_amount <= 100)
	{
		var_02 = self.player_breath_amount / 100;
		level.player_breath_elem maps\_hud_util::updatebar(var_02);
		if(self.player_breath_fulltime >= 1)
		{
			break;
		}

		level.player_breath_elem.alpha = var_00;
		level.player_breath_elem.bar.alpha = var_00;
		level.player_breath_elem.text.alpha = var_00;
		wait(0.05);
	}

	if(isdefined(level.player_breath_elem))
	{
		var_03 = gettime();
		var_04 = 500;
		while(gettime() - var_03 < var_04 && isdefined(level.player_breath_elem))
		{
			var_05 = 1 - float(gettime() - var_03) / var_04;
			level.player_breath_elem.alpha = var_00 * var_05;
			level.player_breath_elem.bar.alpha = var_00 * var_05;
			level.player_breath_elem.text.alpha = var_00 * var_05;
			wait(0.05);
		}

		level.player_breath_elem.text maps\_hud_util::destroyelem();
		level.player_breath_elem maps\_hud_util::destroyelem();
		level.player_breath_hud = undefined;
	}
}

//Function Number: 22
player_drowning_damage_thread()
{
	self endon("death");
	self endon("stop_freeswim_breathe");
	self endon("stop_drowning");
	if(self.is_drowning)
	{
		return;
	}

	self.is_drowning = 1;
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	soundscripts\_snd::snd_message("player_drowning_start");
	if(self == level.player && isdefined(self.drowning_warning))
	{
		thread maps\_utility_code::hintprint(self.drowning_warning,undefined,undefined,undefined,undefined,20,undefined,undefined);
		self.drowning_warning = undefined;
	}

	thread end_drowning_damage(var_00);
	for(;;)
	{
		if(isdefined(self.drowning_damage))
		{
			self dodamage(self.drowning_damage,self.origin);
		}
		else
		{
			self dodamage(25,self.origin);
		}

		playfxontag(common_scripts\utility::getfx("water_vm_gasping_breath"),var_00,"tag_origin");
		wait(0.5);
	}
}

//Function Number: 23
end_drowning_damage(param_00)
{
	self endon("death");
	self endon("stop_freeswim_breathe");
	self waittill("stop_drowning");
	param_00 delete();
	self.is_drowning = 0;
}

//Function Number: 24
parse_underwater_triggers()
{
	level.underwater_triggers = getentarray("trigger_underwater","targetname");
}