/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_threatdetection.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 599 ms
 * Timestamp: 10/27/2023 1:49:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._threatdetection = spawnstruct();
	level._threatdetection.default_style = "stencil_outline";
	level._threatdetection.activestyle = getdvar("threat_detection_highlight_style",level._threatdetection.default_style);
	level thread onplayerconnect();
	level thread watchagentspawn();
}

//Function Number: 2
changethreatstyle(param_00)
{
	if(param_00 == level._threatdetection.activestyle)
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(var_02._threatdetection.mark_enemy_model))
		{
			var_02._threatdetection.mark_enemy_model delete();
		}

		if(isdefined(var_02._threatdetection.mark_friendly_model))
		{
			var_02._threatdetection.mark_friendly_model delete();
		}

		if(isdefined(var_02.mark_fx) && isdefined(var_02.mark_fx.fx_ent))
		{
			foreach(var_04 in var_02.mark_fx.fx_ent)
			{
				if(isdefined(var_04.enemymarker))
				{
					var_04.enemymarker delete();
				}

				if(isdefined(var_04.friendlymarker))
				{
					var_04.friendlymarker delete();
				}

				if(isdefined(var_04.enemylosmarker))
				{
					var_04.enemylosmarker delete();
				}

				if(isdefined(var_04.friendlylosmarker))
				{
					var_04.friendlylosmarker delete();
				}
			}
		}
	}

	foreach(var_02 in level.players)
	{
		var_02 threat_init(param_00);
	}

	level._threatdetection.activestyle = param_00;
}

//Function Number: 3
getthreatstyle()
{
	var_00 = getdvar("threat_detection_highlight_style",level._threatdetection.default_style);
	if(var_00 != level._threatdetection.activestyle)
	{
		changethreatstyle(var_00);
	}

	return var_00;
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 5
watchagentspawn()
{
	for(;;)
	{
		level waittill("spawned_agent",var_00);
		var_00._threatdetection = spawnstruct();
		var_00._threatdetection.showlist = [];
		var_00 thread onagentspawned();
	}
}

//Function Number: 6
onagentspawned()
{
	self endon("death");
	childthread monitorthreathighlight();
	childthread cleanupondeath();
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	self._threatdetection = spawnstruct();
	self._threatdetection.showlist = [];
	self waittill("spawned_player");
	childthread monitorthreathighlight();
	childthread cleanupondeath();
	childthread monitorthreathighlightnotification();
	for(;;)
	{
		self waittill("spawned_player");
		var_00 = getthreatstyle();
		if(var_00 == "attached_glow")
		{
			visitfxent(::visitorrelink,::gethostilemarker,undefined);
		}
	}
}

//Function Number: 8
monitorthreathighlightnotification()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00 setshader("paint_overlay",640,480);
	var_00.alpha = 0;
	var_00.color = (0,0,0);
	var_00.sort = -3;
	var_00.hidden = 1;
	var_01 = 0.5;
	var_02 = 0.3;
	for(;;)
	{
		if(self._threatdetection.showlist.size != 0)
		{
			if(var_00.hidden)
			{
				var_00.hidden = 0;
				var_00 childthread threatnotificationoverlayflash(var_01,var_02);
			}
		}
		else if(!var_00.hidden)
		{
			var_00.hidden = 1;
			var_00 notify("stop_overlay_flash");
			if(var_00.alpha > 0)
			{
				var_00 fadeovertime(var_02);
				var_00.color = (0,0,0);
				var_00.alpha = 0;
				wait(var_02);
			}
		}

		wait(0.05);
	}
}

//Function Number: 9
threatnotificationoverlayflash(param_00,param_01)
{
	self endon("stop_overlay_flash");
	self fadeovertime(param_00);
	self.color = (1,1,1);
	self.alpha = 1;
}

//Function Number: 10
debughelper()
{
	for(;;)
	{
		var_00 = distance(self.origin,level.players[0].origin);
		thread common_scripts\utility::draw_line_for_time(level.players[0].origin,self.origin,1,1,1,0.3);
		if(isdefined(self._threatdetection.mark_enemy_model))
		{
			thread common_scripts\utility::draw_line_for_time(level.players[0].origin,self._threatdetection.mark_enemy_model.origin,1,1,1,0.3);
		}

		wait(0.3);
	}
}

