/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _dshk_player.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 264 ms
 * Timestamp: 4/22/2024 2:20:48 AM
*******************************************************************/

//Function Number: 1
init_dshk_player()
{
	common_scripts\utility::flag_init("player_dismounting_turret");
	common_scripts\utility::flag_init("player_on_dshk_turret");
	dshk_player_anims();
}

//Function Number: 2
init_dshk_turret_processing()
{
	level.player.dshk_turrets = [];
	level.player thread player_process_dshk_turrets();
}

//Function Number: 3
player_process_dshk_turrets()
{
	self.mount_hint = maps\_hud_util::createfontstring("default",1.5);
	self.mount_hint.alpha = 0.9;
	self.mount_hint.x = 0;
	self.mount_hint.y = 50;
	self.mount_hint.alignx = "center";
	self.mount_hint.aligny = "middle";
	self.mount_hint.horzalign = "center";
	self.mount_hint.vertalign = "middle";
	self.mount_hint.foreground = 0;
	self.mount_hint.hidewhendead = 1;
	self.mount_hint.hidewheninmenu = 1;
	for(;;)
	{
		var_00 = 0;
		if(!common_scripts\utility::flag("player_on_dshk_turret"))
		{
			for(var_01 = 0;var_01 < self.dshk_turrets.size;var_01++)
			{
				if(self istouching(self.dshk_turrets[var_01]))
				{
					if(self usebuttonpressed())
					{
						self.dshk_turrets[var_01] notify("mounted");
					}
					else
					{
						var_00 = 1;
					}

					break;
				}
			}
		}

		if(var_00)
		{
			self.mount_hint settext(&"PLATFORM_HOLD_TO_USE");
		}
		else
		{
			self.mount_hint settext("");
		}

		wait(0.2);
	}

	self.mount_hint destroy();
}

//Function Number: 4
player_add_dshk_turret(param_00)
{
	self.dshk_turrets[self.dshk_turrets.size] = param_00;
	param_00 endon("death");
}

//Function Number: 5
player_remove_dshk_turret(param_00)
{
	self.dshk_turrets = common_scripts\utility::array_remove(self.dshk_turrets,param_00);
}

//Function Number: 6
dshk_player_anims()
{
	level.scr_animtree["dshk_turret"] = #animtree;
	level.scr_animtree["turret_player_rig"] = #animtree;
	level.scr_model["turret_player_rig"] = level.dshk_viewmodel;
	level.scr_anim["turret_player_rig"]["turret_hands_geton"] = %dshk_player_dshk_geton;
	level.scr_anim["dshk_turret"]["turret_hands_getoff"] = %dshk_player_dshk_getoff;
	level.scr_anim["dshk_turret"]["turret_hands_idle"] = %dshk_player_dshk_idle;
	level.scr_anim["dshk_turret"]["turret_hands_fire"] = %dshk_player_dshk_fire;
	level.scr_anim["dshk_turret"]["turret_hands_idle2fire"] = %dshk_player_dshk_idle_to_fire;
	level.scr_anim["dshk_turret"]["turret_hands_fire2idle"] = %dshk_player_dshk_fire_to_idle;
	level.scr_anim["dshk_turret"]["turret_gun_geton"] = %dshk_geton;
	level.scr_anim["dshk_turret"]["turret_gun_getoff"] = %dshk_getoff;
	level.scr_anim["dshk_turret"]["turret_gun_idle"] = %dshk_idle;
	level.scr_anim["dshk_turret"]["turret_gun_fire"] = %dshk_fire;
	level.scr_anim["dshk_turret"]["turret_gun_idle2fire"] = %dshk_idle_to_fire;
	level.scr_anim["dshk_turret"]["turret_gun_fire2idle"] = %dshk_fire_to_idle;
}

//Function Number: 7
dshk_turret_init(param_00)
{
	if(!isdefined(level.player.dshk_turrets))
	{
		init_dshk_turret_processing();
	}

	var_01 = self;
	var_01 endon("death");
	var_01 makeunusable();
	var_01 setdefaultdroppitch(0);
	var_01.setturretusable = 1;
	var_02 = get_world_relative_offset(var_01.origin,var_01.angles,(-32,0,-48));
	var_01.usable_turret_trigger = spawn("trigger_radius",var_02,0,30,128);
	level.player player_add_dshk_turret(var_01.usable_turret_trigger);
	while(var_01.setturretusable == 1)
	{
		var_01.usable_turret_trigger waittill("mounted");
		var_01 thread player_use_dshk_with_viewmodel(var_01,level.player,param_00);
		level.player custom_dismount_hint_return_when_dismounted();
		handle_dismount();
	}

	level.player player_remove_dshk_turret(var_01.usable_turret_trigger);
	var_01.usable_turret_trigger delete();
}

