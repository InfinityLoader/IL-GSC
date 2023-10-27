/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\shared.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 34
 * Decompile Time: 582 ms
 * Timestamp: 10/27/2023 2:30:47 AM
*******************************************************************/

//Function Number: 1
placeweaponon(param_00,param_01,param_02)
{
	self notify("weapon_position_change");
	var_03 = self.weaponinfo[param_00].var_1C1B;
	if(param_01 != "none" && self.a.weaponpos[param_01] == param_00)
	{
		return;
	}

	detachallweaponmodels();
	if(var_03 != "none")
	{
		func_1F40(param_00);
	}

	if(param_01 == "none")
	{
		func_1F46();
		return;
	}

	if(self.a.weaponpos[param_01] != "none")
	{
		func_1F40(self.a.weaponpos[param_01]);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && param_01 == "left" || param_01 == "right")
	{
		func_1F41(param_00,param_01);
		self.weapon = param_00;
	}
	else
	{
		func_1F41(param_00,param_01);
	}

	func_1F46();
}

//Function Number: 2
func_1F40(param_00)
{
	self.a.weaponpos[self.weaponinfo[param_00].var_1C1B] = "none";
	self.weaponinfo[param_00].var_1C1B = "none";
}

//Function Number: 3
func_1F41(param_00,param_01)
{
	self.weaponinfo[param_00].var_1C1B = param_01;
	self.a.weaponpos[param_01] = param_00;
	if(self.a.weaponposdropping[param_01] != "none")
	{
		self notify("end_weapon_drop_" + param_01);
		self.a.weaponposdropping[param_01] = "none";
	}
}

//Function Number: 4
func_1F42(param_00)
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
	self laseroff();
	foreach(var_02 in var_41)
	{
		var_03 = func_1F42(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		if(weapontype(var_03) == "riotshield" && isdefined(self.var_1F44))
		{
			if(isdefined(self.shieldbroken) && self.shieldbroken)
			{
				playfxontag(common_scripts\utility::func_539("riot_shield_dmg"),self,"TAG_BRASS");
				self.shieldbroken = undefined;
			}

			self detach(getweaponmodel(var_03,self.var_1F44),func_1F49(var_02));
			continue;
		}

		self detach(getweaponmodel(var_03),func_1F49(var_02));
	}
}