//Function Number: 11
cleanupondeath()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		removethreatevents();
	}
}

//Function Number: 12
removethreatevents()
{
	foreach(var_01 in level.players)
	{
		foreach(var_03 in var_01._threatdetection.showlist)
		{
			if(var_03.player == self)
			{
				var_03.endtime = 0;
			}
		}
	}

	var_06 = getthreatstyle();
	if(var_06 == "attached_glow")
	{
		visitfxent(::visitorhideall,::gethostilemarker,undefined);
	}
}

//Function Number: 13
detection_highlight_hud_effect_on(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_03.color = (0.1,0.0015,0.0015);
	}
	else
	{
		var_03.color = (1,0.015,0.015);
	}

	var_03.alpha = 1;
	var_03 setradarhighlight(param_01);
	return var_03;
}

//Function Number: 14
detection_highlight_hud_effect_off(param_00)
{
	if(isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 15
detection_highlight_hud_effect(param_00,param_01,param_02,param_03)
{
	var_04 = detection_highlight_hud_effect_on(param_00,param_01,param_02);
	if(isdefined(param_03))
	{
		param_00 common_scripts\utility::waittill_notify_or_timeout(param_03,param_01);
	}
	else
	{
		wait(param_01);
	}

	detection_highlight_hud_effect_off(var_04);
}

//Function Number: 16
detection_grenade_hud_effect(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.x = param_01[0];
	var_04.y = param_01[1];
	var_04.z = param_01[2];
	var_04.color = (getdvarfloat("scr_paintexplosionred"),getdvarfloat("scr_paintexplosiongreen"),getdvarfloat("scr_paintexplosionblue"));
	var_04.alpha = getdvarfloat("scr_paintexplosionalpha");
	var_05 = getdvarint("paintexplosionwidth");
	var_04 setradarping(int(param_03 + var_05 / 2),int(var_05),param_02 + 0.05);
	wait(param_02);
	if(isdefined(var_04))
	{
		var_04 destroy();
	}
}

//Function Number: 17
exo_ping_hud_effect(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = newclienthudelem(param_03);
	}
	else
	{
		var_05 = newhudelem();
	}

	var_05.x = param_00[0];
	var_05.y = param_00[1];
	var_05.z = param_00[2];
	if(isdefined(param_04) && param_04)
	{
		var_05.color = (0.05,0.05,0.05);
	}
	else
	{
		var_05.color = (0.8,0.8,0.8);
	}

	var_05.alpha = 0.05;
	var_06 = getdvarint("scr_exopingwidth",100);
	var_05 setradarping(int(param_02),int(var_06),param_01 + 0.05);
	wait(param_01);
	if(isdefined(var_05))
	{
		var_05 destroy();
	}
}

//Function Number: 18
addthreatevent(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isalive(self))
	{
		return;
	}

	var_06 = gettime();
	var_07 = var_06 + param_01 * 1000;
	var_08 = var_07 - 9 * param_01 * 1000 / 10;
	var_09 = getthreatstyle();
	if(var_07 - var_08 < 250)
	{
		var_08 = 250 + var_06;
	}

	if(var_09 == "model")
	{
		var_08 = var_06;
	}
	else if(var_09 == "vfx_model")
	{
		var_08 = var_06;
	}
	else if(var_09 == "attached_glow")
	{
		var_08 = var_07;
	}
	else if(var_09 == "stencil_outline")
	{
		var_08 = var_07;
	}

	foreach(var_0B in param_00)
	{
		var_0C = 0;
		foreach(var_0E in self._threatdetection.showlist)
		{
			if(var_0E.player == var_0B)
			{
				if(var_07 > var_0E.endtime)
				{
					var_0E.endtime = var_07;
					var_0E.losendtime = var_08;
					var_0E.eventtype = param_02;
				}

				var_0C = 1;
				break;
			}
		}

		if(!var_0C)
		{
			var_10 = self._threatdetection.showlist.size;
			self._threatdetection.showlist[var_10] = spawnstruct();
			self._threatdetection.showlist[var_10].player = var_0B;
			self._threatdetection.showlist[var_10].endtime = var_07;
			self._threatdetection.showlist[var_10].losendtime = var_08;
			self._threatdetection.showlist[var_10].eventtype = param_02;
			if(isplayer(self))
			{
				if(!isdefined(param_05) || param_05)
				{
					self playlocalsound("flag_spawned");
				}
			}
		}
	}

	if(isplayer(self))
	{
		if(param_04)
		{
			visitfxent(::visitorupdatemarkerpos,::getfriendlymarker,undefined);
		}

		if(param_03)
		{
			visitfxent(::visitorupdatemarkerpos,::gethostilemarker,undefined);
		}
	}
}

