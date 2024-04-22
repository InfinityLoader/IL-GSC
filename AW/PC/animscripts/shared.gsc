/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: shared.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 471 ms
 * Timestamp: 4/22/2024 2:00:54 AM
*******************************************************************/

//Function Number: 1
placeweaponon(param_00,param_01,param_02)
{
	self notify("weapon_position_change");
	var_03 = self.weaponinfo[param_00].position;
	if(param_01 != "none" && self.a.weaponpos[param_01] == param_00)
	{
		return;
	}

	detachallweaponmodels();
	if(var_03 != "none")
	{
		detachweapon(param_00);
	}

	if(param_01 == "none")
	{
		updateattachedweaponmodels();
		return;
	}

	if(self.a.weaponpos[param_01] != "none")
	{
		detachweapon(self.a.weaponpos[param_01]);
	}
	else if(isdefined(self.weaponinfo["none"]))
	{
		self.weaponinfo["none"].position = "none";
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && param_01 == "left" || param_01 == "right")
	{
		attachweapon(param_00,param_01);
		self.weapon = param_00;
	}
	else
	{
		attachweapon(param_00,param_01);
	}

	updateattachedweaponmodels();
}

//Function Number: 2
detachweapon(param_00)
{
	self.a.weaponpos[self.weaponinfo[param_00].position] = "none";
	self.weaponinfo[param_00].position = "none";
}

//Function Number: 3
attachweapon(param_00,param_01)
{
	self.weaponinfo[param_00].position = param_01;
	self.a.weaponpos[param_01] = param_00;
	if(self.a.weaponposdropping[param_01] != "none")
	{
		self notify("end_weapon_drop_" + param_01);
		self.a.weaponposdropping[param_01] = "none";
	}
}

//Function Number: 4
getweaponforpos(param_00)
{
	var_01 = self.a.weaponpos[param_00];
	if(var_01 == "none")
	{
		return self.a.weaponposdropping[param_00];
	}

	return var_01;
}

//Function Number: 5
detachallweaponmodels()
{
	var_00 = [];
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	self laseroff();
	foreach(var_02 in var_00)
	{
		var_03 = getweaponforpos(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		if(weapontype(var_03) == "riotshield" && isdefined(self.shieldmodelvariant))
		{
			if(isdefined(self.shieldbroken) && self.shieldbroken)
			{
				playfxontag(common_scripts\utility::getfx("riot_shield_dmg"),self,"TAG_BRASS");
				self.shieldbroken = undefined;
			}
		}
	}

	self updateentitywithweapons();
}

//Function Number: 6
updateattachedweaponmodels()
{
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	foreach(var_04 in var_00)
	{
		var_01[var_01.size] = getweaponforpos(var_04);
		var_02[var_02.size] = gettagforpos(var_04);
	}

	self updateentitywithweapons(var_01[0],var_02[0],var_01[1],var_02[1],var_01[2],var_02[2],var_01[3],var_02[3]);
	foreach(var_04 in var_00)
	{
		var_07 = getweaponforpos(var_04);
		if(var_07 == "none")
		{
			continue;
		}

		if(self.weaponinfo[var_07].useclip && !self.weaponinfo[var_07].hasclip)
		{
			self hidepart("tag_clip");
		}
	}

	updatelaserstatus();
}

//Function Number: 7
updatelaserstatus()
{
	if(isdefined(self.custom_laser_function))
	{
		[[ self.custom_laser_function ]]();
		return;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return;
	}

	if(canuselaser())
	{
		self laseron("nvg_laser");
		return;
	}

	self laseroff();
}

//Function Number: 8
canuselaser()
{
	if(!self.a.laseron)
	{
		return 0;
	}

	if(animscripts\utility::isshotgun(self.weapon))
	{
		return 0;
	}

	return isalive(self);
}

//Function Number: 9
gettagforpos(param_00)
{
	switch(param_00)
	{
		case "chest":
			return "tag_weapon_chest";

		case "back":
			return "tag_stowed_back";

		case "left":
			return "tag_weapon_left";

		case "right":
			return "tag_weapon_right";

		case "hand":
			return "tag_inhand";

		default:
			break;
	}
}

//Function Number: 10
dropaiweapon(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.weapon;
	}

	if(param_00 == "none")
	{
		return;
	}

	if(isdefined(self.nodrop))
	{
		return;
	}

	detachallweaponmodels();
	var_01 = self.weaponinfo[param_00].position;
	if(self.dropweapon && var_01 != "none")
	{
		thread dropweaponwrapper(param_00,var_01);
	}

	detachweapon(param_00);
	if(param_00 == self.weapon)
	{
		self.weapon = "none";
	}

	updateattachedweaponmodels();
}