//Function Number: 6
func_1F46()
{
	var_00 = [];
	foreach(var_02 in var_41)
	{
		var_03 = func_1F42(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		var_04 = 0;
		if(weapontype(var_03) == "riotshield" && isdefined(self.var_1F44))
		{
			var_04 = self.var_1F44;
		}

		var_05 = getweaponmodel(var_03,var_04);
		if(weapontype(var_03) == "riotshield")
		{
			self attach(var_05,func_1F49(var_02));
		}
		else
		{
			self attach(var_05,func_1F49(var_02),1);
		}

		var_06 = getweaponhidetags(var_03);
		var_07 = 0;
		while(var_07 < var_06.size)
		{
			self hidepart(var_06[var_07],var_05);
			var_07++ = var_41[var_41.size];
		}

		if(self.weaponinfo[var_03].var_1C1D && !self.weaponinfo[var_03].var_1C1C)
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
		self laseron();
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

	if(animscripts/utility::isshotgun(self.weapon))
	{
		return 0;
	}

	return isalive(self);
}

//Function Number: 9
func_1F49(param_00)
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

	if(isdefined(self.var_1CC7))
	{
		return;
	}

	detachallweaponmodels();
	var_01 = self.weaponinfo[param_00].var_1C1B;
	if(self.dropweapon && var_01 != "none")
	{
		thread dropweaponwrapper(param_00,var_01);
	}

	func_1F40(param_00);
	if(param_00 == self.weapon)
	{
		self.weapon = "none";
	}

	func_1F46();
}

//Function Number: 11
dropallaiweapons()
{
	if(isdefined(self.var_1CC7))
	{
		return "none";
	}

	var_00 = [];
	detachallweaponmodels();
	foreach(var_02 in var_41)
	{
		var_03 = self.a.weaponpos[var_02];
		if(var_03 == "none")
		{
			continue;
		}

		self.weaponinfo[var_03].var_1C1B = "none";
		self.a.weaponpos[var_02] = "none";
		if(self.dropweapon)
		{
			thread dropweaponwrapper(var_03,var_02);
		}
	}

	self.weapon = "none";
	func_1F46();
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

	self dropweapon(var_02,param_01,0);
	self endon("end_weapon_drop_" + param_01);
	wait 0.1;
	if(!isdefined(self))
	{
		return;
	}

	detachallweaponmodels();
	self.a.weaponposdropping[param_01] = "none";
	func_1F46();
}

//Function Number: 13
donotetracks(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = "undefined";
		}

		var_04 = animscripts/notetracks::func_1F4C(var_03,param_00,param_01);
		if(isdefined(var_04))
		{
			return var_04;
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

	var_01 = self.shootent.origin + self.var_96C * param_00;
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

	return getaimyawtopoint(self.shootent getshootatpos());
}

//Function Number: 16
func_1F4D()
{
	var_00 = getpitchtoshootentorpos();
	if(self.script == "cover_crouch" && isdefined(self.a.var_8E3) && self.a.var_8E3 == "lean")
	{
		var_00 = var_00 - level.var_898;
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

		return animscripts/combat_utility::getpitchtospot(self.shootpos);
	}

	return animscripts/combat_utility::getpitchtospot(self.shootent getshootatpos());
}

//Function Number: 18
func_089B()
{
	if(isdefined(self.usemuzzlesideoffset))
	{
		var_00 = self getmuzzlesideoffsetpos();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 19
getaimyawtopoint(param_00)
{
	var_01 = animscripts/utility::getyawtospot(param_00);
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
			var_03 = animscripts/utility::func_C05(self.shootpos) - self.covernode.angles[1];
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

		wait var_01;
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
	else if(animscripts/weaponlist::usingsemiautoweapon())
	{
		var_00 = level.var_1C5E[randomint(level.var_1C5E.size)];
	}
	else if(self.fastburst)
	{
		var_00 = level.var_1C5D[randomint(level.var_1C5D.size)];
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
func_1EFB()
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
insure_dropping_clip(param_00,param_01)
{
}

//Function Number: 25
handledropclip(param_00)
{
	self endon("killanimscript");
	self endon("abort_reload");
	var_01 = undefined;
	if(self.weaponinfo[self.weapon].var_1C1D)
	{
		var_01 = getweaponclipmodel(self.weapon);
	}

	if(self.weaponinfo[self.weapon].var_1C1C)
	{
		if(animscripts/utility::usingsidearm())
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
			self.weaponinfo[self.weapon].var_1C1C = 0;
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
				}
		
				animscripts/weaponlist::refillclip();
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
					self.weaponinfo[self.weapon].var_1C1C = 1;
				}
		
				if(animscripts/utility::usingsidearm())
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

//Function Number: 26
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
		if(self.weapon != "none" && self.weaponinfo[self.weapon].var_1C1B != "none")
		{
			self showpart("tag_clip");
		}

		self.weaponinfo[self.weapon].var_1C1C = 1;
		return;
	}

	if(isdefined(param_01))
	{
		dropclipmodel(param_00,param_01);
	}
}

//Function Number: 27
dropclipmodel(param_00,param_01)
{
	var_02 = spawn("script_model",self gettagorigin(param_01));
	var_02 setmodel(param_00);
	var_02.angles = self gettagangles(param_01);
	var_02 physicslaunchclient(var_02.origin,(0,0,0));
	wait 10;
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 28
movetooriginovertime(param_00,param_01)
{
	self endon("killanimscript");
	var_02 = distancesquared(self.origin,param_00);
	if(var_02 < 1)
	{
		self safeteleport(param_00);
		return;
	}

	if(var_02 > 256 && !self maymovetopoint(param_00))
	{
		return;
	}

	self.keepclaimednodeifvalid = 1;
	var_03 = self.origin - param_00;
	var_04 = int(param_01 * 20);
	var_05 = var_03 * 1 / var_04;
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		var_03 = var_03 - var_05;
		self safeteleport(param_00 + var_03);
		wait 0.05;
	}

	self.keepclaimednodeifvalid = 0;
}

//Function Number: 29
returntrue()
{
	return 1;
}

//Function Number: 30
func_0B7E(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::returntrue;
	}

	for(var_03 = 0;var_03 < param_01 * 10;var_03++)
	{
		if(isalive(self.enemy))
		{
			if(animscripts/utility::canseeenemy() && [[ param_02 ]]())
			{
				return;
			}
		}

		if(animscripts/utility::issuppressedwrapper() && [[ param_02 ]]())
		{
			return;
		}

		self setanimknoball(param_00,%body,1,0.1);
		wait 0.1;
	}
}

//Function Number: 31
throwdownweapon(param_00)
{
	self endon("killanimscript");
	placeweaponon(self.secondaryweapon,"right");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 32
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

//Function Number: 33
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

//Function Number: 34
rpgplayerrepulsor_create()
{
	var_00 = missile_createrepulsorent(level.player,5000,800);
	wait 4;
	missile_deleteattractor(var_00);
}