//Function Number: 19
stopthreateventtype(param_00)
{
	foreach(var_02 in self._threatdetection.showlist)
	{
		if(var_02.eventtype == param_00)
		{
			var_02.endtime = 0;
		}
	}

	var_04 = getthreatstyle();
	if(var_04 == "attached_glow")
	{
		visitfxent(::visitorhideall,::gethostilemarker,undefined);
	}
}

//Function Number: 20
visitfxent(param_00,param_01,param_02)
{
	var_03 = getthreatstyle();
	if(var_03 == "glow")
	{
		foreach(var_06, var_05 in self.mark_fx.fx_ent)
		{
			[[ param_00 ]]([[ param_01 ]](var_05),param_02,level._threatdetection.fx_data[var_06][0]);
		}

		return;
	}

	if(var_03 == "model")
	{
		[[ param_00 ]]([[ param_01 ]](self._threatdetection),param_02,"tag_origin");
		return;
	}

	if(var_03 == "vfx_model")
	{
		[[ param_00 ]]([[ param_01 ]](self._threatdetection),param_02,"tag_origin");
		return;
	}

	if(var_03 == "attached_glow")
	{
		foreach(var_06, var_05 in self.mark_fx.fx_ent)
		{
			[[ param_00 ]]([[ param_01 ]](var_05),param_02,level._threatdetection.fx_data[var_06][0]);
		}

		return;
	}

	if(var_03 == "stencil_outline")
	{
		[[ param_00 ]](self,param_02,"tag_origin");
		return;
	}
}

//Function Number: 21
visitorrelink(param_00,param_01,param_02)
{
	param_00 unlink();
	param_00.origin = self gettagorigin(param_02);
	param_00.angles = self gettagangles(param_02);
	param_00 linkto(self,param_02);
	wait(0.05);
	playfxontag(param_00.fx,param_00,"tag_origin");
}

//Function Number: 22
visitorhideall(param_00,param_01,param_02)
{
	var_03 = getthreatstyle();
	if(var_03 == "attached_glow")
	{
		stopfxontag(param_00.fx,param_00,"tag_origin");
	}
}

//Function Number: 23
visitorupdatemarkerpos(param_00,param_01,param_02)
{
	var_03 = getthreatstyle();
	param_00.origin = self gettagorigin(param_02);
	param_00.angles = self gettagangles(param_02);
	if(var_03 == "glow")
	{
		triggerfx(param_00);
		return;
	}

	if(var_03 == "model")
	{
		var_04 = "mp_hud_" + self getstance() + "_char";
		var_05 = param_00 != self._threatdetection.mark_friendly_model;
		if(var_05)
		{
			var_04 = var_04 + "_hostile";
		}

		var_06 = param_00.model;
		if(var_04 != var_06)
		{
			param_00 setmodel(var_04);
			return;
		}

		return;
	}

	if(var_03 == "vfx_model")
	{
		switch(self getstance())
		{
			case "prone":
				break;

			case "crouch":
				break;

			case "stand":
			default:
				break;
		}
	}
}

//Function Number: 24
gethostilemarker(param_00)
{
	var_01 = getthreatstyle();
	if(var_01 == "glow")
	{
		return param_00.enemymarker;
	}

	if(var_01 == "model")
	{
		return param_00.mark_enemy_model;
	}

	if(var_01 == "vfx_model")
	{
		return param_00.mark_enemy_model;
	}

	if(var_01 == "attached_glow")
	{
		return param_00;
	}

	if(var_01 == "stencil_outline")
	{
		return param_00;
	}
}

//Function Number: 25
getfriendlymarker(param_00)
{
	var_01 = getthreatstyle();
	if(var_01 == "glow")
	{
		return param_00.friendlymarker;
	}

	if(var_01 == "model")
	{
		return param_00.mark_friendly_model;
	}

	if(var_01 == "vfx_model")
	{
		return param_00.mark_friendly_model;
	}
}