//Function Number: 11
dropallaiweapons()
{
	if(isdefined(self.nodrop))
	{
		return "none";
	}

	var_00 = [];
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	detachallweaponmodels();
	foreach(var_02 in var_00)
	{
		var_03 = self.a.weaponpos[var_02];
		if(var_03 == "none")
		{
			continue;
		}

		self.weaponinfo[var_03].position = "none";
		self.a.weaponpos[var_02] = "none";
		if(self.dropweapon)
		{
			thread dropweaponwrapper(var_03,var_02);
		}
	}

	self.weapon = "none";
	updateattachedweaponmodels();
}

//Function Number: 12
dropweaponwrapper(param_00,param_01)
{
	if(self isragdoll())
	{
		return "none";
	}

	self.a.weaponposdropping[param_01] = param_00;
	var_02 = param_00;
	if(issubstr(tolower(var_02),"rpg"))
	{
		var_02 = "rpg_player";
	}

	if(issubstr(tolower(var_02),"mahem"))
	{
		var_02 = "iw5_mahemplayer_sp_mahemscopebase";
	}

	self dropweapon(var_02,param_01,0);
	self endon("end_weapon_drop_" + param_01);
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	detachallweaponmodels();
	self.a.weaponposdropping[param_01] = "none";
	updateattachedweaponmodels();
}

//Function Number: 13
donotetracks(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		self waittill(param_00,var_04);
		if(!isdefined(var_04))
		{
			var_04 = "undefined";
		}

		var_05 = animscripts\notetracks::handlenotetrack(var_04,param_00,param_01,param_03);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 14
getpredictedaimyawtoshootentorpos(param_00)
{
	if(!isdefined(self.shootent))
	{
		if(!isdefined(self.shootpos))
		{
			return 0;
		}

		return getaimyawtopoint(self.shootpos);
	}

	var_01 = self.shootent.origin + self.shootentvelocity * param_00;
	return getaimyawtopoint(var_01);
}

//Function Number: 15
getaimyawtoshootentorpos()
{
	if(!isdefined(self.shootent))
	{
		if(!isdefined(self.shootpos))
		{
			return 0;
		}

		return getaimyawtopoint(self.shootpos);
	}

	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		return getaimyawtopoint(animscripts\combat_utility::get_last_known_shoot_pos(self.shootent));
	}

	return getaimyawtopoint(self.shootent getshootatpos());
}

//Function Number: 16
getaimpitchtoshootentorpos()
{
	var_00 = getpitchtoshootentorpos();
	if(self.script == "cover_crouch" && isdefined(self.a.covermode) && self.a.covermode == "lean")
	{
		var_00 = var_00 - level.covercrouchleanpitch;
	}

	return var_00;
}

//Function Number: 17
getpitchtoshootentorpos()
{
	if(!isdefined(self.shootent))
	{
		if(!isdefined(self.shootpos))
		{
			return 0;
		}

		return animscripts\combat_utility::getpitchtospot(self.shootpos);
	}

	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		return animscripts\combat_utility::getpitchtospot(animscripts\combat_utility::get_last_known_shoot_pos(self.shootent));
	}

	return animscripts\combat_utility::getpitchtospot(self.shootent getshootatpos());
}

