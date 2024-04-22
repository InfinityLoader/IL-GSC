/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _dds.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 90
 * Decompile Time: 1368 ms
 * Timestamp: 4/22/2024 2:20:36 AM
*******************************************************************/

//Function Number: 1
dds_init()
{
	level.dds = spawnstruct();
	level.dds.heartbeat = 0.25;
	level.dds.max_active_events = 6;
	level.dds.variant_limit = 17;
	level.dds.category_backoff_limit = 2;
	level.dds.scripted_line_delay = 2;
	level.dds.response_distance_min = 500;
	level.dds.history = [];
	level.dds.history_count = 15;
	level.dds.history_index = 0;
	level.dds.response_wait = 0.25;
	level.dds.response_wait_axis = 0.25;
	level.dds.trigger_string = "trig";
	level.dds.heightforhighcallout = 96;
	level.dds.using_overrides = 0;
	level.dds.reinforcement_endtime = [];
	init_dds_countryids();
	init_dds_category_groups();
	init_dds_category_groups_axis();
	init_dds_flags();
	init_dds_categories();
	init_dds_categories_axis();
	init_dds_active_events();
	setdvar("dds_debug_table_active",1);
	setdvar("dds_drawDebugTable",0);
	setdvar("dds_logErrorsAndRequests",0);
	setdvar("dds_drawDebugInfo",0);
	setdvar("dds_drawDebugVerbose",0);
	setdvar("dds_drawDebugFlank",0);
	setdvar("dds_battlechater_disable",0);
	if(!isdefined(level.bcs_locations))
	{
		common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
	}

	override_dds_categories();
}

//Function Number: 2
init_dds_countryids(param_00,param_01)
{
	level.dds.characterid_count = 0;
	level.dds.countryids = [];
	add_dds_countryid("british","UK",2);
	add_dds_countryid("american","US",3);
	add_dds_countryid("seal","NS",4);
	add_dds_countryid("taskforce","TF",1);
	add_dds_countryid("secretservice","SS",4);
	add_dds_countryid("delta","DF",3);
	add_dds_countryid("french","FR",3);
	add_dds_countryid("czech","CZ",3);
	add_dds_countryid("pmc","PC",3);
	add_dds_countryid("russian","RU",3);
	add_dds_countryid("arab","AB",3);
	add_dds_countryid("portugese","PG",3);
	add_dds_countryid("shadowcompany","SC",4);
	add_dds_countryid("african","AF",3);
	add_dds_countryid("seal","GS",1);
	add_dds_countryid("shadowcompany","SP",1);
	add_dds_countryid("xslice","XS",3);
	add_dds_countryid("atlas","AT",3);
	add_dds_countryid("kva","KV",3);
	add_dds_countryid("sentinel","SE",3);
	add_dds_countryid("squad","SQ",3);
	add_dds_countryid("northkorea","NK",3);
}

//Function Number: 3
add_dds_countryid(param_00,param_01,param_02)
{
	level.dds.countryids[param_00] = spawnstruct();
	level.dds.countryids[param_00].label = param_01;
	level.dds.countryids[param_00].count = 0;
	level.dds.countryids[param_00].max_voices = param_02;
	for(var_03 = 0;var_03 < param_02;var_03++)
	{
		var_04 = param_01 + var_03;
		level.dds.characterid_is_talking_currently[var_04] = 0;
	}
}

//Function Number: 4
init_dds_category_groups()
{
	level.dds.category_groups = [];
	add_dds_category_group("oclock",5);
}

//Function Number: 5
add_dds_category_group(param_00,param_01)
{
	level.dds.category_groups[param_00] = spawnstruct();
	level.dds.category_groups[param_00].timeout_reset = param_01;
	level.dds.category_groups[param_00].timeout = 0;
	level.dds.category_groups[param_00].categories = [];
	level.dds.category_groups[param_00].last_timeout = param_01;
	level.dds.category_groups[param_00].last_time = gettime();
	level.dds.category_groups[param_00].backoff_count = 0;
}

//Function Number: 6
init_dds_category_groups_axis()
{
	level.dds.category_groups_axis = [];
	add_dds_category_group_axis("oclock",5);
}

//Function Number: 7
add_dds_category_group_axis(param_00,param_01)
{
	level.dds.category_groups_axis[param_00] = spawnstruct();
	level.dds.category_groups_axis[param_00].timeout_reset = param_01;
	level.dds.category_groups_axis[param_00].timeout = 0;
	level.dds.category_groups_axis[param_00].categories = [];
	level.dds.category_groups_axis[param_00].last_timeout = param_01;
	level.dds.category_groups_axis[param_00].last_time = gettime();
	level.dds.category_groups_axis[param_00].backoff_count = 0;
}

//Function Number: 8
init_dds_flags()
{
	common_scripts\utility::flag_init("dds_running_allies");
	level thread dds_send_team_notify_on_disable("allies");
	common_scripts\utility::flag_init("dds_running_axis");
	level thread dds_send_team_notify_on_disable("axis");
}

