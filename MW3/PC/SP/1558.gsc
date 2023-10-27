/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1558.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 90 ms
 * Timestamp: 10/27/2023 2:21:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_3C66();
	func_3C6A();
	func_3C6C();
	if(common_scripts\utility::issp_towerdefense())
	{
		func_3C6B();
		func_3C6D();
	}
}

//Function Number: 2
func_3C66()
{
	precachestring(&"SENTRY_MOVE");
	precachestring(&"SENTRY_PICKUP");
	precachestring(&"SENTRY_PLACE");
	precachestring(&"SENTRY_CANNOT_PLACE");
	precachemodel("tag_laser");
	level.placed_sentry = [];
	level.var_3C68 = [];
	level.var_3C69 = [];
	level.var_3C69["easy"] = [];
	level.var_3C69["easy"]["convergencePitchTime"] = 2.5;
	level.var_3C69["easy"]["convergenceYawTime"] = 2.5;
	level.var_3C69["easy"]["suppressionTime"] = 3;
	level.var_3C69["easy"]["aiSpread"] = 2;
	level.var_3C69["easy"]["playerSpread"] = 0.5;
	level._effect["sentry_turret_overheat_smoke_sp"] = loadfx("smoke/sentry_turret_overheat_smoke_sp");
	level._effect["sentry_turret_explode"] = loadfx("explosions/sentry_gun_explosion");
	level._effect["sentry_turret_explode_smoke"] = loadfx("smoke/car_damage_blacksmoke");
}

//Function Number: 3
func_3C6A()
{
	precachemodel("sentry_minigun");
	precachemodel("sentry_minigun_obj");
	precachemodel("sentry_minigun_obj_red");
	precachemodel("sentry_minigun_folded_obj");
	precachemodel("sentry_minigun_destroyed");
	if(common_scripts\utility::issp() && !is_specialop())
	{
		precacheturret("sentry_minigun");
		precacheturret("sentry_minigun_enemy");
	}
	else if(is_specialop())
	{
		precacheturret("sentry_minigun_so");
	}
	else
	{
		precacheturret("sentry_minigun_mp");
	}

	level.var_3C68["sentry_minigun"] = spawnstruct();
	func_3C7D("sentry_minigun");
	func_3C6E("sentry_minigun");
	common_scripts\utility::array_thread(getentarray("script_model_pickup_sentry_minigun","classname"),::func_3C7F,"sentry_minigun");
}

//Function Number: 4
func_3C6B()
{
	precachemodel("sentry_minigun_weak");
	precachemodel("sentry_minigun_weak_destroyed");
	precachemodel("sentry_minigun_weak_obj");
	precachemodel("sentry_minigun_weak_obj_red");
	precachemodel("sentry_minigun_weak_folded_obj");
	precacheturret("sentry_minigun_weak");
	level.var_3C68["sentry_minigun_weak"] = spawnstruct();
	func_3C7E("sentry_minigun_weak");
	func_3C6E("sentry_minigun_weak");
	common_scripts\utility::array_thread(getentarray("script_model_pickup_sentry_minigun_weak","classname"),::func_3C7F,"sentry_minigun_weak");
}

//Function Number: 5
func_3C6C()
{
	precachemodel("sentry_grenade_launcher_upgrade");
	precachemodel("sentry_grenade_launcher_upgrade_destroyed");
	precachemodel("sentry_grenade_launcher_upgrade_obj");
	precachemodel("sentry_grenade_launcher_upgrade_obj_red");
	precachemodel("sentry_grenade_launcher_upgrade_folded_obj");
	if(common_scripts\utility::issp() && !is_specialop())
	{
		precacheturret("sentry_gun");
	}
	else if(is_specialop())
	{
		precacheturret("sentry_gun_so");
	}
	else
	{
		precacheturret("sentry_gun_mp");
	}

	level.var_3C68["sentry_gun"] = spawnstruct();
	func_3C6F("sentry_gun");
	func_3C6E("sentry_gun");
	common_scripts\utility::array_thread(getentarray("script_model_pickup_sentry_gun","classname"),::func_3C7F,"sentry_gun");
}

//Function Number: 6
func_3C6D()
{
	precachemodel("sentry_grenade_launcher");
	precachemodel("sentry_grenade_launcher_destroyed");
	precachemodel("sentry_grenade_launcher_obj");
	precachemodel("sentry_grenade_launcher_obj_red");
	precachemodel("sentry_grenade_launcher_folded_obj");
	precacheturret("sentry_gun_weak");
	level.var_3C68["sentry_gun_weak"] = spawnstruct();
	func_3C7C("sentry_gun_weak");
	func_3C6E("sentry_gun_weak");
	common_scripts\utility::array_thread(getentarray("script_model_pickup_sentry_gun_weak","classname"),::func_3C7F,"sentry_gun_weak");
}

//Function Number: 7
func_3C6E(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 func_3C80(undefined,param_00);
	}
}

//Function Number: 8
func_3C6F(param_00)
{
	level.var_3C68[param_00].ammo = 100;
	level.var_3C68[param_00].var_3C70 = 1;
	level.var_3C68[param_00].var_3C71 = 1;
	level.var_3C68[param_00].var_3C72 = 2;
	level.var_3C68[param_00].var_3C73 = 1;
	level.var_3C68[param_00].var_3C74 = 1.5;
	level.var_3C68[param_00].var_3C75 = 1;
	level.var_3C68[param_00].model = "sentry_grenade_launcher_upgrade";
	level.var_3C68[param_00].var_3C76 = "sentry_grenade_launcher_upgrade_destroyed";
	level.var_3C68[param_00].var_3C77 = "sentry_grenade_launcher_upgrade_folded";
	level.var_3C68[param_00].var_3C78 = "sentry_grenade_launcher_upgrade_folded_obj";
	level.var_3C68[param_00].var_3C79 = "sentry_grenade_launcher_upgrade_obj";
	level.var_3C68[param_00].var_3C7A = "sentry_grenade_launcher_upgrade_obj_red";
	level.var_3C68[param_00].health = 350;
	if(common_scripts\utility::issp() && !is_specialop())
	{
		level.var_3C68[param_00].var_3C7B = 15;
		level.var_3C68[param_00].weaponinfo = "sentry_gun";
		level.var_3C68[param_00].targetname = "sentry_gun";
		return;
	}

	if(is_specialop())
	{
		level.var_3C68[param_00].ammo = 50;
		level.var_3C68[param_00].var_3C7B = 8;
		level.var_3C68[param_00].weaponinfo = "sentry_gun_so";
		level.var_3C68[param_00].targetname = "sentry_gun_so";
		level.var_3C68[param_00].health = 1200;
		return;
	}

	level.var_3C68[param_00].var_3C7B = 5;
	level.var_3C68[param_00].weaponinfo = "sentry_gun_mp";
	level.var_3C68[param_00].targetname = "sentry_gun_mp";
}