//Function Number: 26
getfriendlylosmarker(param_00)
{
	var_01 = getthreatstyle();
	if(var_01 == "glow")
	{
		return param_00.friendlylosmarker;
	}

	if(var_01 == "model")
	{
		return param_00.mark_friendly_model;
	}

	if(var_01 == "vfx_model")
	{
		return param_00.mark_friendly_model;
	}
}

//Function Number: 27
gethostilelosmarker(param_00)
{
	var_01 = getthreatstyle();
	if(var_01 == "glow")
	{
		return param_00.enemylosmarker;
	}

	if(var_01 == "model")
	{
		return param_00.mark_enemy_model;
	}

	if(var_01 == "vfx_model")
	{
		return param_00.mark_enemy_model;
	}

	if(var_01 == "attached_glow")
	{
		return param_00;
	}

	if(var_01 == "stencil_outline")
	{
		return param_00;
	}
}

//Function Number: 28
visithideallmarkers(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		var_04 hide();
	}
}

//Function Number: 29
accessallmarkers(param_00)
{
	return [param_00.friendlymarker,param_00.enemymarker,param_00.friendlylosmarker,param_00.enemylosmarker];
}

//Function Number: 30
getnormaldirectionvec(param_00)
{
	return vectornormalize(common_scripts\utility::flat_origin(param_00));
}

//Function Number: 31
monitorthreathighlight()
{
	threat_init(getthreatstyle());
	var_00 = (0,0,32);
	var_01 = 0;
	for(;;)
	{
		wait(0.05);
		var_02 = gettime();
		var_03 = 0;
		foreach(var_05 in self._threatdetection.showlist)
		{
			if(var_05.endtime >= var_02)
			{
				if(!isdefined(var_05.player))
				{
					self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist,var_05);
					continue;
				}

				var_05.los = 0;
				var_06 = getnormaldirectionvec(anglestoforward(var_05.player.angles));
				var_07 = getnormaldirectionvec(self.origin - var_05.player.origin);
				var_08 = vectordot(var_07,var_06);
				if(var_08 < 0)
				{
					continue;
				}

				if(check_los(var_05))
				{
					var_05.los = 1;
					if(var_05.losendtime <= var_02)
					{
						self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist,var_05);
						continue;
					}
				}

				var_03 = 1;
				continue;
			}

			self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist,var_05);
		}

		var_0A = getthreatstyle();
		if(!var_01)
		{
			var_01 = 1;
			if(var_0A == "glow")
			{
				foreach(var_0C in self.mark_fx.fx_ent)
				{
					var_0C.enemymarker hide();
					var_0C.friendlymarker hide();
					var_0C.enemylosmarker hide();
					var_0C.friendlylosmarker hide();
				}
			}
			else if(var_0A == "model")
			{
				self._threatdetection.mark_friendly_model hide();
				self._threatdetection.mark_enemy_model hide();
			}
			else if(var_0A == "vfx_model")
			{
				self._threatdetection.mark_friendly_model hide();
				self._threatdetection.mark_enemy_model hide();
			}
			else if(var_0A == "attached_glow")
			{
				foreach(var_05 in self.mark_fx.fx_ent)
				{
					stopfxontag(var_05.fx,var_05,"tag_origin");
					var_05 hide();
				}
			}
			else if(var_0A == "stencil_outline")
			{
				self clearthreatdetected();
			}
			else
			{
			}
		}

		if(!var_03)
		{
			continue;
		}

		foreach(var_10 in self._threatdetection.showlist)
		{
			if(var_10.los)
			{
				showthreat(var_10.player,::getfriendlylosmarker,::gethostilelosmarker,::visitorupdatelosmarker);
				prepare_show_threat(var_01,var_0A,var_10.player);
				var_01 = 0;
				continue;
			}

			var_11 = bullettrace(var_10.player.origin + var_00,self.origin + var_00,1,var_10.player);
			if(var_11["fraction"] < 1 && !isplayer(var_11["entity"]))
			{
				showthreat(var_10.player,::getfriendlymarker,::gethostilemarker,::visitorshowtoplayer);
				prepare_show_threat(var_01,var_0A,var_10.player);
				var_01 = 0;
			}
		}
	}
}

//Function Number: 32
prepare_show_threat(param_00,param_01,param_02)
{
	if(param_00)
	{
		if(param_01 == "attached_glow")
		{
			showthreat(param_02,::getfriendlylosmarker,::gethostilelosmarker,::visitorretriggerfx);
		}
	}
}