//Function Number: 8
custom_dismount_hint_return_when_dismounted()
{
	self.disomount_hint = maps\_hud_util::createfontstring("default",1.5);
	self.disomount_hint.alpha = 0.9;
	self.disomount_hint.x = 0;
	self.disomount_hint.y = 50;
	self.disomount_hint.alignx = "center";
	self.disomount_hint.aligny = "middle";
	self.disomount_hint.horzalign = "center";
	self.disomount_hint.vertalign = "middle";
	self.disomount_hint.foreground = 0;
	self.disomount_hint.hidewhendead = 1;
	self.disomount_hint.hidewheninmenu = 1;
	self.disomount_hint settext(&"PLATFORM_HOLD_TO_DROP");
	notifyoncommand("turret_dismount","+usereload");
	notifyoncommand("turret_dismount","+activate");
	level.player waittill("turret_dismount");
	self.disomount_hint destroy();
}

//Function Number: 9
handle_dismount()
{
	if(!common_scripts\utility::flag("player_dismounting_turret"))
	{
		common_scripts\utility::flag_set("player_dismounting_turret");
		level.player freezecontrols(1);
		self.animname = "dshk_turret";
		self notify("player_dismount");
		maps\_anim::setanimtree();
		var_00 = self gettagangles("tag_ground");
		var_01 = getanimlength(%dshk_player_dshk_getoff);
		var_02 = maps\_utility::getanim("turret_hands_getoff");
		var_03 = maps\_utility::getanim("turret_gun_getoff");
		self clearanim(%root,0);
		self setanim(var_02,1,0,1);
		self setanim(var_03,1,0,1);
		wait(var_01);
		self detachall();
		self makeusable();
		self setturretdismountorg(self gettagorigin("tag_ground"));
		level.player enableturretdismount();
		self useby(level.player);
		self makeunusable();
		var_04 = 0.15;
		level.player lerpfov(65,var_04);
		var_05 = spawn("script_origin",(0,0,0));
		var_05.origin = self gettagorigin("tag_ground");
		var_05.angles = var_00;
		level.player playerlinkto(var_05,"",1,0,0,0,0,0);
		var_05 moveto(self.mount_pos,var_04,var_04 * 0.25);
		wait(var_04 + 0.1);
		var_05 delete();
		if(isdefined(self.disomount_hint))
		{
			self.disomount_hint destroy();
		}

		if(isdefined(self.player_rig))
		{
			self.player_rig delete();
		}

		level.player enableweapons();
		level.player freezecontrols(0);
		common_scripts\utility::flag_clear("player_on_dshk_turret");
		common_scripts\utility::flag_clear("player_dismounting_turret");
	}
}