//Function Number: 9
func_3C7C(param_00)
{
	level.var_3C68[param_00].var_3C70 = 0;
	level.var_3C68[param_00].var_3C71 = 1;
	level.var_3C68[param_00].var_3C72 = 2;
	level.var_3C68[param_00].var_3C73 = 1;
	level.var_3C68[param_00].var_3C74 = 1.5;
	level.var_3C68[param_00].var_3C75 = 1;
	level.var_3C68[param_00].model = "sentry_grenade_launcher";
	level.var_3C68[param_00].var_3C76 = "sentry_grenade_launcher_destroyed";
	level.var_3C68[param_00].var_3C77 = "sentry_grenade_launcher_folded";
	level.var_3C68[param_00].var_3C78 = "sentry_grenade_launcher_folded_obj";
	level.var_3C68[param_00].var_3C79 = "sentry_grenade_launcher_obj";
	level.var_3C68[param_00].var_3C7A = "sentry_grenade_launcher_obj_red";
	level.var_3C68[param_00].health = int(175);
	if(common_scripts\utility::issp())
	{
		level.var_3C68[param_00].var_3C7B = 15;
		level.var_3C68[param_00].weaponinfo = "sentry_gun_weak";
		level.var_3C68[param_00].targetname = "sentry_gun_weak";
		return;
	}

	level.var_3C68[param_00].var_3C7B = 5;
	level.var_3C68[param_00].weaponinfo = "sentry_gun_mp";
	level.var_3C68[param_00].targetname = "sentry_gun_mp";
}

//Function Number: 10
func_3C7D(param_00)
{
	level.var_3C68[param_00].ammo = 1000;
	level.var_3C68[param_00].var_3C70 = 1;
	level.var_3C68[param_00].var_3C71 = 20;
	level.var_3C68[param_00].var_3C72 = 60;
	level.var_3C68[param_00].var_3C73 = 0.5;
	level.var_3C68[param_00].var_3C74 = 1.3;
	level.var_3C68[param_00].var_3C75 = 0;
	level.var_3C68[param_00].model = "sentry_minigun";
	level.var_3C68[param_00].var_3C76 = "sentry_minigun_destroyed";
	level.var_3C68[param_00].var_3C77 = "sentry_minigun_folded";
	level.var_3C68[param_00].var_3C78 = "sentry_minigun_folded_obj";
	level.var_3C68[param_00].var_3C79 = "sentry_minigun_obj";
	level.var_3C68[param_00].var_3C7A = "sentry_minigun_obj_red";
	level.var_3C68[param_00].health = 190;
	if(common_scripts\utility::issp() && !is_specialop())
	{
		level.var_3C68[param_00].var_3C7B = 15;
		level.var_3C68[param_00].anim_loop = %minigun_spin_loop;
		level.var_3C68[param_00].weaponinfo = "sentry_minigun";
		level.var_3C68[param_00].targetname = "sentry_minigun";
		return;
	}

	if(is_specialop())
	{
		level.var_3C68[param_00].ammo = 800;
		level.var_3C68[param_00].var_3C7B = 8;
		level.var_3C68[param_00].anim_loop = %minigun_spin_loop;
		level.var_3C68[param_00].weaponinfo = "sentry_minigun_so";
		level.var_3C68[param_00].targetname = "sentry_minigun_so";
		level.var_3C68[param_00].health = 800;
		return;
	}

	level.var_3C68[param_00].var_3C7B = 5;
	level.var_3C68[param_00].weaponinfo = "sentry_minigun_mp";
	level.var_3C68[param_00].targetname = "sentry_minigun_mp";
}

//Function Number: 11
func_3C7E(param_00)
{
	level.var_3C68[param_00].ammo = 800;
	level.var_3C68[param_00].var_3C70 = 0;
	level.var_3C68[param_00].var_3C71 = 10;
	level.var_3C68[param_00].var_3C72 = 30;
	level.var_3C68[param_00].var_3C73 = 1;
	level.var_3C68[param_00].var_3C74 = 2.6;
	level.var_3C68[param_00].var_3C75 = 0;
	level.var_3C68[param_00].model = "sentry_minigun_weak";
	level.var_3C68[param_00].var_3C76 = "sentry_minigun_weak_destroyed";
	level.var_3C68[param_00].var_3C77 = "sentry_minigun_weak_folded";
	level.var_3C68[param_00].var_3C78 = "sentry_minigun_weak_folded_obj";
	level.var_3C68[param_00].var_3C79 = "sentry_minigun_weak_obj";
	level.var_3C68[param_00].var_3C7A = "sentry_minigun_weak_obj_red";
	level.var_3C68[param_00].health = int(95);
	if(common_scripts\utility::issp())
	{
		level.var_3C68[param_00].var_3C7B = 15;
		level.var_3C68[param_00].anim_loop = %minigun_spin_loop;
		level.var_3C68[param_00].weaponinfo = "sentry_minigun_weak";
		level.var_3C68[param_00].targetname = "sentry_minigun_weak";
		return;
	}

	level.var_3C68[param_00].var_3C7B = 5;
	level.var_3C68[param_00].weaponinfo = "sentry_minigun_mp";
	level.var_3C68[param_00].targetname = "sentry_minigun_mp";
}

