/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_generic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 113 ms
 * Timestamp: 4/22/2024 2:15:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_generic"] = level.agent_funcs["zombie"];
	level.agent_funcs["zombie_generic"]["think"] = ::zombie_generic_think;
	level.crawlingzombies = 0;
	level.dismemberedbodyparts = [];
	level.nextdismemberedbodypartindex = 0;
	if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
	{
		var_00[0] = ["zom_civ_ruban_male_torso_slice"];
		var_01[0]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice"];
		var_01[0]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice"];
		var_01[0]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_01[0]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_02[0] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_shg_dlc_b"];
		var_00[1] = ["zom_civ_ruban_male_torso_slice_b"];
		var_01[1]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_b"];
		var_01[1]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_b"];
		var_01[1]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_01[1]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_02[1] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_shg_dlc_b"];
		var_00[2] = ["zom_marine_shotgun_torso_slice"];
		var_01[2]["right_arm"] = ["zom_marine_shotgun_r_arm_slice"];
		var_01[2]["left_arm"] = ["zom_marine_shotgun_l_arm_slice"];
		var_01[2]["right_leg"] = ["zom_marine_shotgun_r_leg_slice"];
		var_01[2]["left_leg"] = ["zom_marine_shotgun_l_leg_slice"];
		var_02[2] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_shg_dlc_b"];
	}
	else
	{
		var_02[0] = ["zom_civ_ruban_male_torso_slice"];
		var_01[0]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice"];
		var_02[0]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice"];
		var_02[0]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_02[0]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_00[0] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		var_00[1] = ["zom_civ_ruban_male_torso_slice_ab"];
		var_01[1]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_ab"];
		var_01[1]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_ab"];
		var_01[1]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_01[1]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_02[1] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		var_00[2] = ["zom_civ_ruban_male_torso_slice_b"];
		var_01[2]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_b"];
		var_01[2]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_b"];
		var_01[2]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_01[2]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_02[2] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		var_00[3] = ["zom_civ_ruban_male_torso_slice_c"];
		var_01[3]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_c"];
		var_01[3]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_c"];
		var_01[3]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
		var_01[3]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
		var_02[3] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		var_00[4] = ["zom_marine_shotgun_torso_slice"];
		var_01[4]["right_arm"] = ["zom_marine_shotgun_r_arm_slice"];
		var_01[4]["left_arm"] = ["zom_marine_shotgun_l_arm_slice"];
		var_01[4]["right_leg"] = ["zom_marine_shotgun_r_leg_slice"];
		var_01[4]["left_leg"] = ["zom_marine_shotgun_l_leg_slice"];
		var_02[4] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		var_00[5] = ["zom_marine_shotgun_torso_slice_bb"];
		var_01[5]["right_arm"] = ["zom_marine_shotgun_r_arm_slice_bb"];
		var_01[5]["left_arm"] = ["zom_marine_shotgun_l_arm_slice_bb"];
		var_01[5]["right_leg"] = ["zom_marine_shotgun_r_leg_slice_bb"];
		var_01[5]["left_leg"] = ["zom_marine_shotgun_l_leg_slice_bb"];
		var_02[5] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
	}

	var_03 = spawnstruct();
	var_03.agent_type = "zombie_generic";
	var_03.animclass = "zombie_animclass";
	var_03.model_bodies = var_00;
	var_03.model_limbs = var_01;
	var_03.model_heads = var_02;
	var_03.health_scale = 1;
	var_03.meleedamage = 45;
	if(isdefined(level.modifygenericzombieclassfunc))
	{
		var_03 = [[ level.modifygenericzombieclassfunc ]](var_03);
	}

	maps\mp\zombies\_util::agentclassregister(var_03,"zombie_generic");
}

//Function Number: 2
zombie_generic_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread zombie_generic_moan();
	thread zombie_audio_monitor();
	thread maps\mp\zombies\_zombies::updatebuffs();
	thread maps\mp\zombies\_zombies::updatepainsensor();
	if(level.nextgen)
	{
		var_00 = 0.05;
	}
	else
	{
		var_00 = 0.2;
	}

	for(;;)
	{
		if(maps\mp\zombies\_behavior::humanoid_begin_melee())
		{
			wait(var_00);
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee())
		{
			wait(var_00);
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known())
		{
			wait(var_00);
			continue;
		}

		maps\mp\zombies\_behavior::humanoid_seek_random_loc();
		wait(var_00);
	}
}

//Function Number: 3
zombie_generic_moan()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		while(!isdefined(self.curmeleetarget))
		{
			wait(0.25);
		}

		while(isdefined(self.curmeleetarget) && distancesquared(self.origin,self.curmeleetarget.origin) > 40000)
		{
			if(self.movemode == "walk")
			{
				maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle_low",self.agent_type);
				wait(randomfloatrange(1.5,4));
				continue;
			}

			if(self.movemode == "run" || self.movemode == "sprint")
			{
				maps\mp\zombies\_zombies_audio::do_zombies_playvocals("move",self.agent_type);
				wait(randomfloatrange(2.5,5.5));
			}
		}

		while(isdefined(self.curmeleetarget) && distancesquared(self.origin,self.curmeleetarget.origin) > 10000 && distancesquared(self.origin,self.curmeleetarget.origin) <= 40000)
		{
			maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle_high",self.agent_type);
			wait(randomfloatrange(1.5,2));
		}

		if(level.nextgen)
		{
			wait(0.05);
			continue;
		}

		wait(0.2);
	}
}

//Function Number: 4
zombie_audio_monitor()
{
	self endon("death");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_parms("attack_hit","attack_miss");
		if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() <= 6)
		{
			var_01 = randomintrange(0,2);
		}
		else
		{
			var_01 = randomintrange(0,4);
		}

		switch(var_00[0])
		{
			case "attack_hit":
				if(var_01 == 0)
				{
					thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack",self.agent_type);
				}
		
				var_02 = var_00[1];
				if(isdefined(var_02) && isplayer(var_02))
				{
					if(isalive(var_02))
					{
						if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && self.agent_type == "zombie_boss_oz_stage2")
						{
							var_02 playlocalsound("zmb_hit_oz_boss");
						}
					}
					else
					{
						var_02 playsoundtoplayer("zmb_hit",var_02);
					}
				}
				break;
	
			case "attack_miss":
				if(var_01 == 0)
				{
					thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack",self.agent_type);
				}
				break;
		}
	}
}

//Function Number: 5
snd_play_linked_notify_on_ent(param_00,param_01,param_02)
{
	thread snd_play_linked_notify_on_ent_thread(param_00,param_01,param_02);
}

//Function Number: 6
snd_play_linked_notify_on_ent_thread(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",self.origin);
	var_03 linkto(self);
	var_03 playsound(param_00);
	self waittill(param_01);
	var_03 scalevolume(0,param_02);
	wait(param_02);
	var_03 stopsounds();
	wait 0.05;
	var_03 delete();
}