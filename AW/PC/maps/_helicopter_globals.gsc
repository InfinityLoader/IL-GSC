/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _helicopter_globals.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 314 ms
 * Timestamp: 4/22/2024 2:21:20 AM
*******************************************************************/

//Function Number: 1
init_helicopters()
{
	level.helicopter_firelinkfunk = ::heli_firelink;
	level.chopperturretonfunc = ::chopper_turret_on;
	level.chopperturretofffunc = ::chopper_turret_off;
}

//Function Number: 2
chopper_turret_off()
{
	self notify("mg_off");
}

//Function Number: 3
chopper_turret_on()
{
	self endon("death");
	self endon("mg_off");
	var_00 = cos(55);
	while(self.health > 0)
	{
		var_01 = getenemytarget(16000,var_00,1,1);
		if(isdefined(var_01))
		{
			thread shootenemytarget_bullets(var_01);
		}

		wait(2);
	}
}

//Function Number: 4
heli_firelink(param_00)
{
	var_01 = getent(param_00.script_linkto,"script_linkname");
	var_02 = !isdefined(var_01);
	if(!isdefined(var_01))
	{
		var_01 = common_scripts\utility::getstruct(param_00.script_linkto,"script_linkname");
	}

	var_03 = param_00.script_firelink;
	if(var_02)
	{
		var_01 = var_01 common_scripts\utility::spawn_tag_origin();
	}

	switch(var_03)
	{
		case "zippy_burst":
			wait(1);
			fire_missile("hind_zippy",1,var_01);
			wait(0.1);
			fire_missile("hind_zippy",1,var_01);
			wait(0.2);
			fire_missile("hind_zippy",1,var_01);
			wait(0.3);
			fire_missile("hind_zippy",1,var_01);
			wait(0.3);
			fire_missile("hind_zippy",1,var_01);
			break;

		case "apache_zippy":
			var_04 = [0.1,0.2,0.3];
			wait(1);
			var_01.origin = var_01.origin + (0,0,-150);
			var_01 moveto(var_01.origin + (0,0,150),0.6,0,0);
			foreach(var_06 in var_04)
			{
				if(!isdefined(self))
				{
					continue;
				}
	
				fire_missile("apache_zippy",1,var_01);
				wait(var_06);
			}
			break;

		case "hind_rpg":
			fire_missile("hind_rpg",5,var_01,0.3);
			break;

		default:
			if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500")
			{
				vehicle_scripts\_attack_heli::heli_fire_missiles(var_01,2,0.25);
			}
			else
			{
				fire_missile("hind_zippy",5,var_01,0.3);
			}
			break;
	}

	if(var_02)
	{
		var_01 delete();
	}
}

//Function Number: 5
globalthink()
{
	if(!isdefined(self.vehicletype))
	{
		return;
	}

	var_00 = 0;
	if(self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind")
	{
		var_00 = 1;
	}

	if(self.vehicletype == "cobra" || self.vehicletype == "cobra_player")
	{
		thread attachmissiles("chopperpilot_hellfire","cobra_Sidewinder");
		if(isdefined(self.fullmodel))
		{
			self.fullmodel thread attachmissiles("chopperpilot_hellfire","cobra_Sidewinder");
		}

		var_00 = 1;
	}

	if(!var_00)
	{
		return;
	}

	level thread flares_think(self);
	level thread maps\_helicopter_ai::evasive_think(self);
	if(getdvar("cobrapilot_wingman_enabled") == "1")
	{
		if(isdefined(self.script_wingman))
		{
			level.wingman = self;
			level thread maps\_helicopter_ai::wingman_think(self);
		}
	}
}

//Function Number: 6
flares_think(param_00)
{
	param_00 endon("death");
	notifyoncommand("flare_button","+frag");
	notifyoncommand("flare_button","+usereload");
	notifyoncommand("flare_button","+activate");
	while(param_00.health > 0)
	{
		if(isdefined(param_00.playercontrolled))
		{
			param_00.pilot waittill("flare_button");
		}
		else
		{
			param_00 waittill("incomming_missile",var_01);
			if(!isdefined(var_01))
			{
				continue;
			}

			if(randomint(3) == 0)
			{
				continue;
			}

			wait(randomfloatrange(0.5,1));
		}

		thread flares_fire(param_00);
		wait(3);
	}
}

//Function Number: 7
flares_fire_burst(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		playfx(level.flare_fx[param_00.vehicletype],param_00 gettagorigin("tag_flare"));
		if(isdefined(param_00.playercontrolled))
		{
			level.stats["flares_used"]++;
			param_00 notify("dropping_flares");
			if(var_04)
			{
				param_00 playsound("cobra_flare_fire");
			}

			var_04 = !var_04;
		}

		if(var_05 <= param_02 - 1)
		{
			thread flares_redirect_missiles(param_00,param_03);
		}

		wait(0.1);
	}
}