//Function Number: 33
visitorretriggerfx(param_00,param_01,param_02)
{
	playfxontag(param_00.fx,param_00,"tag_origin");
}

//Function Number: 34
check_los(param_00)
{
	if(bullettracepassed(param_00.player geteye(),self geteye(),0,param_00.player))
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
threat_init(param_00)
{
	var_01 = spawnstruct();
	var_01.fx_ent = [];
	if(param_00 == "glow")
	{
		foreach(var_05, var_03 in level._threatdetection.fx_data)
		{
			var_04 = spawnstruct();
			var_04.origin = self gettagorigin(var_03[0]);
			var_04.angles = self gettagangles(var_03[0]);
			var_04.enemymarker = spawnfx(var_03[1],var_04.origin);
			triggerfx(var_04.enemymarker);
			var_04.enemymarker hide();
			var_04.enemylosmarker = spawnfx(var_03[3],var_04.origin);
			triggerfx(var_04.enemylosmarker);
			var_04.enemylosmarker hide();
			var_04.friendlymarker = spawnfx(var_03[2],var_04.origin);
			triggerfx(var_04.friendlymarker);
			var_04.friendlymarker hide();
			var_04.friendlylosmarker = spawnfx(var_03[4],var_04.origin);
			triggerfx(var_04.friendlylosmarker);
			var_04.friendlylosmarker hide();
			var_01.fx_ent[var_05] = var_04;
		}

		self.mark_fx = var_01;
		return;
	}

	if(param_00 == "model")
	{
		var_06 = spawn("script_model",self.origin);
		var_06.origin = self.origin;
		var_06.angles = self.angles;
		var_06 setmodel(level._threatdetection.friendlymodel);
		var_06 setcontents(0);
		self._threatdetection.mark_friendly_model = var_06;
		var_06 = spawn("script_model",self.origin);
		var_06.origin = self.origin;
		var_06.angles = self.angles;
		var_06 setmodel(level._threatdetection.hostilemodel);
		var_06 setcontents(0);
		self._threatdetection.mark_enemy_model = var_06;
		return;
	}

	if(param_00 == "vfx_model")
	{
		self._threatdetection.mark_friendly_model = spawnstruct();
		self._threatdetection.mark_friendly_model = spawnfx(common_scripts\utility::getfx("threat_detect_model_stand"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
		self._threatdetection.friendly_pose = "threat_detect_model_stand";
		self._threatdetection.mark_enemy_model = spawnstruct();
		self._threatdetection.mark_enemy_model = spawnfx(common_scripts\utility::getfx("threat_detect_model_stand_hostile"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
		self._threatdetection.hostile_pose = "threat_detect_model_stand_hostile";
		return;
	}

	if(param_00 == "attached_glow")
	{
		foreach(var_05, var_03 in level._threatdetection.fx_data)
		{
			var_08 = common_scripts\utility::spawn_tag_origin();
			var_08 show();
			var_08.origin = self gettagorigin(var_03[0]);
			var_08.angles = self gettagangles(var_03[0]);
			var_08 linkto(self,var_03[0]);
			var_08.fx = var_03[1];
			var_01.fx_ent[var_05] = var_08;
		}

		self.mark_fx = var_01;
		return;
	}

	if(param_00 == "stencil_outline")
	{
		return;
	}
}

//Function Number: 36
visitorupdatelosmarker(param_00,param_01,param_02)
{
	visitorupdatemarkerpos(param_00,param_01,param_02);
	visitorshowtoplayer(param_00,param_01,param_02);
}

//Function Number: 37
visitorshowtoplayer(param_00,param_01,param_02)
{
	var_03 = getthreatstyle();
	if(var_03 == "stencil_outline")
	{
		param_00 threatdetectedtoplayer(param_01);
		return;
	}

	param_00 showtoplayer(param_01);
}

//Function Number: 38
showthreat(param_00,param_01,param_02,param_03)
{
	if(param_00 == self)
	{
		return;
	}

	var_04 = param_02;
	if((level.teambased || level.multiteambased) && param_00.team == self.team)
	{
		var_04 = param_01;
	}
	else if(param_00 == self)
	{
		var_04 = param_01;
	}

	visitfxent(param_03,var_04,param_00);
}