//Function Number: 18
getshootfrompos()
{
	if(isdefined(self.usemuzzlesideoffset))
	{
		var_00 = self getmuzzlesideoffsetpos();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	if(isdefined(self.usemuzzleforaim) && self.usemuzzleforaim)
	{
		if(self gettagindex("tag_flash") != -1)
		{
			var_01 = self gettagorigin("tag_flash");
			if(isdefined(var_01))
			{
				return var_01;
			}
		}
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 19
getaimyawtopoint(param_00)
{
	var_01 = animscripts\utility::getyawtospot(param_00);
	var_02 = distance(self.origin,param_00);
	if(var_02 > 3)
	{
		var_03 = asin(-3 / var_02);
		var_01 = var_01 + var_03;
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 20
ramboaim(param_00)
{
	self endon("killanimscript");
	ramboaiminternal(param_00);
	self clearanim(%generic_aim_left,0.5);
	self clearanim(%generic_aim_right,0.5);
}

//Function Number: 21
ramboaiminternal(param_00)
{
	self endon("rambo_aim_end");
	waittillframeend;
	self clearanim(%generic_aim_left,0.2);
	self clearanim(%generic_aim_right,0.2);
	self setanimlimited(%generic_aim_45l,1,0.2);
	self setanimlimited(%generic_aim_45r,1,0.2);
	var_01 = 0.2;
	var_02 = 0;
	for(;;)
	{
		if(isdefined(self.shootpos))
		{
			var_03 = animscripts\utility::getyaw(self.shootpos) - self.covernode.angles[1];
			var_03 = angleclamp180(var_03 - param_00);
			if(abs(var_03 - var_02) > 10)
			{
				if(var_03 > var_02)
				{
					var_03 = var_02 + 10;
				}
				else
				{
					var_03 = var_02 - 10;
				}
			}

			var_02 = var_03;
		}

		if(var_02 < 0)
		{
			var_04 = var_02 / -45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}

			self setanimlimited(%generic_aim_right,var_04,var_01);
			self setanimlimited(%generic_aim_left,0,var_01);
		}
		else
		{
			var_04 = var_02 / 45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}

			self setanimlimited(%generic_aim_left,var_04,var_01);
			self setanimlimited(%generic_aim_right,0,var_01);
		}

		wait(var_01);
	}
}

//Function Number: 22
decidenumshotsforburst()
{
	var_00 = 0;
	var_01 = weaponburstcount(self.weapon);
	if(var_01)
	{
		var_00 = var_01;
	}
	else if(animscripts\weaponlist::usingsemiautoweapon())
	{
		var_00 = level.semifirenumshots[randomint(level.semifirenumshots.size)];
	}
	else if(self.fastburst)
	{
		var_00 = level.fastburstfirenumshots[randomint(level.fastburstfirenumshots.size)];
	}
	else
	{
		var_00 = level.burstfirenumshots[randomint(level.burstfirenumshots.size)];
	}

	if(var_00 <= self.bulletsinclip)
	{
		return var_00;
	}

	if(self.bulletsinclip <= 0)
	{
		return 1;
	}

	return self.bulletsinclip;
}

//Function Number: 23
decidenumshotsforfull()
{
	var_00 = self.bulletsinclip;
	if(weaponclass(self.weapon) == "mg")
	{
		var_01 = randomfloat(10);
		if(var_01 < 3)
		{
			var_00 = randomintrange(2,6);
		}
		else if(var_01 < 8)
		{
			var_00 = randomintrange(6,12);
		}
		else
		{
			var_00 = randomintrange(12,20);
		}
	}

	return var_00;
}

//Function Number: 24
handledropclip(param_00)
{
	self endon("killanimscript");
	self endon("abort_reload");
	var_01 = undefined;
	if(self.weaponinfo[self.weapon].useclip)
	{
		var_01 = getweaponclipmodel(self.weapon);
	}

	if(self.weaponinfo[self.weapon].hasclip)
	{
		if(animscripts\utility::usingsidearm())
		{
			self playsound("weap_reload_pistol_clipout_npc");
		}
		else
		{
			self playsound("weap_reload_smg_clipout_npc");
		}

		if(isdefined(var_01))
		{
			self hidepart("tag_clip");
			thread dropclipmodel(var_01,"tag_clip");
			self.weaponinfo[self.weapon].hasclip = 0;
			thread resetcliponabort(var_01);
		}
	}

	for(;;)
	{
		self waittill(param_00,var_02);
		switch(var_02)
		{
			case "attach clip right":
			case "attach clip left":
				if(isdefined(var_01))
				{
					self attach(var_01,"tag_inhand");
					thread resetcliponabort(var_01,"tag_inhand");
					if(!self.weaponinfo[self.weapon].hasclip)
					{
						self hidepart("tag_clip");
					}
				}
		
				animscripts\weaponlist::refillclip();
				break;
	
			case "detach clip nohand":
				if(isdefined(var_01))
				{
					self detach(var_01,"tag_inhand");
				}
				break;
	
			case "detach clip right":
			case "detach clip left":
				if(isdefined(var_01))
				{
					self detach(var_01,"tag_inhand");
					self showpart("tag_clip");
					self notify("clip_detached");
					self.weaponinfo[self.weapon].hasclip = 1;
				}
		
				if(animscripts\utility::usingsidearm())
				{
					self playsound("weap_reload_pistol_clipin_npc");
				}
				else
				{
					self playsound("weap_reload_smg_clipin_npc");
				}
				self.a.needstorechamber = 0;
				break;
		}
	}
}

//Function Number: 25
resetcliponabort(param_00,param_01)
{
	self notify("clip_detached");
	self endon("clip_detached");
	common_scripts\utility::waittill_any("killanimscript","abort_reload");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01))
	{
		self detach(param_00,param_01);
	}

	if(isalive(self))
	{
		if(self.weapon != "none" && self.weaponinfo[self.weapon].position != "none")
		{
			self showpart("tag_clip");
		}

		self.weaponinfo[self.weapon].hasclip = 1;
		return;
	}

	if(isdefined(param_01))
	{
		dropclipmodel(param_00,param_01);
	}
}

//Function Number: 26
dropclipmodel(param_00,param_01)
{
	var_02 = spawn("script_model",self gettagorigin(param_01));
	var_02 setmodel(param_00);
	var_02.angles = self gettagangles(param_01);
	var_02 physicslaunchclient(var_02.origin,(0,0,0));
	wait(10);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 27
movetonodeovertime(param_00,param_01)
{
	self endon("killanimscript");
	var_02 = param_00.origin;
	var_03 = distancesquared(self.origin,var_02);
	if(var_03 < 1)
	{
		self safeteleport(var_02);
		return;
	}

	if(var_03 > 256 && !self maymovetopoint(var_02,!self.swimmer))
	{
		return;
	}

	self.keepclaimednodeifvalid = 1;
	var_04 = distance(self.origin,var_02);
	var_05 = int(param_01 * 20);
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_02 = param_00.origin;
		var_07 = self.origin - var_02;
		var_07 = vectornormalize(var_07);
		var_08 = var_02 + var_07 * var_04;
		var_09 = var_08 + var_02 - var_08 * var_06 + 1 / var_05;
		self safeteleport(var_09);
		wait(0.05);
	}

	self.keepclaimednodeifvalid = 0;
}

//Function Number: 28
returntrue()
{
	return 1;
}

//Function Number: 29
playlookanimation(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::returntrue;
	}

	for(var_03 = 0;var_03 < param_01 * 10;var_03++)
	{
		if(isalive(self.enemy))
		{
			if(animscripts\utility::canseeenemy() && [[ param_02 ]]())
			{
				return;
			}
		}

		if(animscripts\utility::issuppressedwrapper() && [[ param_02 ]]())
		{
			return;
		}

		self setanimknoball(param_00,%body,1,0.1);
		wait(0.1);
	}
}