//Function Number: 8
flares_fire(param_00)
{
	param_00 endon("death");
	var_01 = 5;
	if(isdefined(param_00.flare_duration))
	{
		var_01 = param_00.flare_duration;
	}

	flares_fire_burst(param_00,8,1,var_01);
}

//Function Number: 9
create_missileattractor_on_player_chopper()
{
	if(isdefined(self.missileattractor))
	{
		missile_deleteattractor(self.missileattractor);
	}

	self.missileattractor = missile_createattractorent(self.centeraimpoint,10000,10000);
}

//Function Number: 10
flares_redirect_missiles(param_00,param_01)
{
	param_00 notify("flares_out");
	param_00 endon("death");
	param_00 endon("flares_out");
	if(!isdefined(param_01))
	{
		param_01 = 5;
	}

	var_02 = flares_get_vehicle_velocity(param_00);
	var_03 = spawn("script_origin",param_00 gettagorigin("tag_flare"));
	var_03 movegravity(var_02,param_01);
	var_04 = undefined;
	if(isdefined(param_00.playercontrolled))
	{
		if(isdefined(param_00.missileattractor))
		{
			missile_deleteattractor(param_00.missileattractor);
		}

		var_04 = missile_createattractorent(var_03,10000,10000);
	}

	if(isdefined(param_00.incomming_missiles))
	{
		for(var_05 = 0;var_05 < param_00.incomming_missiles.size;var_05++)
		{
			param_00.incomming_missiles[var_05] missile_settargetent(var_03);
		}
	}

	wait(param_01);
	if(isdefined(param_00.playercontrolled))
	{
		if(isdefined(var_04))
		{
			missile_deleteattractor(var_04);
		}

		param_00 thread create_missileattractor_on_player_chopper();
	}

	if(!isdefined(param_00.script_targetoffset_z))
	{
		param_00.script_targetoffset_z = 0;
	}

	var_06 = (0,0,param_00.script_targetoffset_z);
	if(!isdefined(param_00.incomming_missiles))
	{
		return;
	}

	for(var_05 = 0;var_05 < param_00.incomming_missiles.size;var_05++)
	{
		param_00.incomming_missiles[var_05] missile_settargetent(param_00,var_06);
	}
}

//Function Number: 11
flares_get_vehicle_velocity(param_00)
{
	var_01 = param_00.origin;
	wait(0.05);
	var_02 = param_00.origin - var_01;
	return var_02 * 20;
}

//Function Number: 12
missile_deathwait(param_00,param_01)
{
	param_01 endon("death");
	param_00 waittill("death");
	if(!isdefined(param_01.incomming_missiles))
	{
		return;
	}

	param_01.incomming_missiles = common_scripts\utility::array_remove(param_01.incomming_missiles,param_00);
}

//Function Number: 13
getenemytarget(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_07 = [];
	var_08 = undefined;
	var_09 = common_scripts\utility::get_enemy_team(self.script_team);
	var_0A = [];
	if(param_04)
	{
		for(var_0B = 0;var_0B < level.vehicles[var_09].size;var_0B++)
		{
			var_0A[var_0A.size] = level.vehicles[var_09][var_0B];
		}
	}

	if(param_02)
	{
		var_0C = getaiarray(var_09);
		for(var_0B = 0;var_0B < var_0C.size;var_0B++)
		{
			if(isdefined(var_0C[var_0B].ignored_by_attack_heli))
			{
				continue;
			}

			var_0A[var_0A.size] = var_0C[var_0B];
		}

		if(var_09 == "allies")
		{
			for(var_0B = 0;var_0B < level.players.size;var_0B++)
			{
				var_0A[var_0A.size] = level.players[var_0B];
			}
		}
	}

	if(isdefined(param_06))
	{
		var_0A = maps\_utility::array_exclude(var_0A,param_06);
	}

	if(param_05)
	{
		var_0A = common_scripts\utility::array_randomize(var_0A);
	}

	var_0D = anglestoforward(self.angles);
	for(var_0B = 0;var_0B < var_0A.size;var_0B++)
	{
		if(issentient(var_0A[var_0B]) && issentient(self) && self getthreatbiasgroup() != "")
		{
			var_0E = getthreatbias(var_0A[var_0B] getthreatbiasgroup(),self getthreatbiasgroup());
			if(var_0E <= -1000000)
			{
				continue;
			}
		}

		if(isdefined(param_00) && param_00 > 0)
		{
			if(distance(self.origin,var_0A[var_0B].origin) > param_00)
			{
				continue;
			}
		}

		if(isdefined(param_01))
		{
			var_0F = vectornormalize(var_0A[var_0B].origin - self.origin);
			var_10 = vectordot(var_0D,var_0F);
			if(var_10 <= param_01)
			{
				continue;
			}
		}

		if(param_03)
		{
			var_11 = 0;
			if(isai(var_0A[var_0B]))
			{
				var_12 = 48;
			}
			else
			{
				var_12 = 150;
			}

			var_11 = sighttracepassed(self.origin,var_0A[var_0B].origin + (0,0,var_12),0,self);
			if(!var_11)
			{
				continue;
			}
		}

		var_07[var_07.size] = var_0A[var_0B];
	}

	if(var_07.size == 0)
	{
		self notify("gunner_new_target",var_08);
		return var_08;
	}

	if(var_07.size == 1)
	{
		self notify("gunner_new_target",var_07[0]);
		return var_07[0];
	}

	var_13 = common_scripts\utility::getclosest(self.origin,var_07);
	self notify("gunner_new_target",var_13);
	return var_13;
}