//Function Number: 12
func_3C7F(param_00)
{
	self setmodel(self.model);
	self.sentrytype = param_00;
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"SENTRY_PICKUP");
	self makeusable();
	thread func_3CBA(param_00);
}

//Function Number: 13
givesentry(param_00)
{
	self.last_sentry = param_00;
	thread func_3CAE(param_00);
}

//Function Number: 14
func_3C80(param_00,param_01,param_02)
{
	if(common_scripts\utility::issp())
	{
		level.var_3C81 = 1;
		level.var_3C82 = 1;
		if(!isdefined(level.var_3C83))
		{
			level.var_3C83 = 5;
		}

		if(!isdefined(level.var_3C84))
		{
			level.var_3C84 = 2;
		}
	}

	if(!isdefined(param_00))
	{
		if(!isdefined(self.script_team))
		{
			self.script_team = "axis";
		}

		param_00 = self.script_team;
	}

	self setturretmodechangewait(1);
	func_3CBF();
	self maketurretinoperable();
	func_3CC1();
	self setcandamage(1);
	self setdefaultdroppitch(-89);
	if(common_scripts\utility::issp() || level.teambased || is_survival())
	{
		self setturretteam(param_00);
	}

	self.sentrytype = param_01;
	self.issentrygun = 1;
	self.var_3C85 = 350;
	self.var_3C86 = 400;
	self.var_3C87 = 60;
	self.var_3C88 = level.var_3C68[self.sentrytype].ammo;
	if(common_scripts\utility::issp())
	{
		if(self.weaponinfo == "sentry_gun")
		{
			self.bullet_armor = 2000;
		}
		else
		{
			self.bullet_armor = 1200;
		}
	}
	else if(self.weaponinfo == "sentry_gun")
	{
		self.bullet_armor = 300;
	}
	else
	{
		self.bullet_armor = 300;
	}

	if(common_scripts\utility::issp())
	{
		self [[ level.makeentitysentient_func ]](param_00);
		common_scripts\utility::self_func("seanimtree",#animtree);
		if(isdefined(self.script_team) && self.script_team == "axis")
		{
			thread func_3CBD();
		}
	}

	self.health = level.var_3C68[param_01].health;
	func_3C90();
	thread func_3CAD();
	thread func_3C96();
	thread func_3C89();
	if(!common_scripts\utility::issp())
	{
		thread func_3CD4();
		thread func_3CD3();
	}

	thread func_3CBB();
	if(getdvarint("survival_chaos") != 1)
	{
		thread func_3C8F();
	}

	if(!isdefined(param_02))
	{
		if(common_scripts\utility::issp())
		{
			param_02 = level.player;
		}
	}

	func_3CC8(param_02);
	thread func_3CCA(param_02);
	if(!isdefined(self.damage_functions))
	{
		self.damage_functions = [];
	}
}

//Function Number: 15
func_3C89()
{
	self endon("deleted");
	self waittill("death",var_00,var_01,var_02);
	level notify("a_sentry_died");
	if(isdefined(var_00) && isdefined(var_00.team) && self.team != var_00.team && isdefined(level.stat_track_kill_func))
	{
		var_00 [[ level.stat_track_kill_func ]](self,var_01,var_02);
	}

	if(!common_scripts\utility::issp())
	{
		removefromturretlist();
		thread func_3CC7();
	}

	thread func_3CA1();
	thread func_3CD7();
	self setmodel(level.var_3C68[self.sentrytype].var_3C76);
	func_3CC3();
	if(common_scripts\utility::issp())
	{
		self [[ level.freeentitysentient_func ]]();
	}

	if(!common_scripts\utility::issp() && isdefined(var_00) && isplayer(var_00))
	{
		if(isdefined(self.owner))
		{
			self.owner thread [[ level.leaderdialogonplayer_func ]]("destroy_sentry","sentry_status");
		}

		var_00 thread [[ level.onxpevent ]]("kill");
	}

	self setsentrycarrier(undefined);
	self.carrier = undefined;
	self setcandamage(1);
	self.ignoreme = 1;
	self makeunusable();
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	self playsound("sentry_explode");
	playfxontag(common_scripts\utility::getfx("sentry_turret_explode"),self,"tag_aim");
	if(common_scripts\utility::issp() && !isdefined(self.var_3C8A) || !self.var_3C8A)
	{
		self setcontents(0);
	}

	wait 1.5;
	self playsound("sentry_explode_smoke");
	var_03 = level.var_3C68[self.sentrytype].var_3C7B * 1000;
	var_04 = gettime();
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("sentry_turret_explode_smoke"),self,"tag_aim");
		wait 0.4;
		if(gettime() - var_04 > var_03)
		{
			break;
		}
	}

	level.placed_sentry = common_scripts\utility::array_remove(level.placed_sentry,self);
	if(!common_scripts\utility::issp() || getdvar("specialops") == "1")
	{
		thread func_3CCE();
	}
}

//Function Number: 16
func_3C8B(param_00)
{
	level endon("game_ended");
	self endon("sentry_placement_finished");
	self waittill("death");
	if(common_scripts\utility::issp())
	{
		param_00 notify("death");
		return;
	}

	if(!self.var_3C8C)
	{
		param_00 func_3CC7();
		param_00 notify("deleted");
		waittillframeend;
		param_00 delete();
		return;
	}

	if(!common_scripts\utility::issp())
	{
		thread func_3C94(param_00);
	}
}

//Function Number: 17
func_3C8D(param_00)
{
	level endon("game_ended");
	self endon("sentry_placement_finished");
	self waittill("disconnect");
	param_00 notify("death");
}

//Function Number: 18
func_3C8E(param_00)
{
	level endon("game_ended");
	self endon("sentry_placement_finished");
	self waittill("sentry_placement_canceled");
	param_00 func_3CC7();
	func_3CB9();
	param_00 notify("death");
}

