/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_weap_thundergun.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 241 ms
 * Timestamp: 10/27/2023 3:03:33 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
	if(!(maps/mp/zombies/_zm_weapons::is_weapon_included("thundergun_zm")))
	{
		return;
	}

	level._effect["thundergun_viewmodel_power_cell1"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
	level._effect["thundergun_viewmodel_power_cell2"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
	level._effect["thundergun_viewmodel_power_cell3"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
	level._effect["thundergun_viewmodel_steam"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
	level._effect["thundergun_viewmodel_power_cell1_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
	level._effect["thundergun_viewmodel_power_cell2_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
	level._effect["thundergun_viewmodel_power_cell3_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
	level._effect["thundergun_viewmodel_steam_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
	level._effect["thundergun_knockdown_ground"] = loadfx("weapon/thunder_gun/fx_thundergun_knockback_ground");
	level._effect["thundergun_smoke_cloud"] = loadfx("weapon/thunder_gun/fx_thundergun_smoke_cloud");
	set_zombie_var("thundergun_cylinder_radius",180);
	set_zombie_var("thundergun_fling_range",480);
	set_zombie_var("thundergun_gib_range",900);
	set_zombie_var("thundergun_gib_damage",75);
	set_zombie_var("thundergun_knockdown_range",1200);
	set_zombie_var("thundergun_knockdown_damage",15);
	level.thundergun_gib_refs = [];
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
	level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
	level.basic_zombie_thundergun_knockdown = ::zombie_knockdown;
/#
	level thread thundergun_devgui_dvar_think();
#/
	onplayerconnect_callback(::thundergun_on_player_connect);
}

//Function Number: 2
thundergun_devgui_dvar_think()
{
/#
	return;
	setdvar("scr_thundergun_cylinder_radius",level.zombie_vars["thundergun_cylinder_radius"]);
	setdvar("scr_thundergun_fling_range",level.zombie_vars["thundergun_fling_range"]);
	setdvar("scr_thundergun_gib_range",level.zombie_vars["thundergun_gib_range"]);
	setdvar("scr_thundergun_gib_damage",level.zombie_vars["thundergun_gib_damage"]);
	setdvar("scr_thundergun_knockdown_range",level.zombie_vars["thundergun_knockdown_range"]);
	setdvar("scr_thundergun_knockdown_damage",level.zombie_vars["thundergun_knockdown_damage"]);
	for(;;)
	{
		level.zombie_vars["thundergun_cylinder_radius"] = GetDvarInt(#"DEA6F730");
		level.zombie_vars["thundergun_fling_range"] = GetDvarInt(#"16044A2B");
		level.zombie_vars["thundergun_gib_range"] = GetDvarInt(#"F5270E6D");
		level.zombie_vars["thundergun_gib_damage"] = GetDvarInt(#"795FFDFF");
		level.zombie_vars["thundergun_knockdown_range"] = GetDvarInt(#"2721E469");
		level.zombie_vars["thundergun_knockdown_damage"] = GetDvarInt(#"EAB5937B");
		wait(0.5);
	}
maps/mp/zombies/_zm_weapons::is_weapon_included("thundergun_zm")
#/
}

//Function Number: 3
thundergun_on_player_connect()
{
	self thread wait_for_thundergun_fired();
}

//Function Number: 4
wait_for_thundergun_fired()
{
	self endon("disconnect");
	self waittill("spawned_player");
	for(;;)
	{
		self waittill("weapon_fired");
		currentweapon = self getcurrentweapon();
		if(currentweapon == "thundergun_zm" || currentweapon == "thundergun_upgraded_zm")
		{
			self thread thundergun_fired();
			view_pos = self gettagorigin("tag_flash") - self getplayerviewheight();
			view_angles = self gettagangles("tag_flash");
			playfx(level._effect["thundergun_smoke_cloud"],view_pos,AnglesToForward(view_angles),AnglesToUp(view_angles));
		}
	}
}

//Function Number: 5
thundergun_network_choke()
{
	level.thundergun_network_choke_count++;
	if(!(level.thundergun_network_choke_count % 10))
	{
		wait_network_frame();
		wait_network_frame();
		wait_network_frame();
	}
}

//Function Number: 6
thundergun_fired()
{
	physicsexplosioncylinder(self.origin,600,240,1);
	if(!(IsDefined(level.thundergun_knockdown_enemies)))
	{
		level.thundergun_knockdown_enemies = [];
		level.thundergun_knockdown_gib = [];
		level.thundergun_fling_enemies = [];
		level.thundergun_fling_vecs = [];
	}

	self thundergun_get_enemies_in_range();
	level.thundergun_network_choke_count = 0;
	for(i = 0;i < level.thundergun_fling_enemies.size;i++)
	{
		thundergun_network_choke();
		level.thundergun_fling_enemies[i] thread thundergun_fling_zombie(self,level.thundergun_fling_vecs[i],i);
	}

	for(i = 0;i < level.thundergun_knockdown_enemies.size;i++)
	{
		thundergun_network_choke();
		level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie(self,level.thundergun_knockdown_gib[i]);
	}

	level.thundergun_knockdown_enemies = [];
	level.thundergun_knockdown_gib = [];
	level.thundergun_fling_enemies = [];
	level.thundergun_fling_vecs = [];
}

//Function Number: 7
thundergun_get_enemies_in_range()
{
	view_pos = self getweaponmuzzlepoint();
	zombies = get_array_of_closest(view_pos,get_round_enemy_array(),undefined,undefined,level.zombie_vars["thundergun_knockdown_range"]);
	if(!(IsDefined(zombies)))
	{
		return;
	}

	knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
	gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
	fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
	cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];
	forward_view_angles = self getweaponforwarddir();
	end_pos = level.zombie_vars["thundergun_knockdown_range"] + VectorScale(forward_view_angles);
/#
	near_circle_pos = 2 + VectorScale(forward_view_angles);
	circle(near_circle_pos,level.zombie_vars["thundergun_cylinder_radius"],(1,0,0),0,0,100);
	line(near_circle_pos,end_pos,(0,0,1),1,0,100);
	circle(end_pos,level.zombie_vars["thundergun_cylinder_radius"],(1,0,0),0,0,100);
view_pos
2 == GetDvarInt(#"AAC84AD6")
#/
	for(i = 0;i < zombies.size;i++)
	{
		if(!IsDefined(zombies[i]) || !isalive(zombies[i]))
		{
		}
		else
		{
			test_origin = zombies[i] getcentroid();
			test_range_squared = distancesquared(view_pos,test_origin);
			if(test_range_squared > knockdown_range_squared)
			{
				zombies[i] thundergun_debug_print("range",(1,0,0));
				return;
			}

			normal = vectornormalize(test_origin - view_pos);
			dot = vectordot(forward_view_angles,normal);
			if(0 > dot)
			{
				zombies[i] thundergun_debug_print("dot",(1,0,0));
			}
			else
			{
				radial_origin = pointonsegmentnearesttopoint(view_pos,end_pos,test_origin);
				if(distancesquared(test_origin,radial_origin) > cylinder_radius_squared)
				{
					zombies[i] thundergun_debug_print("cylinder",(1,0,0));
				}
				else if(0 == zombies[i] damageconetrace(view_pos,self))
				{
					zombies[i] thundergun_debug_print("cone",(1,0,0));
				}
				else if(test_range_squared < fling_range_squared)
				{
					level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];
					dist_mult = fling_range_squared - test_range_squared / fling_range_squared;
					fling_vec = vectornormalize(test_origin - view_pos);
					if(5000 < test_range_squared)
					{
						fling_vec = fling_vec + vectornormalize(test_origin - radial_origin);
					}

					fling_vec = (fling_vec[0],fling_vec[1],Abs(fling_vec[2]));
					fling_vec = VectorScale(fling_vec);
					level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;
					zombies[i] thread setup_thundergun_vox(self,1,0,0);
				}
				else if(test_range_squared < gib_range_squared)
				{
					level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
					level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 1;
					zombies[i] thread setup_thundergun_vox(self,0,1,0);
				}
				else
				{
					level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
					level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 0;
					zombies[i] thread setup_thundergun_vox(self,0,0,1);
				}
			}
		}
	}
}

//Function Number: 8
thundergun_debug_print(msg,color)
{
/#
	return;
	color = (1,1,1);
	print3d(60 + VectorScale((0,0,1)),self.origin,msg,color,1,1);
40
IsDefined(color)
GetDvarInt(#"AAC84AD6")
#/
}

//Function Number: 9
thundergun_fling_zombie(player,fling_vec,index)
{
	if(!IsDefined(self) || !isalive(self))
	{
		return;
	}

	if(IsDefined(self.thundergun_fling_func))
	{
		self [[ self.thundergun_fling_func ]](player);
		return;
	}

	self dodamage(self.health + 666,player.origin,player);
	if(self.health <= 0)
	{
		points = 10;
		if(!(index))
		{
			points = maps/mp/zombies/_zm_score::get_zombie_death_player_points();
		}
		else if(1 == index)
		{
			points = 30;
		}

		player maps/mp/zombies/_zm_score::player_add_points("thundergun_fling",points);
		self startragdoll();
		self launchragdoll(fling_vec);
		self.thundergun_death = 1;
	}
}

//Function Number: 10
zombie_knockdown(player,gib)
{
	if(gib && !self.gibbed)
	{
		self.a.gib_ref = random(level.thundergun_gib_refs);
		self thread maps/mp/animscripts/zm_death::do_gib();
	}

	damage = level.zombie_vars["thundergun_knockdown_damage"];
	if(IsDefined(level.override_thundergun_damage_func))
	{
		self [[ level.override_thundergun_damage_func ]](player,gib);
	}
	else
	{
		self.thundergun_handle_pain_notetracks = ::handle_thundergun_pain_notetracks;
		self dodamage(damage,player.origin,player);
	}
}

//Function Number: 11
thundergun_knockdown_zombie(player,gib)
{
	self endon("death");
	playsoundatposition("vox_thundergun_forcehit",self.origin);
	playsoundatposition("wpn_thundergun_proj_impact",self.origin);
	if(!IsDefined(self) || !isalive(self))
	{
		return;
	}

	if(IsDefined(self.thundergun_knockdown_func))
	{
		self [[ self.thundergun_knockdown_func ]](player,gib);
	}
	else
	{
		self dodamage(level.zombie_vars["thundergun_knockdown_damage"],player.origin,player);
	}

	if(gib)
	{
		self.a.gib_ref = random(level.thundergun_gib_refs);
		self thread maps/mp/animscripts/zm_death::do_gib();
	}

	self.thundergun_handle_pain_notetracks = ::handle_thundergun_pain_notetracks;
	self dodamage(level.zombie_vars["thundergun_knockdown_damage"],player.origin,player);
	self playsound("fly_thundergun_forcehit");
}

//Function Number: 12
handle_thundergun_pain_notetracks(note)
{
	if(note == "zombie_knockdown_ground_impact")
	{
		playfx(level._effect["thundergun_knockdown_ground"],self.origin,AnglesToForward(self.angles),AnglesToUp(self.angles));
		self playsound("fly_thundergun_forcehit");
	}
}

//Function Number: 13
is_thundergun_damage()
{
	return IsDefined(self.damageweapon) && (self.damageweapon == "thundergun_zm" || self.damageweapon == "thundergun_upgraded_zm") && self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH";
}

//Function Number: 14
enemy_killed_by_thundergun()
{
	return IsDefined(self.thundergun_death) && self.thundergun_death == 1;
}

//Function Number: 15
thundergun_sound_thread()
{
	self endon("disconnect");
	self waittill("spawned_player");
	for(;;)
	{
		result = self waittill_any_return("grenade_fire","death","player_downed","weapon_change","grenade_pullback");
		if(!(IsDefined(result)))
		{
			continue;
		}

		if((result == "weapon_change" || result == "grenade_fire") && self getcurrentweapon() == "thundergun_zm")
		{
			self playloopsound("tesla_idle",0.25);
			continue;
		}

		self notify("weap_away");
		self stoploopsound(0.25);
	}
}

//Function Number: 16
setup_thundergun_vox(player,fling,gib,knockdown)
{
	if(!IsDefined(self) || !isalive(self))
	{
		return;
	}

	if(!fling && gib || knockdown)
	{
		if(25 > randomintrange(1,100))
		{
		}
	}

	if(fling)
	{
		if(30 > randomintrange(1,100))
		{
			player maps/mp/zombies/_zm_audio::create_and_play_dialog("kill","thundergun");
		}
	}
}