//Function Number: 10
player_use_dshk_with_viewmodel(param_00,param_01,param_02)
{
	common_scripts\utility::flag_set("player_on_dshk_turret");
	param_00 endon("player_dismount");
	param_00.animname = "dshk_turret";
	param_00 maps\_anim::setanimtree();
	param_01 freezecontrols(1);
	param_01 disableweapons();
	level.player setstance("stand");
	self.mount_pos = param_01.origin;
	param_00.player_rig = maps\_utility::spawn_anim_model("turret_player_rig");
	param_00.player_rig.animname = "turret_player_rig";
	param_00.player_rig linkto(param_00,"tag_ground",(0,0,0),(0,0,0));
	param_00.player_rig hide();
	param_00.player_rig common_scripts\utility::delaycall(0.25,::show);
	param_00 maps\_anim::anim_first_frame_solo(param_00.player_rig,"turret_hands_geton","tag_player");
	maps\_anim::anim_first_frame_solo(param_00,"turret_gun_geton");
	param_01 playerlinktoblend(param_00.player_rig,"tag_origin",0.3,0.1,0.1);
	wait(0.2);
	var_03 = getanimlength(%dshk_player_dshk_geton);
	var_04 = param_00.player_rig maps\_utility::getanim("turret_hands_geton");
	var_05 = maps\_utility::getanim("turret_gun_geton");
	param_00 clearanim(%root,0);
	param_00 setanim(var_05,1,0,1);
	thread notifyaftertime("geton_anim_finished","time is up",var_03);
	wait(0.1);
	param_00.player_rig setanim(var_04,1,0,1);
	var_06 = param_00 getanimtime(var_05);
	param_00.player_rig setanimtime(var_04,var_06);
	param_01 lerpfov(55,0.2);
	self waittill("geton_anim_finished");
	if(isdefined(param_02) && param_02 == 1)
	{
		thread dshk_shells(level.dshk_shelleject_fx,"player_dismounting_turret");
	}

	param_01 playerlinktodelta(self,"tag_player",0.35,90,90,45,30,1);
	param_00.player_rig delete();
	param_00.viewhands = level.scr_model["turret_player_rig"];
	param_00 attach(param_00.viewhands,"tag_ground");
	thread cleanup_on_death();
	param_00.is_occupied = 1;
	param_00 makeusable();
	param_00 setmode("manual");
	param_01 unlink();
	param_00 useby(param_01);
	param_00 makeunusable();
	param_01 disableturretdismount();
	var_07 = maps\_utility::getanim("turret_hands_idle");
	param_00 clearanim(var_04,0.1);
	param_00 setanim(var_07,1,0.1,1);
	param_00.hands_animation = var_07;
	var_08 = param_00 maps\_utility::getanim("turret_gun_idle");
	param_00 clearanim(var_05,0.1);
	param_00 setanim(var_08,1,0.1,1);
	param_00.gun_animation = var_08;
	var_09 = 0;
	var_0A = 0;
	while(common_scripts\utility::flag("player_on_dshk_turret"))
	{
		var_09 = level.player attackbuttonpressed();
		if(var_0A != var_09)
		{
			if(var_09)
			{
				param_00 thread animate_turret_with_viewmodel("turret_hands_idle2fire","turret_hands_fire","turret_gun_idle2fire","turret_gun_fire");
			}
			else
			{
				param_00 thread animate_turret_with_viewmodel("turret_hands_fire2idle","turret_hands_idle","turret_gun_fire2idle","turret_gun_idle");
			}

			var_0A = var_09;
		}

		wait(0.05);
	}
}

//Function Number: 11
animate_turret_with_viewmodel(param_00,param_01,param_02,param_03)
{
	self notify("turret_anim_change");
	self endon("turret_anim_change");
	self endon("player_dismount");
	var_04 = maps\_utility::getanim(param_00);
	var_05 = maps\_utility::getanim(param_01);
	var_06 = maps\_utility::getanim(param_02);
	var_07 = maps\_utility::getanim(param_03);
	self clearanim(self.hands_animation,0);
	self.hands_animation = var_04;
	self clearanim(self.gun_animation,0);
	self.gun_animation = var_06;
	self setanim(var_06,1,0.1,1);
	self setflaggedanim(param_00,var_04,1,0.1,1);
	self waittillmatch("end",param_00);
	self clearanim(var_04,0);
	self clearanim(var_06,0);
	self.hands_animation = var_05;
	self.gun_animation = var_07;
	self setanim(var_05,1,0.1,1);
	self setanim(var_07,1,0.1,1);
}

//Function Number: 12
cleanup_on_death()
{
	level.player endon("death");
	level.player waittill("death");
	level.player unlink();
	level.player lerpfov(65,0.1);
}

//Function Number: 13
dshk_shells(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	var_02 = common_scripts\utility::getfx(param_00);
	var_03 = "tag_brass";
	var_04 = 0.1;
	common_scripts\utility::flag_wait("player_on_dshk_turret");
	while(common_scripts\utility::flag("player_on_dshk_turret"))
	{
		while(level.player attackbuttonpressed())
		{
			playfxontag(var_02,self,var_03);
			wait(var_04);
		}

		wait(0.05);
	}
}

//Function Number: 14
dshk_turret_disable(param_00)
{
	if(common_scripts\utility::flag("player_on_dshk_turret"))
	{
		self notify("turret_dismount");
		param_00.setturretusable = 0;
	}
	else
	{
		param_00 notify("disable_player_turret");
	}

	if(isdefined(param_00.usable_turret_trigger))
	{
		param_00.usable_turret_trigger delete();
	}

	if(isdefined(param_00.mount_hint))
	{
		param_00.mount_hint destroy();
	}
}

//Function Number: 15
notifyaftertime(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 16
get_world_relative_offset(param_00,param_01,param_02)
{
	var_03 = cos(param_01[1]);
	var_04 = sin(param_01[1]);
	var_05 = param_02[0] * var_03 - param_02[1] * var_04;
	var_06 = param_02[0] * var_04 + param_02[1] * var_03;
	var_05 = var_05 + param_00[0];
	var_06 = var_06 + param_00[1];
	return (var_05,var_06,param_00[2] + param_02[2]);
}