//Function Number: 19
func_3C8F()
{
	level endon("game_ended");
	self endon("death");
	if(self.health <= 0)
	{
		return;
	}

	self makeusable();
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isdefined(var_00.placingsentry))
		{
			continue;
		}

		if(!common_scripts\utility::issp())
		{
		}

		break;
	}

	var_00 thread func_3C8E(self);
	var_00 thread func_3C8B(self);
	var_00 thread func_3C8D(self);
	var_00 thread func_3CB1(self);
	if(!common_scripts\utility::issp() && !isalive(var_00))
	{
		return;
	}

	if(!common_scripts\utility::issp())
	{
		func_3CC6();
	}

	func_3CC3();
	var_00.placingsentry = self;
	self setsentrycarrier(var_00);
	self.carrier = var_00;
	self.ignoreme = 1;
	self setcandamage(0);
	self makeunusable();
	var_00 common_scripts\utility::_disableweapon();
	func_3CC0();
	func_3C92();
	var_00 thread func_3C93(self);
	var_00 thread func_3CB5(self);
}

//Function Number: 20
func_3C90()
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	self.var_3C91 = "" + gettime();
	[[ level.badplace_cylinder_func ]](self.var_3C91,0,self.origin,32,128,self.team,"neutral");
}

//Function Number: 21
func_3C92()
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	[[ level.badplace_delete_func ]](self.var_3C91);
	self.var_3C91 = undefined;
}

//Function Number: 22
func_3C93(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("deleted");
	self endon("death");
	self endon("disconnect");
	param_00 notify("sentry_move_started",self);
	self.carrying_pickedup_sentry = 1;
	for(;;)
	{
		func_3CBE(0);
		func_3CBE(1);
		func_3CB6(param_00);
		if(self.var_3C8C)
		{
			break;
		}
	}

	param_00 notify("sentry_move_finished",self);
	self.carrying_pickedup_sentry = 0;
	func_3C94(param_00);
}

//Function Number: 23
func_3C94(param_00)
{
	if(!common_scripts\utility::issp())
	{
		self endon("death");
		level endon("end_game");
	}

	self.placingsentry = undefined;
	param_00 setsentrycarrier(undefined);
	param_00.carrier = undefined;
	param_00 setcandamage(1);
	param_00.ignoreme = 0;
	common_scripts\utility::_enableweapon();
	param_00 func_3CBF();
	param_00 setmodel(level.var_3C68[param_00.sentrytype].model);
	param_00 func_3C90();
	param_00 setcontents(param_00.var_3C95);
	param_00 func_3CC8(self);
	self notify("sentry_placement_finished",param_00);
	param_00 notify("sentry_carried");
	param_00.overheated = 0;
	func_3CB9();
	if(!common_scripts\utility::issp())
	{
		param_00 func_3CC5();
	}

	param_00 func_3CC1();
	thread common_scripts\utility::play_sound_in_space("sentry_gun_plant",param_00.origin);
	func_3CBE(0);
	if(getdvarint("survival_chaos") != 1)
	{
		param_00 thread func_3C8F();
	}
}

//Function Number: 24
func_3C96()
{
	level endon("game_ended");
	self endon("death");
	thread func_3C97();
	for(;;)
	{
		common_scripts\utility::waittill_either("turretstatechange","cooled");
		if(self isfiringturret())
		{
			thread func_3C9D();
			thread func_3CD6();
			continue;
		}

		thread func_3CA1();
		thread func_3CD7();
	}
}

//Function Number: 25
func_3C97()
{
	self endon("death");
	if(self.sentrytype != "sentry_minigun")
	{
		return;
	}

	if(!isdefined(level.var_3C81))
	{
		return;
	}

	self.overheat = 0;
	self.overheated = 0;
	if(getdvarint("sentry_overheat_debug") == 1)
	{
		thread func_3C9A();
	}

	for(;;)
	{
		if(self.overheat >= level.var_3C83 * 10)
		{
			thread func_3C9B();
			common_scripts\utility::waittill_either("cooled","sentry_carried");
		}

		if(self isfiringturret())
		{
			self.overheat = self.overheat + 1;
		}
		else if(self.overheat > 0)
		{
			self.overheat = self.overheat - 1;
		}

		wait 0.1 / level.var_3C81;
	}
}

//Function Number: 26
func_3C99()
{
	self endon("death");
	while(self.overheated)
	{
		if(self.overheat > 0)
		{
			self.overheat = self.overheat - 1;
		}

		wait 0.1 / level.var_3C81;
	}
}

//Function Number: 27
func_3C9A()
{
	self endon("death");
	for(;;)
	{
		var_00 = self.overheat / level.var_3C83 * 10;
		var_01 = "[ ";
		var_02 = " ]";
		if(self.overheated)
		{
			var_01 = "{{{ ";
			var_02 = " }}}";
		}

		wait 0.2;
	}
}

//Function Number: 28
func_3C9B()
{
	self endon("death");
	self notify("overheated");
	self.overheated = 1;
	func_3CA1();
	thread func_3C9C();
}

//Function Number: 29
func_3C9C()
{
	self endon("death");
	self endon("sentry_carried");
	thread func_3C99();
	wait level.var_3C84;
	self notify("cooled");
	self.overheat = 0;
	self.overheated = 0;
}

//Function Number: 30
func_3C9D()
{
	self endon("death");
	level endon("game_ended");
	if(level.var_3C68[self.sentrytype].var_3C75)
	{
		self waittill("turret_on_target");
	}

	if(isdefined(self.overheated) && self.overheated)
	{
		return;
	}

	thread func_3CA5();
	self endon("stop_shooting");
	self notify("shooting");
	var_00 = weaponfiretime(self.weaponinfo);
	for(;;)
	{
		func_3CA3();
		var_01 = randomintrange(level.var_3C68[self.sentrytype].var_3C71,level.var_3C68[self.sentrytype].var_3C72);
		for(var_02 = 0;var_02 < var_01;var_02++)
		{
			if(func_3CA0())
			{
				self shootturret();
			}

			self notify("bullet_fired");
			wait var_00;
		}

		wait randomfloatrange(level.var_3C68[self.sentrytype].var_3C73,level.var_3C68[self.sentrytype].var_3C74);
	}
}