//Function Number: 30
throwdownweapon(param_00)
{
	self endon("killanimscript");
	placeweaponon(self.secondaryweapon,"right");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 31
rpgplayerrepulsor()
{
	var_00 = rpgplayerrepulsor_getnummisses();
	if(var_00 == 0)
	{
		return;
	}

	self endon("death");
	for(;;)
	{
		level waittill("an_enemy_shot",var_01);
		if(var_01 != self)
		{
			continue;
		}

		if(!isdefined(var_01.enemy))
		{
			continue;
		}

		if(var_01.enemy != level.player)
		{
			continue;
		}

		if(isdefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0)
		{
			continue;
		}

		thread rpgplayerrepulsor_create();
		var_00--;
		if(var_00 <= 0)
		{
			return;
		}
	}
}

//Function Number: 32
rpgplayerrepulsor_getnummisses()
{
	var_00 = maps\_utility::getdifficulty();
	switch(var_00)
	{
		case "gimp":
		case "easy":
			return 2;

		case "difficult":
		case "hard":
		case "medium":
			return 1;

		case "fu":
			return 0;
	}

	return 2;
}

//Function Number: 33
rpgplayerrepulsor_create()
{
	var_00 = missile_createrepulsorent(level.player,5000,800);
	wait(4);
	missile_deleteattractor(var_00);
}