//Function Number: 14
shootenemytarget_bullets(param_00)
{
	self endon("death");
	self endon("mg_off");
	param_00 endon("death");
	self endon("gunner_new_target");
	if(isdefined(self.playercontrolled))
	{
		self endon("gunner_stop_firing");
	}

	var_01 = (0,0,0);
	if(isdefined(param_00.script_targetoffset_z))
	{
		var_01 = var_01 + (0,0,param_00.script_targetoffset_z);
	}
	else if(issentient(param_00))
	{
		var_01 = (0,0,32);
	}

	self setturrettargetent(param_00,var_01);
	while(self.health > 0)
	{
		var_02 = randomintrange(1,25);
		if(getdvar("cobrapilot_debug") == "1")
		{
			iprintln("randomShots = " + var_02);
		}

		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			if(isdefined(self.playercontrolled))
			{
				if(isdefined(level.cobraweapon) && level.cobraweapon.size > 0)
				{
					self setvehweapon(level.gunnerweapon);
				}
			}

			thread shootenemytarget_bullets_debugline(self,"tag_turret",param_00,var_01,(1,1,0),0.05);
			self fireweapon("tag_flash");
			if(isdefined(self.playercontrolled))
			{
				self setvehweapon(level.cobraweapon[self.pilot.currentweapon].v["weapon"]);
			}

			wait(0.05);
		}

		wait(randomfloatrange(0.25,2.5));
	}
}

//Function Number: 15
shootenemytarget_bullets_debugline(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(getdvar("cobrapilot_debug") != "1")
	{
		return;
	}

	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	param_02 endon("death");
	self endon("gunner_new_target");
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(isdefined(param_05))
	{
		param_05 = gettime() + param_05 * 1000;
		while(gettime() < param_05)
		{
			wait(0.05);
		}

		return;
	}

	wait(0.05);
}

//Function Number: 16
attachmissiles(param_00,param_01,param_02,param_03)
{
	self.hasattachedweapons = 1;
	var_04 = [];
	var_04[0] = param_00;
	if(isdefined(param_01))
	{
		var_04[1] = param_01;
	}

	if(isdefined(param_02))
	{
		var_04[2] = param_02;
	}

	if(isdefined(param_03))
	{
		var_04[3] = param_03;
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		for(var_06 = 0;var_06 < level.cobra_weapon_tags[var_04[var_05]].size;var_06++)
		{
			self attach(level.cobra_missile_models[var_04[var_05]],level.cobra_weapon_tags[var_04[var_05]][var_06]);
		}
	}
}