//Function Number: 31
func_3C9E(param_00,param_01)
{
	self notify("allowFireThread");
	self endon("allowFireThread");
	self endon("death");
	self.var_3C9F = param_00;
	if(isdefined(param_01) && !param_00)
	{
		wait param_01;
		if(isdefined(self))
		{
			thread func_3C9E(1);
		}
	}
}

//Function Number: 32
func_3CA0()
{
	if(!isdefined(self.var_3C9F))
	{
		return 1;
	}

	return self.var_3C9F;
}

//Function Number: 33
func_3CA1()
{
	thread func_3CA9();
	self notify("stop_shooting");
	thread func_3CA2();
}

//Function Number: 34
func_3CA2()
{
	self endon("shooting");
	self endon("deleted");
	wait randomfloatrange(0,1);
	var_00 = 6000;
	var_01 = gettime();
	if(isdefined(self))
	{
		self playsound("sentry_steam");
	}

	while(isdefined(self))
	{
		playfxontag(common_scripts\utility::getfx("sentry_turret_overheat_smoke_sp"),self,"tag_flash");
		wait 0.3;
		if(gettime() - var_01 > var_00)
		{
			break;
		}
	}
}

//Function Number: 35
func_3CA3()
{
	if(isdefined(self.var_3CA4) && self.var_3CA4 == 0)
	{
		self waittill("allow_fire");
	}
}

//Function Number: 36
func_3CA5()
{
	self notify("anim_state_change");
	self endon("anim_state_change");
	self endon("stop_shooting");
	self endon("deleted");
	level endon("game_ended");
	self endon("death");
	if(!isdefined(level.var_3C68[self.sentrytype].anim_loop))
	{
		return;
	}

	self.var_3CA4 = 0;
	if(!isdefined(self.momentum))
	{
		self.momentum = 0;
	}

	thread func_3CAA();
	for(;;)
	{
		if(self.momentum >= 1)
		{
			break;
		}

		self.momentum = self.momentum + 0.1;
		self.momentum = clamp(self.momentum,0,1);
		if(common_scripts\utility::issp())
		{
			common_scripts\utility::self_func("setanim",level.var_3C68[self.sentrytype].anim_loop,1,0.2,self.momentum);
		}

		wait 0.2;
	}

	self.var_3CA4 = 1;
	self notify("allow_fire");
}

//Function Number: 37
func_3CA6()
{
	self notify("deleted");
	wait 0.05;
	self notify("death");
	if(isdefined(self.var_3CA7))
	{
		self.var_3CA7 delete();
	}

	if(isdefined(self.var_3CA8))
	{
		self.var_3CA8 delete();
	}

	self delete();
}

//Function Number: 38
func_3CA9()
{
	self notify("anim_state_change");
	self endon("anim_state_change");
	if(!isdefined(level.var_3C68[self.sentrytype].anim_loop))
	{
		return;
	}

	thread func_3CAC();
	self.var_3CA4 = 0;
	for(;;)
	{
		if(!isdefined(self.momentum))
		{
			break;
		}

		if(self.momentum <= 0)
		{
			break;
		}

		self.momentum = self.momentum - 0.1;
		self.momentum = clamp(self.momentum,0,1);
		if(common_scripts\utility::issp())
		{
			common_scripts\utility::self_func("setanim",level.var_3C68[self.sentrytype].anim_loop,1,0.2,self.momentum);
		}

		wait 0.2;
	}
}

//Function Number: 39
func_3CAA()
{
	self notify("sound_state_change");
	self endon("sound_state_change");
	self endon("deleted");
	if(self.momentum < 0.25)
	{
		self playsound("sentry_minigun_spinup1");
		wait 0.6;
		self playsound("sentry_minigun_spinup2");
		wait 0.5;
		self playsound("sentry_minigun_spinup3");
		wait 0.5;
		self playsound("sentry_minigun_spinup4");
		wait 0.5;
	}
	else if(self.momentum < 0.5)
	{
		self playsound("sentry_minigun_spinup2");
		wait 0.5;
		self playsound("sentry_minigun_spinup3");
		wait 0.5;
		self playsound("sentry_minigun_spinup4");
		wait 0.5;
	}
	else if(self.momentum < 0.75)
	{
		self playsound("sentry_minigun_spinup3");
		wait 0.5;
		self playsound("sentry_minigun_spinup4");
		wait 0.5;
	}
	else if(self.momentum < 1)
	{
		self playsound("sentry_minigun_spinup4");
		wait 0.5;
	}

	thread func_3CAB();
}

//Function Number: 40
func_3CAB()
{
	self endon("death");
	self notify("sound_state_change");
	self endon("sound_state_change");
	for(;;)
	{
		self playsound("sentry_minigun_spin");
		wait 2.5;
	}
}

//Function Number: 41
func_3CAC()
{
	self notify("sound_state_change");
	self endon("sound_state_change");
	self endon("deleted");
	if(!isdefined(self.momentum))
	{
		return;
	}

	if(self.momentum > 0.75)
	{
		self stopsounds();
		self playsound("sentry_minigun_spindown4");
		wait 0.5;
		self playsound("sentry_minigun_spindown3");
		wait 0.5;
		self playsound("sentry_minigun_spindown2");
		wait 0.5;
		self playsound("sentry_minigun_spindown1");
		wait 0.65;
		return;
	}

	if(self.momentum > 0.5)
	{
		self playsound("sentry_minigun_spindown3");
		wait 0.5;
		self playsound("sentry_minigun_spindown2");
		wait 0.5;
		self playsound("sentry_minigun_spindown1");
		wait 0.65;
		return;
	}

	if(self.momentum > 0.25)
	{
		self playsound("sentry_minigun_spindown2");
		wait 0.5;
		self playsound("sentry_minigun_spindown1");
		wait 0.65;
		return;
	}

	self playsound("sentry_minigun_spindown1");
	wait 0.65;
}

