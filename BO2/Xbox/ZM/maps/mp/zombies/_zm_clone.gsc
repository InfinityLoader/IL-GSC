/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_clone.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 8
 * Decompile Time: 3 ms
 * Timestamp: 10/28/2023 12:14:13 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;

#using_animtree( "zm_ally" );

//Function Number: 1
init()
{
	init_mover_tree();
}

//Function Number: 2
spawn_player_clone(player,origin,forceweapon,forcemodel)
{
	if(!(IsDefined(origin)))
	{
		origin = player.origin;
	}

	primaryweapons = player getweaponslistprimaries();
	if(IsDefined(forceweapon))
	{
		weapon = forceweapon;
	}
	else if(primaryweapons.size)
	{
		weapon = primaryweapons[0];
	}
	else
	{
		weapon = player getcurrentweapon();
	}

	weaponmodel = getweaponmodel(weapon);
	spawner = getent("fake_player_spawner","targetname");
	if(IsDefined(spawner))
	{
		clone = spawner spawnactor();
		clone.origin = origin;
		clone.isactor = 1;
	}
	else
	{
		clone = spawn("script_model",origin);
		clone.isactor = 0;
	}

	if(IsDefined(forcemodel))
	{
		clone setmodel(forcemodel);
	}
	else
	{
		clone setmodel(self.model);
		if(IsDefined(player.headmodel))
		{
			clone.headmodel = player.headmodel;
			clone attach(clone.headmodel,"",1);
		}
	}

	if(weaponmodel != "" && weaponmodel != "none")
	{
		clone attach(weaponmodel,"tag_weapon_right");
	}

	clone.team = player.team;
	clone.is_inert = 1;
	clone.zombie_move_speed = "walk";
	clone.script_noteworthy = "corpse_clone";
	clone.actor_damage_func = ::clone_damage_func;
	return clone;
}

//Function Number: 3
clone_damage_func(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,psoffsettime,boneindex)
{
	idamage = 0;
	if(sweapon == "knife_ballistic_upgraded_zm" || sweapon == "knife_ballistic_bowie_upgraded_zm" || sweapon == "knife_ballistic_no_melee_upgraded_zm" || sweapon == "knife_ballistic_sickle_upgraded_zm")
	{
		self notify("player_revived",eattacker);
	}

	return idamage;
}

//Function Number: 4
clone_give_weapon(weapon)
{
	weaponmodel = getweaponmodel(weapon);
	if(weaponmodel != "" && weaponmodel != "none")
	{
		self attach(weaponmodel,"tag_weapon_right");
	}
}

//Function Number: 5
clone_animate(animtype)
{
	if(self.isactor)
	{
		self thread clone_actor_animate(animtype);
	}
	else
	{
		self thread clone_mover_animate(animtype);
	}
}

//Function Number: 6
clone_actor_animate(animtype)
{
	wait(0.1);
	switch(animtype)
	{
		case "€GSC\r\n":
			self setanimstatefromasd("laststand");
			break;

		case "€GSC\r\n":
		default:
			self setanimstatefromasd("idle");
			break;
	}
}

//Function Number: 7
init_mover_tree()
{
	scriptmodelsuseanimtree(-1);
}

//Function Number: 8
clone_mover_animate(animtype)
{
	self useanimtree(-1);
	switch(animtype)
	{
		case "€GSC\r\n":
			self setanim(%pb_laststand_idle);
			break;

		case "€GSC\r\n":
			self setanim(%pb_afterlife_laststand_idle);
			break;

		case "€GSC\r\n":
			self setanim(%ai_actor_elec_chair_idle);
			break;

		case "€GSC\r\n":
			self setanim(%pb_falling_loop);
			break;

		case "€GSC\r\n":
		default:
			self setanim(%pb_stand_alert);
			break;
	}
}