//Function Number: 17
fire_missile(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_05 = undefined;
	var_06 = undefined;
	var_07 = "cobra_20mm";
	var_08 = [];
	switch(param_00)
	{
		case "f15_missile":
			var_05 = "cobra_Sidewinder";
			var_08[0] = "le_side_wing_jnt";
			var_08[1] = "ri_side_wing_jnt";
			break;

		case "mi28_seeker":
			var_05 = "cobra_seeker";
			var_08[0] = "tag_store_L_1_a";
			var_08[1] = "tag_store_R_1_a";
			var_08[2] = "tag_store_L_2_a";
			var_08[3] = "tag_store_R_2_a";
			break;

		case "ffar":
			var_05 = "cobra_FFAR";
			var_08[0] = "tag_store_r_2";
			break;

		case "seeker":
			var_05 = "cobra_seeker";
			var_08[0] = "tag_store_r_2";
			break;

		case "ffar_bog_a_lite":
			var_05 = "cobra_FFAR_bog_a_lite";
			var_08[0] = "tag_store_r_2";
			break;

		case "ffar_airlift":
			var_05 = "cobra_FFAR_airlift";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "ffar_airlift_nofx":
			var_05 = "cobra_FFAR_airlift_nofx";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "cobra_zippy":
			var_05 = "zippy_rockets";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "apache_zippy":
			var_05 = "zippy_rockets_apache";
			var_08[0] = "tag_flash_2";
			var_08[1] = "tag_flash_3";
			break;

		case "apache_zippy_nd":
			var_05 = "zippy_rockets_apache_nodamage";
			var_08[0] = "tag_flash_2";
			var_08[1] = "tag_flash_3";
			break;

		case "mi28_zippy":
			var_05 = "zippy_rockets_apache";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "mi28_zippy_cheap":
			var_05 = "zippy_rockets_apache_cheap";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "cobra_turret":
			var_05 = "hind_turret_penetration";
			var_08[0] = "tag_store_L_wing";
			var_08[1] = "tag_store_R_wing";
			break;

		case "ffar_hind":
			var_07 = "hind_turret";
			var_05 = "hind_FFAR";
			var_08[0] = "tag_missile_left";
			var_08[1] = "tag_missile_right";
			break;

		case "hind_zippy":
			var_07 = "hind_turret";
			var_05 = "zippy_rockets";
			var_08[0] = "tag_missile_left";
			var_08[1] = "tag_missile_right";
			break;

		case "hind_rpg":
			var_07 = "hind_turret";
			var_05 = "rpg";
			var_08[0] = "tag_missile_left";
			var_08[1] = "tag_missile_right";
			break;

		case "hind_rpg_cheap":
			var_07 = "hind_turret";
			var_05 = "rpg_cheap";
			var_08[0] = "tag_missile_left";
			var_08[1] = "tag_missile_right";
			break;

		case "ffar_hind_nodamage":
			var_07 = "hind_turret";
			var_05 = "hind_FFAR_nodamage";
			var_08[0] = "tag_missile_left";
			var_08[1] = "tag_missile_right";
			break;

		case "ffar_mi28_village_assault":
			var_07 = "hind_turret";
			var_05 = "mi28_ffar_village_assault";
			var_08[0] = "tag_store_L_2_a";
			var_08[1] = "tag_store_R_2_a";
			var_08[2] = "tag_store_L_2_b";
			var_08[3] = "tag_store_R_2_b";
			var_08[4] = "tag_store_L_2_c";
			var_08[5] = "tag_store_R_2_c";
			var_08[6] = "tag_store_L_2_d";
			var_08[7] = "tag_store_R_2_d";
			break;

		case "ffar_co_rescue":
			var_05 = "cobra_FFAR_bog_a_lite";
			var_08[0] = "tag_store_R_2_a";
			var_08[1] = "tag_store_L_2_a";
			break;

		default:
			break;
	}

	var_06 = weaponfiretime(var_05);
	if(isdefined(self.nextmissiletag))
	{
		var_09 = self.nextmissiletag;
	}
	else
	{
		var_09 = -1;
	}

	for(var_0A = 0;var_0A < param_01;var_0A++)
	{
		var_09++;
		var_09 = var_09 % var_08.size;
		if(param_00 == "ffar_mi28_village_assault")
		{
			if(isdefined(param_02) && isdefined(param_02.origin))
			{
				magicbullet(var_05,self gettagorigin(var_08[var_09]),param_02.origin);
				if(isdefined(level._effect["ffar_mi28_muzzleflash"]))
				{
					playfxontag(common_scripts\utility::getfx("ffar_mi28_muzzleflash"),self,var_08[var_09]);
				}

				thread delayed_earthquake(0.1,0.5,0.2,param_02.origin,1600);
			}
		}
		else
		{
			self setvehweapon(var_05);
			if(isdefined(param_02))
			{
				var_0B = self fireweapon(var_08[var_09],param_02);
				soundscripts\_audio::deprecated_aud_send_msg("missile_fired",var_0B);
				switch(param_00)
				{
					case "ffar_airlift":
					case "ffar_bog_a_lite":
					case "ffar":
						var_0B thread missilelosetarget(0.1);
						break;

					case "apache_zippy_wall":
					case "mi28_zippy_cheap":
					case "mi28_zippy":
					case "apache_zippy_nd":
					case "apache_zippy":
						if(!isdefined(param_04))
						{
							var_0B thread missilelosetarget(0.6);
						}
						else
						{
							var_0B thread missilelosetarget(param_04);
						}
						break;

					default:
						break;
				}
			}
			else
			{
				var_0B = self fireweapon(var_09[var_0A]);
			}

			self notify("missile_fired",var_0B);
		}

		self.nextmissiletag = var_09;
		if(var_0A < param_01 - 1)
		{
			wait(var_06);
		}

		if(isdefined(param_03))
		{
			wait(param_03);
		}
	}

	self setvehweapon(var_07);
}

//Function Number: 18
delayed_earthquake(param_00,param_01,param_02,param_03,param_04)
{
	wait(param_00);
	earthquake(param_01,param_02,param_03,param_04);
}

//Function Number: 19
missilelosetarget(param_00)
{
	self endon("death");
	wait(param_00);
	if(isdefined(self))
	{
		self missile_cleartarget();
	}
}