//Function Number: 9
init_dds_categories()
{
	if(!isdefined(level.dds.categories))
	{
		level.dds.categories = [];
	}

	add_dds_category("react_ast","react_ast",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_zipliners","react_zipliners",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_man_down","react_man_down",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_microwave","react_microwave",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_boost_jumpers","react_boost_jumpers",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_drones","react_drones",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_elite","react_elite",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_dogs","react_dogs",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_mmg","react_mmg",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_friendly_fire","react_friendly_fire",3,"",1,::dds_sort_ent_dist,::get_self_ent,2500,0.8,1,0,"",undefined,undefined);
	add_dds_category("react_sniper","react_sniper",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,240,0,"",undefined,undefined);
	add_dds_category("react_rpg","react_rpg",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,10,0,"",undefined,undefined);
	add_dds_category("react_emp","react_emp",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category("react_grenade","react_grenade",1.25,"grenade_rspns",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category("kill_confirm","act_kill_confirm",2,"rspns_killfirm",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,0.7,1.5,0,"",undefined,undefined);
	add_dds_category("headshot","act_kill_confirm",0.75,"rspns_killfirm",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,0.7,1.5,0,"",undefined,undefined);
	add_dds_category("rspns_killfirm","rspns_killfirm",0.75,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,1,1.5,0,"",undefined,undefined);
	add_dds_category("rspns_movement","rspns_movement",0.5,"",1,::dds_sort_ent_dist,::get_self_ent,4000,0.2,13.5,0,"",undefined,undefined);
	add_dds_category("fragout","act_fragout",0.75,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category("empout","act_empout",0.5,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.7,1.5,0,"",undefined,undefined);
	add_dds_category("trigger",level.dds.trigger_string,0.5,"rspns_act",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.95,20,1,"rspns_affirm",::alt_rspns_random_test,undefined);
	add_dds_category("thrt_left","thrt_left",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_right","thrt_right",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_behind","thrt_behind",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_front","thrt_front",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_flankleft","thrt_flankleft",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_flankright","thrt_flankright",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_flank","thrt_flank",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category("thrt_clock01","thrt_clock01",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock10","thrt_clock10",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock11","thrt_clock11",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock12","thrt_clock12",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock02","thrt_clock02",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock03","thrt_clock03",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock04","thrt_clock04",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock05","thrt_clock05",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock06","thrt_clock06",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock07","thrt_clock07",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock08","thrt_clock08",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_clock09","thrt_clock09",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category("thrt_dist10","thrt_dist10",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category("thrt_dist20","thrt_dist20",2.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category("thrt_dist30","thrt_dist30",2.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category("thrt_dist40","thrt_dist40",2.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category("thrt_open","thrt_open",2.5,"rspns_suppress",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,18,0,"",undefined,undefined);
	add_dds_category("thrt_exposed","thrt_exposed",2.5,"rspns_suppress",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,18,0,"",undefined,undefined);
	add_dds_category("thrt_movement","thrt_movement",2.5,"thrt_rspns",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,18,0,"",undefined,undefined);
	add_dds_category("thrt_breaking","thrt_breaking",2.5,"rspns_lm",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.1,7.5,0,"",undefined,undefined);
	add_dds_category("rspns_act","rspns_act",2,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category("rspns_affirm","rspns_affirm",2,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category("rspns_neg","rspns_neg",2,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category("rspns_suppress","react_suppress",0.5,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.8,14,0,"",undefined,undefined);
	add_dds_category("casualty","react_casualty",2,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2800,1,1.4,0,"",undefined,undefined);
	add_dds_category("reload","act_reload",2,"action_rspns",1,::dds_sort_ent_dist,::get_self_ent,5000,0.3,3.5,0,"",undefined,undefined);
	add_dds_category("kill_melee","kill_melee",0.75,"",1,::dds_sort_ent_dist,::get_attacker,400,1,3.5,0,"",undefined,undefined);
	add_dds_category("order_combatmove","order_combatmove",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category("order_noncombatmove","order_noncombatmove",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category("order_coverme","order_coverme",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.7,8,0,"",undefined,undefined);
	add_dds_category("react_leave_cover","react_leave_cover",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category("react_cantsee","react_cantsee",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,300,1.5,0,"",undefined,undefined);
	add_dds_category("act_moving","act_moving",0.75,"",1,::dds_sort_ent_dist,::get_self_ent,4000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category("order_suppress","order_suppress",3,"",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category("order_coverme","order_coverme",3,"",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category("order_kill_command","order_kill_command",3,"",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
}

//Function Number: 10
init_dds_categories_axis()
{
	if(!isdefined(level.dds.categories_axis))
	{
		level.dds.categories_axis = [];
	}

	add_dds_category_axis("react_em1","react_em1",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.8,26.5,0,"",undefined,undefined);
	add_dds_category_axis("react_smart","react_smart",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,26.5,0,"",undefined,undefined);
	add_dds_category_axis("react_rpg","react_rpg",1.25,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,3000,0.8,10,0,"",undefined,undefined);
	add_dds_category_axis("react_emp","react_emp",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category_axis("react_grenade","react_grenade",1.25,"grenade_rspns",1,::dds_sort_ent_dist,::get_nearest,3000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category_axis("react_sniper","react_sniper",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("thrt_acquired","thrt_acquired",0.5,"",1,::dds_sort_ent_dist,::get_self_ent,5000,0.3,16.5,0,"",undefined,undefined);
	add_dds_category_axis("kill_confirm","act_kill_confirm",2,"rspns_killfirm",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,0.7,1.5,0,"",undefined,undefined);
	add_dds_category_axis("headshot","act_kill_confirm",0.75,"rspns_killfirm",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,0.7,1.5,0,"",undefined,undefined);
	add_dds_category_axis("rspns_killfirm","rspns_killfirm",0.75,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2500,0.3,7,0,"",undefined,undefined);
	add_dds_category_axis("rspns_movement","rspns_movement",0.5,"",1,::dds_sort_ent_dist,::get_self_ent,4000,0.2,13.5,0,"",undefined,undefined);
	add_dds_category_axis("fragout","act_fragout",0.75,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category_axis("empout","act_empout",0.5,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.7,1.5,0,"",undefined,undefined);
	add_dds_category_axis("trigger",level.dds.trigger_string,0.5,"rspns_act",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.95,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_dist10","thrt_dist10",0.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category_axis("thrt_dist20","thrt_dist20",0.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category_axis("thrt_dist30","thrt_dist30",0.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category_axis("thrt_dist40","thrt_dist40",0.5,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,3000,0.2,15,0,"",undefined,undefined);
	add_dds_category_axis("thrt_open","thrt_open",1,"rspns_suppress",1,::dds_sort_ent_dist,::get_self_ent,2000,0.7,18,0,"",undefined,undefined);
	add_dds_category_axis("thrt_exposed","thrt_exposed",2.5,"rspns_suppress",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,18,0,"",undefined,undefined);
	add_dds_category_axis("thrt_movement","thrt_movement",1,"thrt_rspns",1,::dds_sort_ent_dist,::get_self_ent,2000,0.7,18,0,"",undefined,undefined);
	add_dds_category_axis("thrt_breaking","thrt_breaking",1,"rspns_lm",1,::dds_sort_ent_dist,::get_nearest,2000,0.7,7.5,0,"",undefined,undefined);
	add_dds_category_axis("rspns_act","rspns_act",0.5,"",1,::dds_sort_ent_dist,::get_nearest,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category_axis("rspns_affirm","rspns_affirm",0.5,"",1,::dds_sort_ent_dist,::get_nearest,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category_axis("rspns_neg","rspns_neg",0.5,"",1,::dds_sort_ent_dist,::get_nearest,2000,0.2,4,0,"",undefined,undefined);
	add_dds_category_axis("thrt_clock01","thrt_clock01",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock02","thrt_clock02",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock03","thrt_clock03",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock04","thrt_clock04",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock05","thrt_clock05",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock06","thrt_clock06",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock07","thrt_clock07",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock08","thrt_clock08",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock09","thrt_clock09",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock10","thrt_clock10",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock11","thrt_clock11",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock12","thrt_clock12",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock01h","thrt_clock01h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock02h","thrt_clock02h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock03h","thrt_clock03h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock04h","thrt_clock04h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock05h","thrt_clock05h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock06h","thrt_clock06h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock07h","thrt_clock07h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock08h","thrt_clock08h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock09h","thrt_clock09h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock10h","thrt_clock10h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock11h","thrt_clock11h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_clock12h","thrt_clock12h",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,"use_group",1,"",undefined,"oclock");
	add_dds_category_axis("thrt_left","thrt_left",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_right","thrt_right",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_behind","thrt_behind",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_front","thrt_front",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_flankleft","thrt_flankleft",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_flankright","thrt_flankright",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_flank","thrt_flank",2,"react_cover",1,::dds_sort_ent_dist,::get_self_ent,2000,0.1,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinaln","thrt_cardinaln",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinalne","thrt_cardinalne",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinale","thrt_cardinale",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinalse","thrt_cardinalse",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinals","thrt_cardinals",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinalsw","thrt_cardinalsw",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinalw","thrt_cardinalw",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("thrt_cardinalnw","thrt_cardinalnw",2,"react_cover",1,::dds_sort_ent_dist,::get_nearest_not_plr,2000,0.15,20,1,"",undefined,undefined);
	add_dds_category_axis("rspns_suppress","react_suppress",0.5,"",1,::dds_sort_ent_dist,::get_nearest,2000,0.8,14,0,"",undefined,undefined);
	add_dds_category_axis("casualty","react_casualty",2,"",1,::dds_sort_ent_dist,::get_nearest_not_plr,2800,1,1.4,0,"",undefined,undefined);
	add_dds_category_axis("reload","act_reload",2,"action_rspns",1,::dds_sort_ent_dist,::get_self_ent,5000,0.3,3.5,0,"",undefined,undefined);
	add_dds_category_axis("kill_melee","kill_melee",0.75,"",1,::dds_sort_ent_dist,::get_attacker,400,1,3.5,0,"",undefined,undefined);
	add_dds_category_axis("order_combatmove","order_combatmove",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category_axis("order_noncombatmove","order_noncombatmove",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.3,8,0,"",undefined,undefined);
	add_dds_category_axis("order_coverme","order_coverme",3,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,2500,0.7,8,0,"",undefined,undefined);
	add_dds_category_axis("react_threat","react_threat",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("react_getting_away","react_getting_away",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("react_cantsee","react_cantsee",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("react_vehicle","react_vehicle",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("order_kill_command","order_kill_command",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("order_reinforce","order_reinforce",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("order_flush","order_flush",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("order_suppress","order_suppress",1.25,"",1,::dds_sort_ent_dist,::get_nearest,3000,0.4,26.5,0,"",undefined,undefined);
	add_dds_category_axis("act_moving","act_moving",0.75,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.8,1.5,0,"",undefined,undefined);
	add_dds_category_axis("act_advancing","act_advancing",0.75,"rspns_act",1,::dds_sort_ent_dist,::get_self_ent,4000,0.8,1.5,0,"",undefined,undefined);
}

//Function Number: 11
override_dds_categories()
{
	if(animscripts\battlechatter::is_xslice())
	{
		override_dds_category_allteams("trigger",undefined,undefined,undefined,undefined,undefined,undefined,1,10,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_open",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_exposed",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_movement",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_breaking",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist10",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist20",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist30",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist40",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock01",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock02",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock03",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock04",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock05",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock06",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock07",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock08",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock09",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock10",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock11",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock12",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("react_grenade",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("react_emp",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("react_sniper",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("rspns_neg",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_acquired",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("kill_confirm",undefined,undefined,undefined,undefined,undefined,undefined,0.5,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinaln",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalne",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinale",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalse",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinals",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalsw",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalw",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalnw",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("order_combatmove",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("order_noncombatmove",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("order_coverme",undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined);
		level.dds.using_overrides = 1;
	}

	if(isdefined(level._stealth))
	{
		override_dds_category_allteams("trigger",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist10",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist20",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist30",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_dist40",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_open",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_exposed",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_movement",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_breaking",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock01",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock02",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock03",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock04",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock05",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock06",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock07",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock08",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock09",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock10",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock11",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock12",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_acquired",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinaln",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalne",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinale",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalse",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinals",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalsw",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalw",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_cardinalnw",undefined,undefined,undefined,undefined,undefined,undefined,undefined,30,undefined,undefined,undefined,undefined);
		level.dds.using_overrides = 1;
	}

	if(animscripts\battlechatter::is_greece())
	{
		override_dds_category_allteams("trigger",undefined,undefined,undefined,undefined,undefined,undefined,1,10,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock01",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock02",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock03",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock04",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock05",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock06",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock07",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock08",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock09",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock10",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock11",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		override_dds_category_allteams("thrt_clock12",undefined,undefined,undefined,undefined,undefined,undefined,0.1,20,undefined,undefined,undefined,undefined);
		level.dds.using_overrides = 1;
	}
}

//Function Number: 12
add_dds_category(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(isdefined(level.dds.active_events))
	{
		for(var_0E = 0;var_0E < level.dds.categories.size;var_0E++)
		{
			if(level.dds.categories[var_0E].name == param_00)
			{
				if(isdefined(param_01))
				{
					level.dds.categories[var_0E].alias_name = param_01;
				}

				if(isdefined(param_02))
				{
					level.dds.categories[var_0E].duration = param_02;
				}

				if(isdefined(param_03))
				{
					level.dds.categories[var_0E].rspns_cat_name = param_03;
				}

				if(isdefined(param_04))
				{
					level.dds.categories[var_0E].clear_on_action_success = param_04;
				}

				if(isdefined(param_05))
				{
					level.dds.categories[var_0E].priority_sort = param_05;
				}

				if(isdefined(param_06))
				{
					level.dds.categories[var_0E].get_talker_func = param_06;
				}

				if(isdefined(param_07))
				{
					level.dds.categories[var_0E].speaker_distance = param_07;
				}

				if(isdefined(param_08))
				{
					level.dds.categories[var_0E].probability = param_08;
				}

				if(isdefined(param_09))
				{
					level.dds.categories[var_0E].timeout_reset = param_09;
				}

				if(isdefined(param_0A))
				{
					level.dds.categories[var_0E].should_squelch = param_0A;
				}

				if(isdefined(param_0B))
				{
					level.dds.categories[var_0E].rspns_cat_name_alt = param_0B;
				}

				if(isdefined(param_0C))
				{
					level.dds.categories[var_0E].alt_rspns_test_func = param_0C;
				}

				if(isdefined(param_0D))
				{
					level.dds.categories[var_0E].group = param_0D;
					level.dds.category_groups[param_0D].categories[level.dds.category_groups[param_0D].categories.size] = param_00;
				}

				return;
			}
		}

		return;
	}

	var_0F = spawnstruct();
	var_0F.name = param_00;
	var_0F.alias_name = param_01;
	var_0F.duration = param_02;
	var_0F.priority_sort = param_05;
	var_0F.probability = param_08;
	var_0F.get_talker_func = param_06;
	var_0F.speaker_distance = param_07;
	var_0F.last_time = gettime();
	var_0F.backoff_count = 0;
	var_0F.timeout = randomint(10);
	var_0F.last_timeout = var_0F.timeout;
	var_0F.timeout_reset = param_09;
	var_0F.rspns_cat_name = param_03;
	var_0F.clear_on_action_success = param_04;
	var_0F.should_squelch = param_0A;
	var_0F.rspns_cat_name_alt = param_0B;
	var_0F.alt_rspns_test_func = param_0C;
	var_0F.group = param_0D;
	if(isdefined(param_0D))
	{
		level.dds.category_groups[param_0D].categories[level.dds.category_groups[param_0D].categories.size] = param_00;
	}

	level.dds.categories[level.dds.categories.size] = var_0F;
}

//Function Number: 13
add_dds_category_axis(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(isdefined(level.dds.active_events_axis))
	{
		for(var_0E = 0;var_0E < level.dds.categories.size;var_0E++)
		{
			if(level.dds.categories_axis[var_0E].name == param_00)
			{
				if(isdefined(param_01))
				{
					level.dds.categories_axis[var_0E].alias_name = param_01;
				}

				if(isdefined(param_02))
				{
					level.dds.categories_axis[var_0E].duration = param_02;
				}

				if(isdefined(param_03))
				{
					level.dds.categories_axis[var_0E].rspns_cat_name = param_03;
				}

				if(isdefined(param_04))
				{
					level.dds.categories_axis[var_0E].clear_on_action_success = param_04;
				}

				if(isdefined(param_05))
				{
					level.dds.categories_axis[var_0E].priority_sort = param_05;
				}

				if(isdefined(param_06))
				{
					level.dds.categories_axis[var_0E].get_talker_func = param_06;
				}

				if(isdefined(param_07))
				{
					level.dds.categories_axis[var_0E].speaker_distance = param_07;
				}

				if(isdefined(param_08))
				{
					level.dds.categories_axis[var_0E].probability = param_08;
				}

				if(isdefined(param_09))
				{
					level.dds.categories_axis[var_0E].timeout_reset = param_09;
				}

				if(isdefined(param_0B))
				{
					level.dds.new_category_axis[var_0E].rspns_cat_name_alt = param_0B;
				}

				if(isdefined(param_0C))
				{
					level.dds.categories_axis[var_0E].alt_rspns_test_func = param_0C;
				}

				if(isdefined(param_0D))
				{
					level.dds.categories_axis[var_0E].group = param_0D;
					level.dds.category_groups_axis[param_0D].categories[level.dds.category_groups_axis[param_0D].categories.size] = param_00;
				}

				return;
			}
		}

		return;
	}

	var_0F = spawnstruct();
	var_0F.name = param_00;
	var_0F.alias_name = param_01;
	var_0F.duration = param_02;
	var_0F.priority_sort = param_05;
	var_0F.probability = param_08;
	var_0F.get_talker_func = param_06;
	var_0F.speaker_distance = param_07;
	var_0F.last_time = gettime();
	var_0F.backoff_count = 0;
	var_0F.timeout = randomint(10);
	var_0F.last_timeout = var_0F.timeout;
	var_0F.timeout_reset = param_09;
	var_0F.rspns_cat_name = param_03;
	var_0F.clear_on_action_success = param_04;
	var_0F.rspns_cat_name_alt = param_0B;
	var_0F.alt_rspns_test_func = param_0C;
	var_0F.group = param_0D;
	if(isdefined(param_0D))
	{
		level.dds.category_groups_axis[param_0D].categories[level.dds.category_groups_axis[param_0D].categories.size] = param_00;
	}

	level.dds.categories_axis[level.dds.categories_axis.size] = var_0F;
}

//Function Number: 14
init_dds_active_events()
{
	level.dds.active_events = [];
	level.dds.active_events_axis = [];
	for(var_00 = 0;var_00 < level.dds.categories.size;var_00++)
	{
		level.dds.active_events[level.dds.categories[var_00].name] = [];
	}

	for(var_00 = 0;var_00 < level.dds.categories_axis.size;var_00++)
	{
		level.dds.active_events_axis[level.dds.categories_axis[var_00].name] = [];
	}
}

//Function Number: 15
override_dds_category_allteams(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	override_dds_category(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
	override_dds_category_axis(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 16
override_dds_category(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	add_dds_category(param_00,undefined,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 17
override_dds_category_axis(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	add_dds_category_axis(param_00,undefined,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
}

//Function Number: 18
reset_dds_categories()
{
	init_dds_categories();
	init_dds_categories_axis();
	level.dds.using_overrides = 0;
}

//Function Number: 19
dds_clear_old_expired_events()
{
	for(var_00 = 0;var_00 < level.dds.categories.size;var_00++)
	{
		var_01 = level.dds.categories[var_00];
		for(var_02 = 0;var_02 < level.dds.active_events[var_01.name].size;var_02++)
		{
			level.dds.active_events[var_01.name][var_02].duration = level.dds.active_events[var_01.name][var_02].duration - level.dds.heartbeat;
			if(level.dds.active_events[var_01.name][var_02].duration <= 0 || level.dds.active_events[var_01.name][var_02].clear_event_on_prob)
			{
				level.dds.active_events[var_01.name] = common_scripts\utility::array_remove(level.dds.active_events[var_01.name],level.dds.active_events[var_01.name][var_02]);
			}
		}
	}
}

//Function Number: 20
dds_clear_old_expired_events_axis()
{
	for(var_00 = 0;var_00 < level.dds.categories_axis.size;var_00++)
	{
		var_01 = level.dds.categories_axis[var_00];
		for(var_02 = 0;var_02 < level.dds.active_events_axis[var_01.name].size;var_02++)
		{
			level.dds.active_events_axis[var_01.name][var_02].duration = level.dds.active_events_axis[var_01.name][var_02].duration - level.dds.heartbeat;
			if(level.dds.active_events_axis[var_01.name][var_02].duration <= 0 || level.dds.active_events_axis[var_01.name][var_02].clear_event_on_prob)
			{
				level.dds.active_events_axis[var_01.name] = common_scripts\utility::array_remove(level.dds.active_events_axis[var_01.name],level.dds.active_events_axis[var_01.name][var_02]);
			}
		}
	}
}

//Function Number: 21
dds_clear_all_queued_events()
{
	for(var_00 = 0;var_00 < level.dds.categories.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.dds.active_events[level.dds.categories[var_00].name].size;var_01++)
		{
			level.dds.active_events[level.dds.categories[var_00].name] = [];
		}
	}
}

//Function Number: 22
dds_clear_all_queued_events_axis()
{
	for(var_00 = 0;var_00 < level.dds.categories_axis.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.dds.active_events_axis[level.dds.categories_axis[var_00].name].size;var_01++)
		{
			level.dds.active_events_axis[level.dds.categories_axis[var_00].name] = [];
		}
	}
}

//Function Number: 23
dds_main_process()
{
	if(common_scripts\utility::flag("dds_running_allies"))
	{
		return;
	}

	common_scripts\utility::flag_set("dds_running_allies");
	dds_find_threats("allies","axis");
	var_00 = 0;
	while(common_scripts\utility::flag("dds_running_allies"))
	{
		if(isdefined(level.numberofimportantpeopletalking) && level.numberofimportantpeopletalking > 0)
		{
			var_00 = 1;
			wait(level.dds.heartbeat);
			continue;
		}

		if(var_00)
		{
			wait(level.dds.scripted_line_delay);
			dds_clear_all_queued_events();
			var_00 = 0;
		}

		if(!dds_process_active_events())
		{
			wait(level.dds.heartbeat);
			continue;
		}

		wait(0.1);
		dds_clear_old_expired_events();
	}
}

//Function Number: 24
dds_main_process_axis()
{
	if(common_scripts\utility::flag("dds_running_axis"))
	{
		return;
	}

	common_scripts\utility::flag_set("dds_running_axis");
	dds_find_threats("axis","allies");
	var_00 = 0;
	while(common_scripts\utility::flag("dds_running_axis"))
	{
		if(isdefined(level.numberofimportantpeopletalking) && level.numberofimportantpeopletalking > 1)
		{
			var_00 = 1;
			wait(level.dds.heartbeat);
			continue;
		}

		if(var_00)
		{
			wait(level.dds.scripted_line_delay);
			dds_clear_all_queued_events_axis();
			var_00 = 0;
		}

		if(dds_process_active_events_axis())
		{
			wait(level.dds.heartbeat);
			continue;
		}

		wait(0.1);
		dds_clear_old_expired_events_axis();
	}
}

//Function Number: 25
dds_find_threats(param_00,param_01)
{
	level thread dds_find_infantry_threat(param_00,param_01);
}

//Function Number: 26
dds_enable(param_00)
{
	if(!isdefined(level.dds))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		level thread dds_main_process();
		level thread dds_main_process_axis();
		return;
	}

	if(param_00 == "allies")
	{
		level thread dds_main_process();
		return;
	}

	if(param_00 == "axis")
	{
		level thread dds_main_process_axis();
		return;
	}
}

//Function Number: 27
dds_disable(param_00)
{
	if(!isdefined(level.dds))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		dds_clear_all_queued_events();
		common_scripts\utility::flag_clear("dds_running_allies");
		dds_clear_all_queued_events_axis();
		common_scripts\utility::flag_clear("dds_running_axis");
		return;
	}

	switch(param_00)
	{
		case "axis":
			dds_clear_all_queued_events_axis();
			common_scripts\utility::flag_clear("dds_running_axis");
			break;

		case "allies":
			dds_clear_all_queued_events();
			common_scripts\utility::flag_clear("dds_running_allies");
			break;

		default:
			break;
	}
}

//Function Number: 28
dds_send_team_notify_on_disable(param_00)
{
	for(;;)
	{
		common_scripts\utility::flag_waitopen("dds_running_" + param_00);
		level notify("dds_running_" + param_00);
		common_scripts\utility::flag_wait("dds_running_" + param_00);
	}
}

//Function Number: 29
is_dds_enabled()
{
	if(!isdefined(level.dds))
	{
		return 0;
	}

	if(level.createfx_enabled || !common_scripts\utility::flag("dds_running_allies") && !common_scripts\utility::flag("dds_running_axis"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
exponent(param_00,param_01)
{
	if(param_01 == 0)
	{
		return 1;
	}

	return param_00 * exponent(param_00,param_01 - 1);
}

//Function Number: 31
dds_process_active_events()
{
	foreach(var_01 in level.dds.category_groups)
	{
		if(var_01.timeout > 0)
		{
			var_01.timeout = var_01.timeout - level.dds.heartbeat;
		}
	}

	for(var_03 = 0;var_03 < level.dds.categories.size;var_03++)
	{
		var_04 = level.dds.categories[var_03];
		if(isstring(var_04.timeout_reset) && var_04.timeout_reset == "use_group")
		{
			if(level.dds.category_groups[var_04.group].timeout > 0)
			{
				continue;
			}
		}
		else if(var_04.timeout > 0)
		{
			var_04.timeout = var_04.timeout - level.dds.heartbeat;
			continue;
		}

		if(level.dds.active_events[var_04.name].size != 0)
		{
			level.dds.active_events[var_04.name] = [[ var_04.priority_sort ]](level.dds.active_events[var_04.name]);
			for(var_05 = 0;var_05 < level.dds.active_events[var_04.name].size;var_05++)
			{
				if(randomfloat(1) >= var_04.probability)
				{
					level.dds.active_events[var_04.name][var_05].clear_event_on_prob = 1;
					continue;
				}

				if(level.dds.active_events[var_04.name][var_05].processed)
				{
					continue;
				}

				if(dds_event_activate(level.dds.active_events[var_04.name][var_05],var_04.get_talker_func,var_04.speaker_distance,var_04.rspns_cat_name,var_04.should_squelch,var_04.rspns_cat_name_alt,var_04.alt_rspns_test_func))
				{
					if(!isstring(var_04.timeout_reset) && var_04.timeout_reset == 0)
					{
						var_04.timeout = var_04.timeout_reset;
					}
					else
					{
						var_06 = undefined;
						if(isstring(var_04.timeout_reset) && var_04.timeout_reset == "use_group")
						{
							var_06 = level.dds.category_groups[var_04.group];
						}
						else
						{
							var_06 = var_04;
						}

						if(gettime() - var_06.last_time < var_06.last_timeout * 1.5 * 1000)
						{
							var_06.backoff_count++;
							if(var_06.backoff_count > level.dds.category_backoff_limit)
							{
								var_06.backoff_count = level.dds.category_backoff_limit;
							}
						}
						else
						{
							var_06.backoff_count--;
							if(var_06.backoff_count < 0)
							{
								var_06.backoff_count = 0;
							}
						}

						var_06.timeout = var_06.timeout_reset * exponent(2,var_06.backoff_count) + randomint(2);
						var_06.last_timeout = var_06.timeout;
						var_06.last_time = gettime();
					}

					if(var_04.clear_on_action_success)
					{
						level.dds.active_events[var_04.name] = [];
						if(isdefined(var_04.group))
						{
							for(var_07 = 0;var_07 < level.dds.category_groups[var_04.group].categories.size;var_07++)
							{
								level.dds.active_events[level.dds.category_groups[var_04.group].categories[var_07]] = [];
							}
						}
					}

					return 1;
				}
				else
				{
					wait(level.dds.heartbeat);
				}
			}
		}
	}

	return 0;
}

//Function Number: 32
dds_process_active_events_axis()
{
	foreach(var_01 in level.dds.category_groups_axis)
	{
		if(var_01.timeout > 0)
		{
			var_01.timeout = var_01.timeout - level.dds.heartbeat;
		}
	}

	for(var_03 = 0;var_03 < level.dds.categories_axis.size;var_03++)
	{
		var_04 = level.dds.categories_axis[var_03];
		if(isstring(var_04.timeout_reset) && var_04.timeout_reset == "use_group")
		{
			if(level.dds.category_groups_axis[var_04.group].timeout > 0)
			{
				continue;
			}
		}
		else if(var_04.timeout > 0)
		{
			var_04.timeout = var_04.timeout - level.dds.heartbeat;
			continue;
		}

		if(level.dds.active_events_axis[var_04.name].size != 0)
		{
			level.dds.active_events_axis[var_04.name] = [[ var_04.priority_sort ]](level.dds.active_events_axis[var_04.name]);
			for(var_05 = 0;var_05 < level.dds.active_events_axis[var_04.name].size;var_05++)
			{
				if(randomfloat(1) >= var_04.probability)
				{
					level.dds.active_events_axis[var_04.name][var_05].clear_event_on_prob = 1;
					continue;
				}

				if(level.dds.active_events_axis[var_04.name][var_05].processed)
				{
					continue;
				}

				if(dds_event_activate(level.dds.active_events_axis[var_04.name][var_05],var_04.get_talker_func,var_04.speaker_distance,var_04.rspns_cat_name,0,var_04.rspns_cat_name_alt,var_04.alt_rspns_test_func))
				{
					if(!isstring(var_04.timeout_reset) && var_04.timeout_reset == 0)
					{
						var_04.timeout = var_04.timeout_reset;
					}
					else
					{
						var_06 = undefined;
						if(isstring(var_04.timeout_reset) && var_04.timeout_reset == "use_group")
						{
							var_06 = level.dds.category_groups_axis[var_04.group];
						}
						else
						{
							var_06 = var_04;
						}

						if(gettime() - var_06.last_time < var_06.last_timeout * 1.5 * 1000)
						{
							var_06.backoff_count++;
							if(var_06.backoff_count > level.dds.category_backoff_limit)
							{
								var_06.backoff_count = level.dds.category_backoff_limit;
							}
						}
						else
						{
							var_06.backoff_count--;
							if(var_06.backoff_count < 0)
							{
								var_06.backoff_count = 0;
							}
						}

						var_06.timeout = var_06.timeout_reset * exponent(2,var_06.backoff_count) + randomint(2);
						var_06.last_timeout = var_06.timeout;
						var_06.last_time = gettime();
					}

					if(var_04.clear_on_action_success)
					{
						level.dds.active_events_axis[var_04.name] = [];
						if(isdefined(var_04.group))
						{
							for(var_07 = 0;var_07 < level.dds.category_groups_axis[var_04.group].categories.size;var_07++)
							{
								level.dds.active_events_axis[level.dds.category_groups_axis[var_04.group].categories[var_07]] = [];
							}
						}
					}

					return 1;
				}
				else
				{
					wait(level.dds.heartbeat);
				}
			}
		}
	}

	return 0;
}

//Function Number: 33
dds_event_activate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_07 = param_00.category_name;
	if(isdefined(param_00.category_response_name))
	{
		var_07 = param_00.category_response_name;
	}

	var_08 = param_00 [[ param_01 ]](isdefined(param_00.category_response_name),param_02);
	if(!isdefined(var_08) || !isalive(var_08))
	{
		param_00.processed = 1;
		return 0;
	}

	if(var_08.dds_disable)
	{
		return 0;
	}

	var_0A = dds_get_alias_from_event(var_08,param_00.category_alias_name,param_00.ent,param_00.ent_threat);
	if(!isdefined(var_0A))
	{
		return 0;
	}

	if(isdefined(param_00.category_response_name))
	{
		if(param_00.isalliesline)
		{
			wait(level.dds.response_wait);
		}
		else
		{
			wait(level.dds.response_wait_axis);
		}
	}

	if(isdefined(param_00.optional_responder_name) && param_00.optional_responder_name != "")
	{
		var_0B = dds_get_alias_from_name(var_08,param_00.optional_responder_name);
		if(isdefined(var_0B))
		{
			dds_event_activate_play(var_08,var_0B);
			wait(0.6);
		}
	}

	dds_event_activate_play(var_08,var_0A,param_04);
	param_00.talker = var_08;
	param_00.talker_origin = var_08.origin;
	param_00.phrase = var_0A;
	param_00.processed = 1;
	add_phrase_to_history(var_0A);
	if(param_03 != "")
	{
		if(param_05 != "" && isdefined(param_06) && param_00 [[ param_06 ]]())
		{
			dds_notify_response(param_00,var_08,var_0A,param_05);
		}
		else
		{
			dds_notify_response(param_00,var_08,var_0A,param_03);
		}
	}

	return 1;
}

//Function Number: 34
dds_event_activate_play(param_00,param_01,param_02)
{
	if(!getdvarint("snd_dsp_futz"))
	{
		param_02 = 0;
	}

	if(isalive(param_00))
	{
		if(param_02 && !isplayer(param_00) && param_00.voice != "russian_english")
		{
			param_00 animscripts\face::playfacethread(undefined,"dds_squelch_strt",0.5,"dds_squelch_strt");
		}

		param_00 set_talking_currently(param_00);
		if(maps\_utility::getdvarintdefault("dds_battlechater_disable") == 0)
		{
			param_00 animscripts\face::playfacethread(undefined,param_01,0.5,param_01);
		}

		param_00 clear_talking_currently_when_done(param_00,param_01);
	}

	if(param_02 && !isplayer(param_00) && isalive(param_00) && param_00.voice != "russian_english")
	{
		param_00 animscripts\face::playfacethread(undefined,"dds_squelch_end",0.5,"dds_squelch_end");
	}
}

//Function Number: 35
talker_is_talking_currently(param_00)
{
	return level.dds.characterid_is_talking_currently[param_00.dds_characterid];
}

//Function Number: 36
set_talking_currently(param_00)
{
	level.dds.characterid_is_talking_currently[param_00.dds_characterid] = 1;
}

//Function Number: 37
clear_talking_currently_when_done(param_00,param_01)
{
	param_00 common_scripts\utility::waittill_any_timeout(5,param_01,"death");
	level.dds.characterid_is_talking_currently[param_00.dds_characterid] = 0;
}

//Function Number: 38
add_phrase_to_history(param_00)
{
	level.dds.history[level.dds.history_index] = param_00;
	level.dds.history_index = level.dds.history_index + 1 % level.dds.history_count;
}

//Function Number: 39
get_nearest_common(param_00,param_01,param_02)
{
	var_03 = level.player;
	if(self.isalliesline)
	{
		var_04 = getaiarray("allies");
		if(param_01)
		{
			var_04[var_04.size] = var_03;
		}
	}
	else
	{
		var_04 = getaiarray("axis");
	}

	if(var_04.size <= 0)
	{
		return undefined;
	}

	var_04 = remove_all_actors_that_are_squelched(var_04);
	if(param_00 && isdefined(self.talker))
	{
		var_04 = remove_all_actors_with_same_characterid(var_04,self.talker.dds_characterid);
		var_05 = maps\_utility::get_closest_living(self.talker.origin,var_04);
	}
	else
	{
		var_05 = maps\_utility::get_closest_living(var_04.origin,var_05);
	}

	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_06 = distancesquared(var_03.origin,var_05.origin);
	if(var_06 > param_02 * param_02)
	{
		return undefined;
	}

	if(param_00 && var_06 < level.dds.response_distance_min * level.dds.response_distance_min)
	{
		return undefined;
	}

	return var_05;
}

//Function Number: 40
remove_all_actors_that_are_squelched(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.bsc_squelched))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 41
remove_all_actors_with_same_characterid(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02].dds_characterid))
		{
			param_00 = common_scripts\utility::array_remove(param_00,param_00[var_02]);
			continue;
		}

		if(param_00[var_02].dds_characterid == param_01)
		{
			param_00 = common_scripts\utility::array_remove(param_00,param_00[var_02]);
			continue;
		}
	}

	return param_00;
}

//Function Number: 42
get_nearest(param_00,param_01)
{
	return get_nearest_common(param_00,1,param_01);
}

//Function Number: 43
get_nearest_not_plr(param_00,param_01)
{
	return get_nearest_common(param_00,0,param_01);
}

//Function Number: 44
get_attacker(param_00,param_01)
{
	if(isdefined(self.ent_attacker) && isalive(self.ent_attacker))
	{
		if(isdefined(self.ent_team))
		{
			if(isdefined(self.ent_attacker.team) && self.ent_team == self.ent_attacker.team)
			{
				return undefined;
			}

			if(isdefined(self.ent_attacker.vteam) && self.ent_team == self.ent_attacker.vteam)
			{
				return undefined;
			}
		}

		return self.ent_attacker;
	}

	return undefined;
}

//Function Number: 45
get_self_ent(param_00,param_01)
{
	if(isdefined(self.ent) && isalive(self.ent))
	{
		return self.ent;
	}

	return undefined;
}

//Function Number: 46
alt_rspns_random_test()
{
	return 1;
}

//Function Number: 47
dds_get_alias_from_name(param_00,param_01)
{
	return dds_get_alias_from_event(param_00,"name_" + param_01);
}

//Function Number: 48
dds_get_alias_from_event(param_00,param_01,param_02,param_03)
{
	if(!isalive(param_00))
	{
		return undefined;
	}

	if(!isdefined(param_00.dds_characterid))
	{
		return undefined;
	}

	if(talker_is_talking_currently(param_00))
	{
		return undefined;
	}

	var_04 = "dds_" + param_00.dds_characterid + "_" + param_01;
	if(isdefined(param_02) && param_01 == level.dds.trigger_string)
	{
		var_05 = param_03 get_trigger_location_qualifier(var_04);
		if(isdefined(var_05))
		{
			var_04 = var_04 + "_" + var_05;
		}
	}

	if(soundexists(var_04))
	{
		return var_04;
	}

	return undefined;
}

//Function Number: 49
is_phrase_in_history(param_00)
{
	for(var_01 = 0;var_01 < level.dds.history.size;var_01++)
	{
		if(level.dds.history[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 50
is_inside_valid_location_trigger()
{
	var_00 = [];
	var_00 = animscripts\battlechatter::get_all_my_locations();
	return var_00.size > 0;
}

//Function Number: 51
get_trigger_location_qualifier(param_00)
{
	var_01 = animscripts\battlechatter::get_all_my_locations();
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return undefined;
	}

	if(var_01[0].locationaliases.size == 0)
	{
		return undefined;
	}

	foreach(var_03 in var_01[0].locationaliases)
	{
		param_00 = param_00 + "_" + var_03;
		if(soundexists(param_00))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 52
dds_get_non_ai_threats(param_00)
{
	var_01 = [];
	var_02 = getentarray("actor_enemy_dog","classname");
	foreach(var_04 in var_02)
	{
		if(get_team_or_script_team(var_04) == param_00)
		{
			var_01[var_01.size] = var_04;
		}
	}

	var_06 = maps\_utility::getvehiclearray();
	foreach(var_04 in var_06)
	{
		if(get_team_or_script_team(var_04) == param_00)
		{
			if(is_drone(var_04))
			{
				var_01[var_01.size] = var_04;
			}
		}
	}

	var_09 = getentarray("misc_turret","classname");
	foreach(var_04 in var_09)
	{
		if(get_team_or_script_team(var_04) == param_00)
		{
			if(is_turret(var_04))
			{
				var_01[var_01.size] = var_04;
			}
		}
	}

	if(param_00 == "allies")
	{
		var_01[var_01.size] = level.player;
	}

	return var_01;
}

//Function Number: 53
get_team_or_script_team(param_00)
{
	if(isdefined(param_00.team))
	{
		return param_00.team;
	}

	if(isdefined(param_00.script_team))
	{
		return param_00.script_team;
	}

	return "";
}

//Function Number: 54
is_drone(param_00)
{
	if(isdefined(param_00.vehicletype) && param_00.vehicletype == "pdrone" || param_00.vehicletype == "aerial_drone" || param_00.vehicletype == "attack_drone_queen" || issubstr(param_00.vehicletype,"drone"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
is_turret(param_00)
{
	if(param_00.classname == "misc_turret" && param_00 isfiringturret())
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
dds_find_infantry_threat(param_00,param_01)
{
	var_02 = 0;
	var_03 = 3000;
	var_04 = param_01 == "allies";
	var_05 = 0;
	while(common_scripts\utility::flag("dds_running_" + param_00))
	{
		var_06 = level.player;
		var_07 = getaiarray(param_01);
		var_08 = getaiarray(param_00);
		var_09 = dds_get_non_ai_threats(param_00);
		var_0A = 0;
		var_0B = 0;
		var_0C = 0;
		var_0D = 0;
		for(var_0E = 0;var_0E < var_08.size + var_09.size;var_0E++)
		{
			var_0F = undefined;
			var_10 = 0;
			if(var_0E >= var_08.size)
			{
				var_10 = 1;
			}

			if(var_10)
			{
				var_0F = var_09[var_0E - var_08.size];
			}
			else
			{
				var_0F = var_08[var_0E];
			}

			for(var_11 = 0;var_11 < var_07.size;var_11++)
			{
				if(var_07.size >= 1 && randomfloat(1) < 0.5)
				{
					var_0D++;
					var_12 = var_07[var_11];
					if(var_12.combattime > 0)
					{
						var_0C = 1;
					}

					var_13 = 0;
					if(distancesquared(var_12.origin,var_0F.origin) < 16000000 && var_12 cansee(var_0F))
					{
						var_13 = 1;
						var_0B = 1;
					}

					if(var_13 && distancesquared(var_12.origin,var_06.origin) < 16000000)
					{
						var_12 dds_notify_threat_unique(var_04,var_0F);
						if(var_10)
						{
							continue;
						}

						var_12 dds_notify_threat(var_04,var_0F);
						var_0A = 1;
						if(gettime() > var_02)
						{
							var_14 = var_12 gettagorigin("TAG_EYE");
							var_15 = var_0F.origin - var_14;
							var_12 simple_and_lazy_flank_check(var_0F,var_15,var_04);
							var_12 save_flank_info(var_0F,var_15);
							var_02 = var_02 + var_03;
						}

						break;
					}
				}
			}

			if(var_0A)
			{
				break;
			}
		}

		if(!var_04 && var_07.size > 0 && var_0D / var_07.size > 0.75)
		{
			if(!var_0B && var_0B != var_05 && var_0C)
			{
				var_07[0] dds_notify("react_cantsee",var_04);
			}

			var_05 = var_0B;
		}

		wait(0.3 + randomfloat(0.2));
	}
}

//Function Number: 57
save_flank_info(param_00,param_01)
{
	self.dds_threat_guy = param_00;
	self.dds_threat_dir_stored = param_01;
	self.dds_threat_mypos = self.origin;
}

//Function Number: 58
simple_and_lazy_flank_check(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(self.dds_threat_guy))
	{
		self.dds_threat_guy = undefined;
		self.dds_threat_dir_stored = undefined;
		return;
	}

	if(param_00 != self.dds_threat_guy)
	{
		return;
	}

	if(distance2dsquared(self.origin,self.dds_threat_guy.origin) < 90000)
	{
		return;
	}

	if(distance2dsquared(self.origin,self.dds_threat_mypos) > 10000)
	{
		return;
	}

	var_04 = vectortoangles(self.dds_threat_dir_stored)[1];
	var_05 = vectortoangles(param_01)[1];
	var_06 = var_05 - var_04;
	if(var_06 < -180)
	{
		var_06 = var_05 + 360 - var_04;
	}

	if(var_06 > 180)
	{
		var_06 = var_05 - 360 - var_04;
	}

	if(var_06 < -45)
	{
		var_03 = "RIGHT";
	}

	if(var_06 > 45)
	{
		var_03 = "LEFT";
	}

	if(isdefined(var_03))
	{
		dds_notify("thrt_flank",param_02,self.dds_threat_guy);
		if(var_03 == "RIGHT")
		{
			dds_notify("thrt_flankright",param_02,self.dds_threat_guy,"");
		}

		if(var_03 == "LEFT")
		{
			dds_notify("thrt_flankleft",param_02,self.dds_threat_guy,"");
		}
	}
}

//Function Number: 59
dds_getclock_position(param_00)
{
	if(!isdefined(level.player))
	{
		return;
	}

	var_01 = level.player getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = vectornormalize(var_02);
	var_04 = level.player getorigin();
	var_05 = param_00 - var_04;
	var_06 = vectornormalize(var_05);
	var_07 = vectordot(var_03,var_06);
	var_08 = acos(var_07);
	var_09 = vectorcross(var_03,var_06);
	var_0A = vectordot(var_09,anglestoup(var_01));
	if(var_0A < 0)
	{
		var_08 = var_08 * -1;
	}

	var_0B = var_08 + 180;
	var_0C = 6;
	for(var_0D = 15;var_0D < 375;var_0D = var_0D + 30)
	{
		if(var_0B < var_0D)
		{
			break;
		}

		var_0C = var_0C - 1;
		if(var_0C < 1)
		{
			var_0C = 12;
		}
	}

	return var_0C;
}

//Function Number: 60
dds_notify_threat_unique(param_00,param_01)
{
	var_02 = "";
	if(!isdefined(level.player))
	{
		return;
	}

	if(get_team_or_script_team(self) == level.player.team)
	{
		var_03 = level.player;
		var_04 = var_03.origin;
		var_05 = level.player.angles;
		var_06 = param_01.origin;
	}
	else
	{
		var_03 = self;
		var_04 = var_06.origin;
		var_05 = animscripts\battlechatter::getrelativeangles(var_05);
		var_06 = var_02.origin;
	}

	if((isdefined(param_01.type) && param_01.type == "dog") || param_01.classname == "actor_enemy_dog")
	{
		dds_notify("react_dogs",param_00,param_01,var_02);
		return;
	}

	if(isdefined(param_01.is_using_boost) && param_01.is_using_boost)
	{
		dds_notify("react_boost_jumpers",param_00,param_01,var_02);
		return;
	}

	if(is_drone(param_01))
	{
		dds_notify("react_drones",param_00,param_01,var_02);
		return;
	}

	if(isdefined(param_01.elite) && param_01.elite)
	{
		dds_notify("react_elites",param_00,param_01,var_02);
		return;
	}

	if((isdefined(param_01.animarchetype) && param_01.animarchetype == "mech") || param_01.classname == "actor_enemy_mech")
	{
		dds_notify("react_ast",param_00,param_01,var_02);
		return;
	}

	if(isdefined(param_01.is_using_zipline) && param_01.is_using_zipline)
	{
		dds_notify("react_zipliners",param_00,param_01,var_02);
		return;
	}

	if(isdefined(param_01.primaryweapon) && animscripts\utility::issniperrifle(param_01.primaryweapon))
	{
		dds_notify("react_sniper",param_00,param_01,var_02);
		return;
	}

	if(is_turret(param_01))
	{
		dds_notify("react_mmg",param_00,param_01,var_02);
		return;
	}
}

//Function Number: 61
dds_notify_threat(param_00,param_01)
{
	var_02 = (0,0,0);
	var_03 = (0,0,0);
	var_04 = self;
	var_05 = "";
	if(!isdefined(level.player))
	{
		return;
	}

	if(self.team == level.player.team && !isdefined(param_01))
	{
		return;
	}

	if(self.team == level.player.team)
	{
		var_04 = level.player;
		var_03 = var_04.origin;
		var_06 = level.player.angles;
		var_02 = param_01.origin;
		if(randomint(100) > 50)
		{
			var_05 = var_04.dds_characterid;
		}
	}
	else
	{
		var_05 = self;
		var_04 = var_05.origin;
		var_06 = animscripts\battlechatter::getrelativeangles(var_05);
		var_02 = param_01.origin;
	}

	var_07 = distancesquared(var_02,var_03);
	var_08 = var_02[2] - var_03[2];
	if(param_01 is_inside_valid_location_trigger())
	{
		dds_notify("trigger",param_00,param_01,var_05);
	}

	if(var_07 < 200)
	{
		dds_notify("thrt_dist10",param_00,param_01,var_05);
	}
	else if(var_07 < 500)
	{
		dds_notify("thrt_dist20",param_00,param_01,var_05);
	}
	else if(var_07 < 1000)
	{
		dds_notify("thrt_dist30",param_00,param_01,var_05);
	}

	if(param_01 animscripts\battlechatter::isexposed(0))
	{
		dds_notify("thrt_exposed",param_00,param_01,var_05);
	}
	else
	{
		dds_notify("thrt_open",param_00,param_01,var_05);
	}

	var_09 = animscripts\battlechatter::getdirectionfacingangle(var_06,var_03,var_02);
	var_0A = animscripts\battlechatter::getdirectionfacingclockgivenangle(var_09);
	if(var_08 > level.dds.heightforhighcallout)
	{
		if(maps\_utility::string_is_single_digit_integer(var_0A))
		{
			var_0A = "0" + var_0A;
		}

		dds_notify("thrt_clockh" + var_0A,param_00,param_01,var_05);
	}

	if(maps\_utility::string_is_single_digit_integer(var_0A))
	{
		var_0A = "0" + var_0A;
	}

	dds_notify("thrt_clock" + var_0A,param_00,param_01,var_05);
	if(var_09 >= 45 && var_09 <= 135)
	{
		dds_notify("thrt_right",param_00,param_01,var_05);
	}
	else if(var_09 > 135 && var_09 <= 225)
	{
		dds_notify("thrt_back",param_00,param_01,var_05);
	}
	else if(var_09 >= 225 && var_09 <= 315)
	{
		dds_notify("thrt_left",param_00,param_01,var_05);
	}
	else
	{
		dds_notify("thrt_front",param_00,param_01,var_05);
	}

	var_0B = animscripts\battlechatter::getdirectioncompass(var_03,var_02);
	var_0C = animscripts\battlechatter::normalizecompassdirection(var_0B);
	dds_notify("thrt_cardinal" + var_0C,param_00,param_01,var_05);
}

//Function Number: 62
player_init()
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(level.dds))
	{
		return;
	}

	self.iskillstreaktimerrunning = 0;
	self.killstreakcounter = 0;
	maps\_utility::ent_flag_init("dds_killstreak");
	maps\_utility::ent_flag_init("dds_low_health");
	thread dds_killstreak_timer();
	thread dds_watch_player_health();
	thread dds_multikill_tracker();
	self.dds_characterid = "player";
	while(!isdefined(level.campaign))
	{
		wait(0.1);
	}

	self.countryid = level.dds.countryids[level.campaign].label;
	self.dds_disable = 0;
	level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
}

//Function Number: 63
dds_multikill_tracker()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		level common_scripts\utility::flag_wait("dds_running_" + self.team);
		self waittill("multikill");
		dds_notify("multikill",self.team == "allies");
	}
}

//Function Number: 64
dds_watch_player_health()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		level common_scripts\utility::flag_wait("dds_running_" + self.team);
		wait(0.5);
		if(self.health < self.maxhealth * 0.4)
		{
			dds_notify("low_health",self.team == "allies");
			maps\_utility::ent_flag_set("dds_low_health");
			thread reset_player_health();
		}

		maps\_utility::ent_flag_waitopen("dds_low_health");
	}
}

//Function Number: 65
reset_player_health()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self.health > self.maxhealth * 0.75)
		{
			maps\_utility::ent_flag_clear("dds_low_health");
			return;
		}

		wait(1);
	}
}

//Function Number: 66
dds_killstreak_timer()
{
	self endon("death");
	self endon("disconnect");
	var_00 = maps\_utility::getdvarintdefault("dds_killstreak_kills",3);
	var_01 = maps\_utility::getdvarintdefault("dds_killstreak_timer",10);
	for(;;)
	{
		level common_scripts\utility::flag_wait("dds_running_" + self.team);
		maps\_utility::ent_flag_wait("dds_killstreak");
		self.killstreakcounter++;
		if(!self.iskillstreaktimerrunning)
		{
			self.iskillstreaktimerrunning = 1;
			thread track_kills_over_time(var_00,var_01);
		}

		maps\_utility::ent_flag_clear("dds_killstreak");
	}
}

//Function Number: 67
track_kills_over_time(param_00,param_01)
{
	var_02 = gettime() + param_01 * 1000;
	while(gettime() < var_02)
	{
		if(self.killstreakcounter >= param_00)
		{
			dds_notify("killstreak",self.team == "allies");
			self.killstreakcounter = 0;
			var_02 = -1;
		}

		wait(0.1);
	}

	self.killstreakcounter = 0;
	self.iskillstreaktimerrunning = 0;
}

//Function Number: 68
dds_ai_init()
{
	if(!isdefined(level.dds))
	{
		return;
	}

	dds_get_ai_id();
	thread dds_watch_grenade_flee();
	thread dds_watch_damage();
}

//Function Number: 69
dds_get_ai_id()
{
	self.countryid = level.dds.countryids[self.voice].label;
	var_00 = 0;
	var_01 = 0;
	var_02 = tolower(self.classname);
	if(issubstr(var_02,"gideon"))
	{
		self.dds_characterid = "gdn";
	}
	else if(issubstr(var_02,"carter"))
	{
		self.dds_characterid = "ctr";
	}
	else if(issubstr(var_02,"joker"))
	{
		self.dds_characterid = "jkr";
	}
	else if(issubstr(var_02,"cormack"))
	{
		self.dds_characterid = "crk";
	}
	else if(issubstr(var_02,"knox"))
	{
		self.dds_characterid = "knx";
	}
	else if(issubstr(var_02,"ilana"))
	{
		self.dds_characterid = "iln";
	}
	else if(issubstr(var_02,"will"))
	{
		self.dds_characterid = "wil";
	}
	else if(issubstr(var_02,"jackson"))
	{
		self.dds_characterid = "jkn";
	}
	else if(issubstr(var_02,"ajani"))
	{
		self.dds_characterid = "ajn";
	}
	else if(self.team != "neutral")
	{
		if(isdefined(level.dds.countryids[self.voice]))
		{
			var_01 = 1;
			var_00 = level.dds.countryids[self.voice].count % level.dds.countryids[self.voice].max_voices;
			self.dds_characterid = level.dds.countryids[self.voice].label + var_00;
			level.dds.countryids[self.voice].count++;
		}
		else
		{
		}
	}
	else
	{
	}

	if(isdefined(self.dds_characterid) && !var_01)
	{
		level.dds.characterid_is_talking_currently[self.dds_characterid] = 0;
	}

	if(isdefined(self.dds_characterid) && !animscripts\battlechatter::bcsenabled())
	{
		self.npcid = var_00 + 1;
	}

	self.dds_disable = 0;
}

//Function Number: 70
dds_watch_grenade_flee()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_flee",var_00);
		if(var_00 == "frag_grenade_sp" || var_00 == "frag_grenade_future_sp" || var_00 == "frag_grenade_80s_sp")
		{
			dds_notify("react_grenade",self.team == "allies");
		}

		if(var_00 == "emp_grenade_sp")
		{
			dds_notify("react_emp",self.team == "allies");
		}
	}
}

//Function Number: 71
dds_watch_damage()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08);
		if(isdefined(var_01) && isdefined(var_01.team) && self.team == var_01.team)
		{
			dds_notify("react_friendly_fire",self.team == "allies");
		}

		if(isdefined(var_01) && isdefined(var_01.team) && var_04 == "MOD_RIFLE_BULLET" && get_current_weapon(var_01) == "iw5_em1_sp")
		{
			dds_notify("react_em1",self.team == "allies");
		}
	}
}

//Function Number: 72
get_current_weapon(param_00)
{
	var_01 = "";
	if(isplayer(param_00))
	{
		var_01 = param_00 getcurrentweapon();
		var_01 = getweaponbasename(var_01);
	}
	else if(isdefined(param_00.primaryweapon))
	{
		var_01 = getweaponbasename(param_00.primaryweapon);
	}

	return var_01;
}

//Function Number: 73
update_player_damage(param_00)
{
	if(!is_dds_enabled())
	{
		return;
	}

	self.dds_dmg_attacker = param_00;
}

//Function Number: 74
update_actor_damage(param_00,param_01)
{
	if(!is_dds_enabled())
	{
		return;
	}

	self.dds_dmg_attacker = param_00;
	if(isplayer(param_00))
	{
		switch(param_01)
		{
			case "MOD_IMPACT":
			case "MOD_GRENADE_SPLASH":
				break;
		}

		if(self.team == param_00.team)
		{
			self notify("dds_friendly_fire");
			return;
		}

		if(self.team == "neutral")
		{
			dds_notify("civ_fire",param_00.team == "allies");
			return;
		}
	}
}

//Function Number: 75
evaluatecombatevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!is_dds_enabled())
	{
		return;
	}

	if(!isdefined(self.node))
	{
		return;
	}

	if(!animscripts\battlechatter::isnodecoverorconceal())
	{
		return;
	}

	if(!animscripts\battlechatter_ai::nationalityokformoveorder())
	{
		return;
	}

	var_00 = get_order_responder("order_combatmove");
	if(isdefined(var_00))
	{
		dds_notify("order_suppress",self.team == "allies",undefined,var_00.dds_characterid);
	}
	else
	{
		dds_notify("order_suppress",self.team == "allies");
	}

	var_00 = get_order_responder("order_kill_command");
	if(isdefined(var_00))
	{
		dds_notify("order_kill_command",self.team == "allies",undefined,var_00.dds_characterid);
	}
	else
	{
		dds_notify("order_kill_command",self.team == "allies");
	}

	var_00 = get_order_responder("order_flush");
	if(isdefined(var_00))
	{
		dds_notify("order_flush",self.team == "allies",undefined,var_00.dds_characterid);
		return;
	}

	dds_notify("order_flush",self.team == "allies");
}

//Function Number: 76
evaluatemoveevent(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!is_dds_enabled())
	{
		return;
	}

	if(!isdefined(self.node))
	{
		return;
	}

	var_01 = distance(self.origin,self.node.origin);
	if(!animscripts\battlechatter::isnodecoverorconceal())
	{
		return;
	}

	if(!animscripts\battlechatter_ai::nationalityokformoveorder())
	{
		return;
	}

	if(self.combattime > 0)
	{
		if(param_00)
		{
			var_02 = get_order_responder("order_coverme");
			if(isdefined(var_02))
			{
				dds_notify("order_coverme",self.team == "allies",undefined,var_02.dds_characterid);
			}
			else
			{
				dds_notify("order_coverme",self.team == "allies");
			}

			var_02 = get_order_responder("order_combatmove");
			if(isdefined(var_02))
			{
				dds_notify("order_combatmove",self.team == "allies",undefined,var_02.dds_characterid);
			}
			else
			{
				dds_notify("order_combatmove",self.team == "allies");
			}
		}

		evaluatecombatevent();
		return;
	}

	if(animscripts\battlechatter_ai::nationalityokformoveordernoncombat())
	{
		var_02 = get_order_responder("order_noncombatmove");
		if(isdefined(var_02))
		{
			dds_notify("order_noncombatmove",self.team == "allies",undefined,var_02.dds_characterid);
			return;
		}

		dds_notify("order_noncombatmove",self.team == "allies");
		return;
	}
}

//Function Number: 77
get_order_responder(param_00)
{
	var_01 = get_responder_given_category(param_00);
	if(self.team == level.player.team)
	{
		if(!isdefined(var_01))
		{
			var_01 = level.player;
		}
		else if(randomint(100) < 50)
		{
			var_01 = level.player;
		}
	}

	return var_01;
}

//Function Number: 78
get_responder_given_category(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(self.team == "allies")
	{
		var_02 = find_dds_category_by_name(level.dds.categories,param_00);
	}
	else
	{
		var_02 = find_dds_category_by_name(level.dds.categories_axis,param_00);
	}

	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = var_02.rspns_cat_name;
	if(self.team == "allies")
	{
		var_02 = find_dds_category_by_name(level.dds.categories,var_03);
	}
	else
	{
		var_02 = find_dds_category_by_name(level.dds.categories_axis,var_03);
	}

	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_04 = spawnstruct();
	var_04.category_name = var_03;
	var_04.ent = self;
	var_04.ent_origin = self.origin;
	var_04.ent_team = self.team;
	var_04.isalliesline = self.team == "allies";
	var_01 = var_04 [[ var_02.get_talker_func ]](isdefined(var_02.rspns_cat_name),var_02.speaker_distance);
}

//Function Number: 79
check_kill_damage(param_00,param_01)
{
	if(isdefined(self.dds_dmg_attacker) && isdefined(self.dds_dmg_attacker.dds_dmg_attacker))
	{
		if(self == self.dds_dmg_attacker.dds_dmg_attacker)
		{
			return "kill_dmg_" + param_01;
		}
	}

	return param_00;
}

//Function Number: 80
dds_notify_mod(param_00,param_01)
{
	if(!is_dds_enabled())
	{
		return;
	}

	if(!isdefined(self.damagemod))
	{
		return;
	}

	if(isdefined(self.dds_dmg_attacker) && isdefined(self.team))
	{
		if(isdefined(self.dds_dmg_attacker.team) && self.dds_dmg_attacker.team == self.team || self.team == "neutral")
		{
			return;
		}
		else if(isdefined(self.dds_dmg_attacker.vteam) && self.dds_dmg_attacker.vteam == self.team)
		{
			return;
		}
	}

	var_02 = 0;
	if(!isdefined(param_01))
	{
		switch(self.damagemod)
		{
			case "MOD_DROWN":
			case "MOD_HIT_BY_OBJECT":
			case "MOD_BURNED":
			case "MOD_TRIGGER_HURT":
			case "MOD_SUICIDE":
			case "MOD_FALLING":
			case "MOD_TELEFRAG":
			case "MOD_CRUSH":
				break;

			case "MOD_BAYONET":
			case "MOD_UNKNOWN":
			case "MOD_PROJECTILE_SPLASH":
			case "MOD_PROJECTILE":
				break;

			case "MOD_MELEE":
			case "MOD_MELEE_ALT":
				dds_notify(check_kill_damage("kill_melee","melee"),param_00);
				break;

			case "MOD_EXPLOSIVE":
			case "MOD_GRENADE_SPLASH":
			case "MOD_GRENADE":
				dds_notify("kill_explo",param_00);
				break;

			case "MOD_RIFLE_BULLET":
			case "MOD_PISTOL_BULLET":
				if(animscripts\utility::issniperrifle(self.damageweapon))
				{
					dds_notify(check_kill_damage("react_sniper","shot"),!param_00);
					var_02 = 1;
					break;
				}
				else
				{
					dds_notify(check_kill_damage("kill_confirm","shot"),param_00);
					var_02 = 1;
					break;
				}
	
				break;

			case "MOD_HEAD_SHOT":
				var_02 = 1;
				break;

			default:
				break;
		}
	}
	else
	{
		dds_notify(param_01,param_00);
		var_02 = 1;
	}

	if(isplayer(self.attacker) && var_02)
	{
		self.attacker maps\_utility::ent_flag_set("dds_killstreak");
	}
}

//Function Number: 81
dds_notify_casualty()
{
	var_00 = self.team == "allies";
	dds_notify("casualty",var_00);
	thread dds_reinforcement_think(self.team);
}

//Function Number: 82
dds_reinforcement_think(param_00)
{
	if(isdefined(level.dds.reinforcement_endtime[param_00]))
	{
		level.dds.reinforcement_endtime[param_00] = gettime() + 5000;
		return;
	}

	var_01 = getaiarray(param_00);
	var_02 = var_01.size;
	var_03 = 0;
	level.dds.reinforcement_endtime[param_00] = gettime() + 5000;
	while(gettime() < level.dds.reinforcement_endtime[param_00])
	{
		var_01 = getaiarray(param_00);
		if(var_01.size > var_02)
		{
			var_03 = var_03 + var_01.size - var_02;
		}

		if(var_03 >= 1)
		{
			var_01[0] dds_notify("order_reinforce",param_00 == "allies");
			break;
		}

		var_02 = var_01.size;
		wait 0.05;
	}

	level.dds.reinforcement_endtime[param_00] = undefined;
}

//Function Number: 83
dds_notify_grenade(param_00,param_01,param_02)
{
	if(!is_dds_enabled())
	{
		return;
	}

	if(!param_02)
	{
		switch(param_00)
		{
			case "willy_pete_80s_sp":
			case "willy_pete_sp":
				dds_notify("smokeout",param_01);
				break;

			case "emp_grenade_sp":
				dds_notify("empout",param_01);
				break;

			case "vc_grenade_sp":
			case "molotov_sp":
			case "claymore_80s_sp":
			case "claymore_sp":
			case "m8_white_smoke_sp":
			case "flash_grenade_80s_sp":
			case "flash_grenade_sp":
				break;

			case "frag_grenade_80s_sp":
			case "frag_grenade_future_sp":
			case "frag_grenade_sp":
			default:
				dds_notify("fragout",param_01);
				break;
		}

		return;
	}

	dds_notify("frag_throwback",param_01);
}

//Function Number: 84
dds_notify_reload(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		dds_notify("reload",param_01);
		return;
	}
	else if(self getcurrentweaponclipammo() > 0)
	{
		return;
	}

	switch(param_00)
	{
		case "crossbow_explosive_alt_sp":
		case "crossbow_vzoom_alt_sp":
		case "crossbow_80s_sp":
		case "crossbow_sp":
			break;

		default:
			dds_notify("reload",param_01);
			break;
	}
}

//Function Number: 85
dds_notify(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.dds))
	{
		return;
	}

	if(!common_scripts\utility::flag("dds_running_allies") && param_01)
	{
		return;
	}

	if(!common_scripts\utility::flag("dds_running_axis") && !param_01)
	{
		return;
	}

	if(param_01 && !isdefined(level.dds.active_events[param_00]))
	{
		if(maps\_utility::getdvarintdefault("dds_logErrorsAndRequests"))
		{
		}

		return;
	}

	if(!param_01 && !isdefined(level.dds.active_events_axis[param_00]))
	{
		if(maps\_utility::getdvarintdefault("dds_logErrorsAndRequests"))
		{
		}

		return;
	}

	if(!param_01)
	{
		if(level.dds.active_events_axis[param_00].size > level.dds.max_active_events)
		{
			return;
		}
	}
	else if(level.dds.active_events[param_00].size > level.dds.max_active_events)
	{
		return;
	}

	var_04 = spawnstruct();
	var_04.category_name = param_00;
	var_04.ent = self;
	var_04.ent_threat = param_02;
	var_04.ent_origin = self.origin;
	var_04.ent_team = self.team;
	var_04.clear_event_on_prob = 0;
	var_04.processed = 0;
	var_04.ent_attacker = self.dds_dmg_attacker;
	var_04.isalliesline = param_01;
	var_04.optional_responder_name = param_03;
	if(!param_01)
	{
		var_05 = find_dds_category_by_name(level.dds.categories_axis,param_00);
		if(!isdefined(var_05))
		{
			return;
		}

		var_04.duration = var_05.duration;
		var_04.category_alias_name = var_05.alias_name;
		level.dds.active_events_axis[param_00][level.dds.active_events_axis[param_00].size] = var_04;
		return;
	}

	var_05 = find_dds_category_by_name(level.dds.categories,param_01);
	if(!isdefined(var_05))
	{
		return;
	}

	var_04.duration = var_05.duration;
	var_04.category_alias_name = var_05.alias_name;
	level.dds.active_events[param_00][level.dds.active_events[param_00].size] = var_04;
}

//Function Number: 86
dds_notify_response(param_00,param_01,param_02,param_03)
{
	param_00.category_response_name = param_03;
	param_00.processed = 0;
	if(param_03 == "grenade_rspns" && isdefined(param_00.ent) && isdefined(param_00.ent.grenade) && isdefined(param_00.ent.grenade.originalowner) && isdefined(param_00.ent.grenade.originalowner.team != param_00.ent_team))
	{
		return;
	}

	if(!param_00.isalliesline)
	{
		var_04 = find_dds_category_by_name(level.dds.categories_axis,param_00.category_response_name);
		if(!isdefined(var_04))
		{
			return;
		}

		param_00.duration = var_04.duration;
		param_00.category_alias_name = var_04.alias_name;
		level.dds.active_events_axis[param_00.category_response_name][level.dds.active_events_axis[param_00.category_response_name].size] = param_00;
		return;
	}

	var_04 = find_dds_category_by_name(level.dds.categories,param_01.category_response_name);
	if(!isdefined(var_04))
	{
		return;
	}

	param_00.duration = var_04.duration;
	param_00.category_alias_name = var_04.alias_name;
	level.dds.active_events[param_00.category_response_name][level.dds.active_events[param_00.category_response_name].size] = param_00;
}

//Function Number: 87
find_dds_category_by_name(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02].name == param_01)
		{
			return param_00[var_02];
		}
	}

	return undefined;
}

//Function Number: 88
dds_sort_ent_dist(param_00)
{
	var_01 = level.player;
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = distancesquared(var_01.origin,param_00[var_04].ent_origin);
		var_02[var_02.size] = var_05;
		var_03[var_03.size] = var_04;
	}

	var_06 = undefined;
	for(var_04 = 0;var_04 < var_02.size - 1;var_04++)
	{
		if(var_02[var_04] <= var_02[var_04 + 1])
		{
			continue;
		}

		var_06 = var_02[var_04];
		var_02[var_04] = var_02[var_04 + 1];
		var_02[var_04 + 1] = var_06;
		var_06 = var_03[var_04];
		var_03[var_04] = var_03[var_04 + 1];
		var_03[var_04 + 1] = var_06;
	}

	var_07 = [];
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_07[var_04] = param_00[var_03[var_04]];
	}

	return var_07;
}

//Function Number: 89
dds_sort_ent_duration(param_00)
{
	return param_00;
}

//Function Number: 90
dds_sort_ent_damage(param_00)
{
	return param_00;
}