//Function Number: 42
func_3CAD()
{
	self endon("death");
	for(;;)
	{
		wait randomfloatrange(3.5,4.5);
		thread common_scripts\utility::play_sound_in_space("sentry_gun_beep",self.origin + (0,0,40));
	}
}

//Function Number: 43
func_3CAE(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(isdefined(self.placingsentry))
	{
		return undefined;
	}

	common_scripts\utility::_disableweapon();
	self notify("placingSentry");
	self.sentry_placement_failed = undefined;
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = spawnturret("misc_turret",param_01,level.var_3C68[param_00].weaponinfo);
	var_04 setmodel(level.var_3C68[param_00].var_3C79);
	var_04.weaponinfo = level.var_3C68[param_00].weaponinfo;
	var_04.targetname = level.var_3C68[param_00].targetname;
	var_04.weaponname = level.var_3C68[param_00].weaponinfo;
	var_04.angles = param_02;
	var_04.team = self.team;
	var_04.attacker = self;
	var_04.sentrytype = param_00;
	var_04 maketurretinoperable();
	var_04 func_3CC3();
	var_04 setcandamage(0);
	var_04 func_3CC8(self);
	var_04 setdefaultdroppitch(-89);
	self.placingsentry = var_04;
	var_04 setsentrycarrier(self);
	var_04.carrier = self;
	var_04 setcandamage(0);
	var_04.ignoreme = 1;
	if(!common_scripts\utility::issp())
	{
		var_04 addtoturretlist();
	}

	if(!param_03)
	{
		thread func_3CB0(var_04);
		thread func_3CB1(var_04);
	}

	thread func_3CB3(var_04,param_03);
	if(!param_03)
	{
		thread func_3CB5(var_04);
		if(!common_scripts\utility::issp())
		{
			common_scripts\utility::waittill_any("sentry_placement_finished","sentry_placement_canceled","death");
		}
		else
		{
			common_scripts\utility::waittill_any("sentry_placement_finished","sentry_placement_canceled");
		}
	}

	func_3CB9();
	common_scripts\utility::_enableweapon();
	self.placingsentry = undefined;
	self setcandamage(1);
	var_04 setsentrycarrier(undefined);
	var_04.carrier = undefined;
	var_04.ignoreme = 0;
	if(is_survival())
	{
		waittillframeend;
		if(isdefined(self.sentry_placement_failed) && self.sentry_placement_failed)
		{
			return undefined;
		}
	}

	level.placed_sentry[level.placed_sentry.size] = var_04;
	self notify("new_sentry",var_04);
	return var_04;
}

//Function Number: 44
func_3CB0(param_00)
{
	self endon("sentry_placement_finished");
	if(!common_scripts\utility::issp())
	{
		common_scripts\utility::waittill_any("sentry_placement_canceled","death","disconnect");
	}
	else
	{
		common_scripts\utility::waittill_any("sentry_placement_canceled");
	}

	if(is_survival())
	{
		self.sentry_placement_failed = 1;
	}

	waittillframeend;
	param_00 delete();
}

//Function Number: 45
func_3CB1(param_00)
{
	self endon("sentry_placement_finished");
	if(common_scripts\utility::issp())
	{
		return;
	}

	level waittill("game_ended");
	if(!isdefined(param_00))
	{
		return;
	}

	if(!self.var_3C8C)
	{
		param_00 notify("deleted");
		waittillframeend;
		param_00 delete();
		return;
	}

	thread func_3C94(param_00);
}

//Function Number: 46
func_3CB2()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("restock_reset");
	self notifyonplayercommand("cancel sentry","+actionslot 4");
	common_scripts\utility::waittill_any("death","cancel sentry");
	self notify("sentry_placement_canceled");
}

//Function Number: 47
func_3CB3(param_00,param_01)
{
	level endon("game_ended");
	self endon("sentry_placement_canceled");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!common_scripts\utility::issp())
	{
		self endon("disconnect");
		param_00 thread func_3CD0();
		thread func_3CB2();
	}

	if(!param_01)
	{
		param_00 makeunusable();
		while(self usebuttonpressed())
		{
			wait 0.05;
		}

		for(;;)
		{
			func_3CBE(0);
			func_3CBE(1);
			func_3CB6(param_00);
			if(self.var_3C8C)
			{
				break;
			}
		}
	}

	if(!common_scripts\utility::issp())
	{
		self notify("restock_reset");
	}

	if(!common_scripts\utility::issp())
	{
		param_00.lifeid = self.lifeid;
		func_3CC4(param_00);
	}

	thread common_scripts\utility::play_sound_in_space("sentry_gun_plant",param_00.origin);
	param_00 setmodel(level.var_3C68[param_00.sentrytype].model);
	param_00 func_3C80(self.team,param_00.sentrytype,self);
	self notify("sentry_placement_finished",param_00);
	if(!param_01)
	{
		waittillframeend;
	}

	if(isdefined(level.var_3CB4) && level.var_3CB4)
	{
		param_00 thread func_3CCC();
	}

	if(!common_scripts\utility::issp())
	{
		param_00 thread func_3CCB();
	}
}

//Function Number: 48
func_3CB5(param_00)
{
	level endon("game_ended");
	param_00 notify("sentry_placement_started");
	self endon("sentry_placement_canceled");
	self endon("sentry_placement_finished");
	param_00 endon("death");
	param_00 endon("deleted");
	if(!common_scripts\utility::issp())
	{
		self endon("disconnect");
		self endon("death");
	}

	for(;;)
	{
		func_3CB6(param_00);
		wait 0.05;
	}
}

//Function Number: 49
func_3CB6(param_00)
{
	var_01 = self canplayerplacesentry();
	param_00.origin = var_01["origin"];
	param_00.angles = var_01["angles"];
	self.var_3C8C = self isonground() && var_01["result"];
	func_3CB7(self.var_3C8C);
	if(self.var_3C8C)
	{
		param_00 setmodel(level.var_3C68[param_00.sentrytype].var_3C79);
		return;
	}

	param_00 setmodel(level.var_3C68[param_00.sentrytype].var_3C7A);
}

