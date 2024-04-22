/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_explosive_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 155 ms
 * Timestamp: 4/22/2024 2:13:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["zed_explode"] = loadfx("vfx/explosion/explosive_drone_explosion");
	level._effect["zed_beacon"] = loadfx("vfx/test/zombie_explosive_drone_beacon");
	level.zed_active = [];
	maps\mp\zombies\weapons\_zombie_weapons::addplaceableminetype("explosive_drone_zombie_mp");
	maps\mp\zombies\weapons\_zombie_weapons::addplaceableminetype("explosive_drone_throw_zombie_mp");
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "explosive_drone_zombie_mp" || var_02 == "explosive_drone_throw_zombie_mp")
		{
			var_00.team = self.team;
			var_00.activated = 0;
			if(!isdefined(var_00.owner))
			{
				var_00.owner = self;
			}

			if(!isdefined(var_00.weaponname))
			{
				var_00.weaponname = var_01;
			}

			level.zed_active[level.zed_active.size] = var_00;
			var_00 thread watchowner();
			var_00 thread watchforstick();
		}
	}
}

//Function Number: 3
watchowner()
{
	self endon("death");
	self.owner waittill("disconnect");
	self delete();
}

//Function Number: 4
watchforstick()
{
	self endon("death");
	self.owner endon("death");
	self.owner endon("disconnect");
	self waittill("missile_stuck",var_00);
	if(isdefined(var_00))
	{
		self linkto(var_00);
	}

	self.explosive = spawn("script_model",self.origin);
	self.explosive setmodel("npc_drone_explosive_main");
	self.explosive linkto(self,"tag_spike",(0,0,0),(0,0,0));
	level.zed_active = common_scripts\utility::array_removeundefined(level.zed_active);
	if(level.zed_active.size > 8)
	{
		level.zed_active[0] activategrenade();
	}

	wait 0.05;
	thread beaconfx();
	thread triggerthink();
	thread pickupthink();
	if(isdefined(var_00) && maps\mp\zombies\_util::is_true(var_00.activateexplosivedrone))
	{
		activategrenade();
	}
}

//Function Number: 5
beaconfx()
{
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zed_beacon"),self.explosive,"TAG_BEACON");
}

//Function Number: 6
triggerthink()
{
	self endon("death");
	var_00 = 80;
	var_01 = spawn("trigger_radius",self.origin - (0,0,var_00),0,var_00,2 * var_00);
	var_01 thread maps\mp\zombies\_util::delete_on_death_of(self);
	var_01 enablelinkto();
	var_01 linkto(self);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(var_02.team == self.team)
		{
			continue;
		}

		var_03 = anglestoup(self.angles);
		if(var_02 damageconetrace(self.origin + var_03 * 10) == 0)
		{
			continue;
		}

		thread activategrenade();
		break;
	}
}

//Function Number: 7
activategrenade()
{
	if(self.activated)
	{
		return;
	}

	self.activated = 1;
	var_00 = self.explosive;
	self playsoundonmovingent("wpn_explosive_drone_open");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("zed_beacon"),var_00,"TAG_BEACON");
	droneanimate();
	var_01 = var_00.origin + (0,0,5);
	var_00 setmodel("tag_origin");
	playfxontag(common_scripts\utility::getfx("zed_explode"),var_00,"tag_origin");
	var_00 playsoundonmovingent("wpn_explosive_drone_exp");
	self radiusdamage(var_01,200,200,50,self.owner,"MOD_EXPLOSIVE","explosive_drone_zombie_mp");
	self delete();
	wait(1);
	var_00 delete();
}

//Function Number: 8
droneanimate()
{
	self.explosive endon("death");
	var_00 = 0.7;
	var_01 = anglestoup(self.angles);
	self.explosive unlink();
	self.explosive moveto(self.origin + var_01 * 30,var_00,0,var_00);
	wait(var_00);
}

//Function Number: 9
pickupthink()
{
	self endon("death");
	var_00 = spawn("script_model",self.origin);
	var_00.owner = self.owner;
	var_00 makeusable();
	var_00 sethintstring(&"ZOMBIES_PICKUP_EXPLOSIVE_DRONE");
	var_00 sethintstringvisibleonlytoowner(1);
	var_00 thread maps\mp\zombies\_util::delete_on_death_of(self);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01 != self.owner)
		{
			continue;
		}

		if(var_01 maps\mp\zombies\_terminals::hasexosuit())
		{
			var_01 setweaponammostock("explosive_drone_zombie_mp",var_01 setweaponammostock("explosive_drone_zombie_mp") + 1);
		}
		else
		{
			var_01 setweaponammostock("explosive_drone_throw_zombie_mp",var_01 setweaponammostock("explosive_drone_throw_zombie_mp") + 1);
		}

		if(isdefined(self.explosive))
		{
			self.explosive delete();
		}

		self delete();
	}
}