//Function Number: 50
func_3CB7(param_00)
{
	if(isdefined(self.var_3CB8) && self.var_3CB8 == param_00)
	{
		return;
	}

	self.var_3CB8 = param_00;
	if(getdvarint("survival_chaos") == 1)
	{
		if(self.var_3CB8)
		{
			self notify("sentry_notification",&"SENTRY_PLACE");
			return;
		}

		self notify("sentry_notification",&"SENTRY_CANNOT_PLACE");
		return;
	}

	if(self.var_3CB8)
	{
		self forceusehinton(&"SENTRY_PLACE");
		return;
	}

	self forceusehinton(&"SENTRY_CANNOT_PLACE");
}

//Function Number: 51
func_3CB9()
{
	if(!isdefined(self.var_3CB8))
	{
		return;
	}

	if(getdvarint("survival_chaos") == 1)
	{
		self notify("sentry_notification");
	}
	else
	{
		self forceusehintoff();
	}

	self.var_3CB8 = undefined;
}

//Function Number: 52
func_3CBA(param_00)
{
	self.var_3CA7 = spawn("script_model",self.origin);
	self.var_3CA7.angles = self.angles;
	self.var_3CA7 setmodel(level.var_3C68[param_00].var_3C78);
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isdefined(var_01.placingsentry))
		{
			continue;
		}

		if(!common_scripts\utility::issp())
		{
			if(var_01 != self.owner)
			{
				continue;
			}
		}

		break;
	}

	thread common_scripts\utility::play_sound_in_space("sentry_pickup");
	self.var_3CA7 delete();
	self delete();
	var_01 thread func_3CAE(param_00);
}

//Function Number: 53
func_3CBB()
{
	self.healthbuffer = 20000;
	self.health = self.health + self.healthbuffer;
	self.currenthealth = self.health;
	var_00 = undefined;
	var_01 = undefined;
	var_02 = 0;
	var_03 = 0;
	var_04 = gettime();
	while(self.health > 0)
	{
		self waittill("damage",var_05,var_00,var_06,var_07,var_01,var_08,var_09);
		if(isdefined(var_00) && !isplayer(var_00))
		{
			var_02 = var_02 + var_05;
			var_03 = var_03 + gettime() - var_04;
			var_04 = gettime();
			if(var_03 < 3000 && var_02 > 300)
			{
				var_0A = 0;
				foreach(var_0C in level.players)
				{
					if(distancesquared(var_0C.origin,self.origin) <= squared(500))
					{
						var_0A = 1;
					}
				}

				if(!var_0A)
				{
					level notify("a_sentry_is_underattack");
				}

				var_02 = 0;
				var_03 = 0;
			}

			if(var_03 >= 3000)
			{
				var_02 = 0;
				var_03 = 0;
			}
		}

		if(!common_scripts\utility::issp() && isdefined(var_00) && isplayer(var_00) && var_00 func_3CD2(self))
		{
			self.health = self.currenthealth;
			return;
		}

		if(isdefined(level.stat_track_damage_func) && isdefined(var_00))
		{
			var_00 [[ level.stat_track_damage_func ]]();
		}

		if(isdefined(var_00) && isplayer(var_00))
		{
			if(!common_scripts\utility::issp())
			{
				var_00 [[ level.func["damagefeedback"] ]]("false");
			}

			thread func_3C9E(0,2);
		}

		if(func_3CBC(var_01,var_00))
		{
			self.health = self.currenthealth;
			self.bullet_armor = self.bullet_armor - var_05;
			continue;
		}

		self.currenthealth = self.health;
		if(self.health < self.healthbuffer)
		{
			break;
		}
	}

	if(!common_scripts\utility::issp() && var_00 func_3CD1(self))
	{
		var_00 thread [[ level.onxpevent ]]("kill");
	}

	self notify("death",var_00,var_01);
}

//Function Number: 54
func_3CBC(param_00,param_01)
{
	if(isdefined(param_01) && isai(param_01) && isdefined(param_01.juggernaut) && param_01.juggernaut)
	{
		return 0;
	}

	if(self.bullet_armor <= 0)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!issubstr(param_00,"BULLET"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 55
func_3CBD()
{
	var_00 = "easy";
	self setconvergencetime(level.var_3C69[var_00]["convergencePitchTime"],"pitch");
	self setconvergencetime(level.var_3C69[var_00]["convergenceYawTime"],"yaw");
	self setsuppressiontime(level.var_3C69[var_00]["suppressionTime"]);
	self setaispread(level.var_3C69[var_00]["aiSpread"]);
	self setplayerspread(level.var_3C69[var_00]["playerSpread"]);
	self.maxrange = 1100;
	self.bullet_armor = 0;
}

//Function Number: 56
func_3CBE(param_00)
{
	if(!common_scripts\utility::issp())
	{
		self endon("death");
		self endon("disconnect");
	}

	if(param_00 == 1)
	{
		while(!self attackbuttonpressed() && !self usebuttonpressed())
		{
			wait 0.05;
		}

		return;
	}

	if(param_00 == 0)
	{
		while(self attackbuttonpressed() || self usebuttonpressed())
		{
			wait 0.05;
		}
	}
}

//Function Number: 57
func_3CBF()
{
	self maketurretsolid();
}

//Function Number: 58
func_3CC0()
{
	self.var_3C95 = self setcontents(0);
}

//Function Number: 59
func_3CC1()
{
	if(!issentient(self) && isdefined(self.owner) && isdefined(self.owner.team))
	{
		self [[ level.makeentitysentient_func ]](self.owner.team);
	}

	self setmode("sentry");
	self.var_3CC2 = 1;
}

//Function Number: 60
func_3CC3()
{
	if(issentient(self))
	{
		self [[ level.freeentitysentient_func ]]();
	}

	self setmode("sentry_offline");
	self.var_3CC2 = 0;
}

//Function Number: 61
func_3CC4(param_00)
{
	if(isdefined(self.pers["team"]))
	{
		param_00.pers["team"] = self.pers["team"];
	}

	param_00 func_3CC5();
}

//Function Number: 62
func_3CC5()
{
	var_00 = (0,0,65);
	if(self.sentrytype == "sentry_gun")
	{
		var_00 = (0,0,75);
	}

	self [[ level.func["setTeamHeadIcon"] ]](self.pers["team"],var_00);
}

//Function Number: 63
func_3CC6()
{
	self [[ level.func["setTeamHeadIcon"] ]]("none",(0,0,0));
}

//Function Number: 64
func_3CC7()
{
	if(!isdefined(self.carrier))
	{
		return;
	}

	self.carrier notify("sentry_placement_canceled");
	self.carrier common_scripts\utility::_enableweapon();
	self.carrier.placingsentry = undefined;
	self setsentrycarrier(undefined);
	self.carrier = undefined;
	self setcandamage(1);
	self.ignoreme = 0;
}

//Function Number: 65
func_3CC8(param_00)
{
	if(isdefined(self.owner) && self.owner == param_00)
	{
		return;
	}

	param_00.var_3CC9 = self;
	self.owner = param_00;
	self setsentryowner(param_00);
	self setturretminimapvisible(1);
}

//Function Number: 66
func_3CCA(param_00)
{
	level endon("game_ended");
	self endon("death");
	param_00 common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 67
func_3CCB()
{
	level endon("game_ended");
	self endon("death");
	self endon("deleted");
	self notify("battery_count_started");
	self endon("battery_count_started");
	while(self.var_3C87 >= 0)
	{
		if(self.var_3CC2)
		{
			self.var_3C87 = self.var_3C87 - 1;
		}

		wait 1;
	}

	self notify("death");
}

//Function Number: 68
func_3CCC()
{
	level endon("game_ended");
	self endon("death");
	self endon("deleted");
	self notify("ammo_count_started");
	self endon("ammo_count_started");
	thread func_3CCD();
	while(self.var_3C88 >= 0)
	{
		self waittill("bullet_fired");
		self.var_3C88 = self.var_3C88 - 1;
	}

	thread func_3CA1();
	thread func_3CD7();
	wait 1;
	func_3CC3();
	wait 5;
	self notify("death");
}

//Function Number: 69
func_3CCD()
{
	self endon("death");
	for(;;)
	{
		var_00 = level.var_3C68[self.sentrytype].ammo;
		var_01 = self.var_3C88;
		var_02 = var_01 / var_00;
		var_03 = "Ammo: " + var_01 + "/" + var_00;
		var_04 = level.var_3C68[self.sentrytype].health;
		var_05 = self.health - self.healthbuffer;
		var_06 = var_05 / var_04;
		var_07 = "Health: " + var_05 + "/" + var_04;
		wait 0.05;
	}
}

//Function Number: 70
func_3CCE()
{
	if(isdefined(self.var_3CCF) && self.var_3CCF)
	{
		return;
	}

	func_3CA6();
}

//Function Number: 71
func_3CD0()
{
	self endon("death");
	self endon("deleted");
	self.owner common_scripts\utility::waittill_any("death","disconnect");
	if(isdefined(self.owner.placingsentry) && self.owner.placingsentry == self)
	{
		self.owner.placingsentry = undefined;
		self setsentrycarrier(undefined);
		self.carrier = undefined;
		self setcandamage(1);
		self.ignoreme = 0;
		self notify("death");
	}
}

//Function Number: 72
func_3CD1(param_00)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isplayer(self))
	{
		return 0;
	}

	if(!isdefined(level.onxpevent))
	{
		return 0;
	}

	if(!isdefined(self.pers["team"]))
	{
		return 0;
	}

	if(!isdefined(param_00.team))
	{
		return 0;
	}

	if(!level.teambased && self == param_00.owner)
	{
		return 0;
	}

	if(level.teambased && self.pers["team"] == param_00.team)
	{
		return 0;
	}

	return 1;
}

//Function Number: 73
func_3CD2(param_00)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isplayer(self))
	{
		return 0;
	}

	if(!level.teambased)
	{
		return 0;
	}

	if(self == param_00.owner)
	{
		return 0;
	}

	if(self.team != param_00.team)
	{
		return 0;
	}

	return 1;
}

//Function Number: 74
func_3CD3()
{
	self endon("deleted");
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		thread func_3CA1();
		thread func_3CD7();
		func_3CC3();
		playfxontag(common_scripts\utility::getfx("sentry_turret_explode"),self,"tag_aim");
		wait var_01;
		func_3CC1();
	}
}

//Function Number: 75
func_3CD4()
{
	self endon("deleted");
	self endon("death");
	for(;;)
	{
		level waittill("emp_update");
		if(level.teamemped[self.team])
		{
			thread func_3CA1();
			thread func_3CD7();
			func_3CC3();
			playfxontag(common_scripts\utility::getfx("sentry_turret_explode"),self,"tag_aim");
			continue;
		}

		func_3CC1();
	}
}

//Function Number: 76
addtoturretlist()
{
	level.turrets[self getentitynumber()] = self;
}

//Function Number: 77
removefromturretlist()
{
	level.turrets[self getentitynumber()] = undefined;
}

//Function Number: 78
func_3CD5(param_00,param_01,param_02,param_03)
{
	param_00 endon(param_01);
	param_02 endon(param_03);
	level waittill("hell_freezes_over_AND_THEN_thaws_out");
}

//Function Number: 79
func_3CD6()
{
	if(!level.var_3C68[self.sentrytype].var_3C70)
	{
		return;
	}

	if(!isdefined(level.laseron_func))
	{
		return;
	}

	self [[ level.laseron_func ]]();
}

//Function Number: 80
func_3CD7()
{
	if(!level.var_3C68[self.sentrytype].var_3C70)
	{
		return;
	}

	if(!isdefined(level.laseroff_func))
	{
		return;
	}

	self [[ level.laseroff_func ]]();
}

//Function Number: 81
is_specialop()
{
	return getdvarint("specialops") >= 1;
}

//Function Number: 82
is_survival()
{
	return is_specialop() && getdvarint("so_survival") > 0;
}