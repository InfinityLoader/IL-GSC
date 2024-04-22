/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 1017 ms
 * Timestamp: 4/22/2024 2:37:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_dialogue_flags();
	setup_vo();
	thread start_dialogue_threads();
	thread init_pcap_vo();
}

//Function Number: 2
init_dialogue_flags()
{
	common_scripts\utility::flag_init("dialogue_droppod_intro_phase_2b");
	common_scripts\utility::flag_init("dialogue_droppod_intro_phase_3");
	common_scripts\utility::flag_init("dialogue_droppod_intro_phase_4a");
	common_scripts\utility::flag_init("dialogue_hotel_top_floor_start");
	common_scripts\utility::flag_init("vo_hotel_top_floor_ended");
	common_scripts\utility::flag_init("dialogue_hotel_top_floor_landassist");
	common_scripts\utility::flag_init("dialogue_hotel_top_floor_landassist_end");
	common_scripts\utility::flag_init("dialogue_hotel_mid_floor_glass_gag");
	common_scripts\utility::flag_init("dialogue_hotel_mid_floor_contact");
	common_scripts\utility::flag_init("dialogue_hotel_mid_floor_fight_over");
	common_scripts\utility::flag_init("dialogue_hotel_missile_dodge_pt1");
	common_scripts\utility::flag_init("dialogue_hotel_missile_dodge_pt2");
	common_scripts\utility::flag_init("dialogue_hotel_missile_dodge_pt3");
	common_scripts\utility::flag_init("dialogue_hotel_exit");
	common_scripts\utility::flag_init("dialogue_start_fob_meetup");
	common_scripts\utility::flag_init("dialogue_trench_demo_team");
	common_scripts\utility::flag_init("dialogue_drone_swarm_intro");
	common_scripts\utility::flag_init("dialogue_drone_swarm_intro_pt2");
	common_scripts\utility::flag_init("dialogue_drone_turret_sequence");
	common_scripts\utility::flag_init("dialogue_drone_turret_sequence_emp_1");
	common_scripts\utility::flag_init("dialogue_drone_turret_sequence_emp_2");
	common_scripts\utility::flag_init("dialogue_drone_turret_sequence_emp_3");
	common_scripts\utility::flag_init("dialogue_truck_push_sequence");
	common_scripts\utility::flag_init("dialogue_truck_push_sequence_start");
	common_scripts\utility::flag_init("dialogue_truck_push_sequence_end");
	common_scripts\utility::flag_init("dialogue_performing_arts_entrance");
	common_scripts\utility::flag_init("dialogue_performing_arts_entrance_2");
	common_scripts\utility::flag_init("dialogue_building_jump");
	common_scripts\utility::flag_init("dialogue_droppod_prelaunch");
	common_scripts\utility::flag_init("dialogue_droppod_prelaunch_end");
	common_scripts\utility::flag_init("dialogue_droppod_intro_phase_2b_2");
	common_scripts\utility::flag_init("vo_sinkhole_view");
	common_scripts\utility::flag_init("vo_sinkhole_first_drones");
	common_scripts\utility::flag_init("vo_sinkhole_car_fall");
	common_scripts\utility::flag_init("vo_subway_threat_moment");
	common_scripts\utility::flag_init("vo_subway_threat_moment_clear");
	common_scripts\utility::flag_init("vo_subway_see_civilians");
	common_scripts\utility::flag_init("vo_near_gate");
	common_scripts\utility::flag_init("vo_begin_seo_meet_atlas");
	common_scripts\utility::flag_init("vo_sd_attack_patrol");
	common_scripts\utility::flag_init("vo_sd_first_reinforcements");
	common_scripts\utility::flag_init("vo_inside_restaurant");
	common_scripts\utility::flag_init("vo_sd_demo_team_call");
	common_scripts\utility::flag_init("vo_sd_swarm_attacks");
	common_scripts\utility::flag_init("vo_canal_call_to_window");
	common_scripts\utility::flag_init("vo_canal_strategy_scene");
	common_scripts\utility::flag_init("vo_havoc_launcher_line_done");
	common_scripts\utility::flag_init("vo_demo_team_lines_done");
	common_scripts\utility::flag_init("vo_canal_grab_drone_controls");
	common_scripts\utility::flag_init("vo_canal_grab_explosives");
	common_scripts\utility::flag_init("vo_bomb_planting_instructions");
	common_scripts\utility::flag_init("vo_canal_finale_scene");
	common_scripts\utility::flag_init("vo_hotel_top_floor_ended");
	common_scripts\utility::flag_init("vo_canal_e3_only");
	common_scripts\utility::flag_init("vo_canal_e3_pt2");
	common_scripts\utility::flag_init("vo_canal_spaceman");
	common_scripts\utility::flag_init("vo_canal_razorback_arrival");
	common_scripts\utility::flag_init("vo_canal_razorback_attacked");
	common_scripts\utility::flag_init("vo_bomb_plant_reminder");
	common_scripts\utility::flag_init("play_radio_walkby_guy_vo");
	common_scripts\utility::flag_init("soldier_injured_dialogue");
	common_scripts\utility::flag_init("vo_nk_first_contact_start");
	common_scripts\utility::flag_init("vo_jump_training_start");
	common_scripts\utility::flag_init("vo_will_wep_nineoclock");
	common_scripts\utility::flag_init("vo_havoc_launcher_done");
	common_scripts\utility::flag_init("vo_subway_car_start");
	common_scripts\utility::flag_init("vo_post_building_jump_start");
	common_scripts\utility::flag_init("vo_subway_dead_civs");
}

//Function Number: 3
setup_vo()
{
	var_00 = "spaceman";
	var_01 = "cormack";
	var_02 = "will_irons";
	var_03 = "jackson";
	var_04 = "daniels";
	var_05 = "gideon";
	var_06 = "generic";
	var_07 = "generic";
	var_08 = "generic";
	var_09 = "generic";
	var_0A = "generic";
	var_0B = "generic";
	var_0C = "generic";
	var_0D = "generic";
	var_0E = "generic";
	var_0F = "generic";
	var_10 = "generic";
	var_11 = "generic";
	level.scr_radio[var_00]["seo_spm_allunitsallunits"] = "seo_spm_allunitsallunits";
	level.scr_sound[var_01]["seo_crk_granitezeroone"] = "seo_crk_granitezeroone";
	level.scr_radio[var_0A]["seo_bcr_allpodsset"] = "seo_bcr_allpodsset";
	level.scr_radio[var_00]["seo_spm_copydroppingatgrid"] = "seo_spm_copydroppingatgrid";
	level.scr_radio[var_0A]["seo_bcr_beadvisedenemycontact"] = "seo_bcr_beadvisedenemycontact";
	level.scr_radio[var_00]["seo_spm_copythatdropgreen"] = "seo_spm_copythatdropgreen";
	level.scr_sound[var_01]["seo_crk_everyoneholdtight"] = "seo_crk_everyoneholdtight";
	level.scr_sound[var_02]["seo_wil_justlikeintraining"] = "seo_wil_justlikeintraining";
	level.scr_radio[var_00]["seo_spm_allpodsready"] = "seo_spm_allpodsready";
	level.scr_sound[var_03]["seo_jkn_goddamn"] = "seo_jkn_goddamn";
	level.scr_sound[var_01]["seo_crk_30seconds"] = "seo_crk_30seconds";
	level.scr_sound[var_02]["seo_wil_letsmakeadifference"] = "seo_wil_letsmakeadifference";
	level.scr_sound[var_01]["seo_crk_spacemanimseeingheavy"] = "seo_crk_spacemanimseeingheavy";
	level.scr_radio[var_00]["seo_spm_copythatgranite"] = "seo_spm_copythatgranite";
	level.scr_sound[var_06]["seo_rds_ahhh"] = "seo_rds_ahhh";
	level.scr_sound[var_01]["seo_crk_holdon"] = "seo_crk_holdon";
	level.scr_sound[var_01]["seo_crk_mitchellclosetheblast"] = "seo_crk_mitchellclosetheblast";
	level.scr_sound[var_01]["seo_crk_exertion1"] = "seo_crk_exertion1";
	level.scr_sound[var_01]["seo_crk_braceyourselves"] = "seo_crk_braceyourselves";
	level.scr_sound[var_03]["seo_jkn_shit"] = "seo_jkn_shit";
	level.scr_sound[var_02]["seo_wil_youstillinonepiece"] = "seo_wil_youstillinonepiece";
	level.scr_sound[var_01]["seo_crk_everybodygood"] = "seo_crk_everybodygood";
	level.scr_sound[var_02]["seo_wil_copy"] = "seo_wil_copy";
	level.scr_sound[var_01]["seo_crk_okaymitchellgetthedoor"] = "seo_crk_okaymitchellgetthedoor";
	level.scr_sound[var_01]["seo_crk_everyonepushout"] = "seo_crk_everyonepushout";
	level.scr_sound[var_02]["seo_wil_lookout"] = "seo_wil_lookout";
	level.scr_sound[var_01]["seo_crk_spacemanwearedownhard"] = "seo_crk_spacemanwearedownhard";
	level.scr_radio[var_00]["seo_spm_copythatifyouare"] = "seo_spm_copythatifyouare";
	level.scr_sound[var_01]["seo_crk_welltrytomakeit"] = "seo_crk_welltrytomakeit";
	level.scr_sound[var_01]["seo_crk_okayweneedtoget2"] = "seo_crk_okayweneedtoget2";
	level.scr_sound[var_02]["seo_wil_yessir"] = "seo_wil_yessir";
	level.scr_sound[var_02]["seo_wil_gotasheerdrop"] = "seo_wil_gotasheerdrop";
	level.scr_sound[var_01]["seo_crk_wellhavetojump"] = "seo_crk_wellhavetojump";
	level.scr_sound[var_01]["seo_crk_remembershortbursts"] = "seo_crk_remembershortbursts";
	level.scr_sound[var_01]["seo_crk_mitchellyoureup"] = "seo_crk_mitchellyoureup";
	level.scr_sound[var_01]["seo_crk_jumpitmitchell"] = "seo_crk_jumpitmitchell";
	level.scr_sound[var_03]["seo_jkn_whatthehell"] = "seo_jkn_whatthehell";
	level.scr_sound[var_01]["seo_crk_havocmissiles"] = "seo_crk_havocmissiles";
	level.scr_sound[var_03]["seo_jkn_damn"] = "seo_jkn_damn";
	level.scr_sound[var_02]["seo_wil_contactcontact"] = "seo_wil_contactcontact";
	level.scr_sound[var_01]["seo_crk_lightemup"] = "seo_crk_lightemup";
	level.scr_sound[var_01]["seo_crk_clear"] = "seo_crk_clear";
	level.scr_sound[var_02]["seo_wil_myfirstkill"] = "seo_wil_myfirstkill";
	level.scr_sound[var_01]["seo_crk_everyonesticktogether"] = "seo_crk_everyonesticktogether";
	level.scr_sound[var_03]["seo_jkn_anotherdropover"] = "seo_jkn_anotherdropover";
	level.scr_sound[var_01]["seo_crk_okheaddown"] = "seo_crk_okheaddown";
	level.scr_sound[var_01]["seo_crk_throughhere"] = "seo_crk_throughhere";
	level.scr_sound[var_02]["seo_wil_missilesincoming"] = "seo_wil_missilesincoming";
	level.scr_sound[var_01]["seo_crk_gogogo"] = "seo_crk_gogogo";
	level.scr_sound[var_01]["seo_crk_jump"] = "seo_crk_jump";
	level.scr_sound[var_01]["seo_crk_everyoneup"] = "seo_crk_everyoneup";
	level.scr_sound[var_03]["seo_jkn_ithinkso"] = "seo_jkn_ithinkso";
	level.scr_sound[var_01]["seo_crk_commandpostshould"] = "seo_crk_commandpostshould";
	level.scr_sound[var_07]["seo_mrn1_thisisbadgertwo"] = "seo_mrn1_thisisbadgertwo";
	level.scr_radio[var_00]["seo_spm_badgertwothisis"] = "seo_spm_badgertwothisis";
	level.scr_sound[var_07]["seo_mrn1_preparetocopy"] = "seo_mrn1_preparetocopy";
	level.scr_radio[var_00]["seo_spm_solidcopybadger"] = "seo_spm_solidcopybadger";
	level.scr_sound[var_08]["seo_mrn2_wehaveaman"] = "seo_mrn2_wehaveaman";
	level.scr_radio[var_0A]["seo_bcr_solidcopybravothree"] = "seo_bcr_solidcopybravothree";
	level.scr_sound[var_08]["seo_mrn2_rogerweareegressing"] = "seo_mrn2_rogerweareegressing";
	level.scr_radio[var_0A]["seo_bcr_solidcopyonall"] = "seo_bcr_solidcopyonall";
	level.scr_sound[var_08]["seo_mrn2_moveout"] = "seo_mrn2_moveout";
	level.scr_sound[var_04]["seo_dnl_whothehellareyou"] = "seo_dnl_whothehellareyou";
	level.scr_sound[var_01]["seo_crk_granitesquad"] = "seo_crk_granitesquad";
	level.scr_sound[var_04]["seo_dnl_theyrealreadyonthe"] = "seo_dnl_theyrealreadyonthe";
	level.scr_sound[var_01]["seo_crk_whatstheirposition"] = "seo_crk_whatstheirposition";
	level.scr_sound[var_04]["seo_dnl_twoklicksnorth"] = "seo_dnl_twoklicksnorth";
	level.scr_sound[var_01]["seo_crk_alrightweremoving"] = "seo_crk_alrightweremoving";
	level.scr_sound[var_04]["seo_dnl_aresaresweneedsome"] = "seo_dnl_aresaresweneedsome";
	level.scr_sound[var_09]["seo_mrn3_notgettingthrough"] = "seo_mrn3_notgettingthrough";
	level.scr_sound[var_01]["seo_crk_demoteamone"] = "seo_crk_demoteamone";
	level.scr_sound[var_01]["seo_crk_damnnotgetting"] = "seo_crk_damnnotgetting";
	level.scr_sound[var_02]["seo_wil_watchyerhead"] = "seo_wil_watchyerhead";
	level.scr_radio[var_00]["seo_spm_granitezeroone"] = "seo_spm_granitezeroone";
	level.scr_sound[var_01]["seo_crk_copythateveryonekeep"] = "seo_crk_copythateveryonekeep";
	level.scr_sound[var_03]["seo_jkn_hereitcomes"] = "seo_jkn_hereitcomes";
	level.scr_sound[var_01]["seo_crk_swarmeveryonegetdown"] = "seo_crk_swarmeveryonegetdown";
	level.scr_sound[var_02]["seo_wil_grabcovergrabcover"] = "seo_wil_grabcovergrabcover";
	level.scr_sound[var_03]["seo_jkn_holyshit"] = "seo_jkn_holyshit";
	level.scr_sound[var_02]["seo_wil_protectyourselves"] = "seo_wil_protectyourselves";
	level.scr_sound[var_01]["seo_crk_someonegetonthat"] = "seo_crk_someonegetonthat";
	level.scr_sound[var_01]["seo_crk_mitchellgettothe"] = "seo_crk_mitchellgettothe";
	level.scr_sound[var_01]["seo_crk_usethatturret"] = "seo_crk_usethatturret";
	level.scr_sound[var_01]["seo_crk_keepthosedronesoffus"] = "seo_crk_keepthosedronesoffus";
	level.scr_sound[var_01]["seo_crk_hitthosedrones"] = "seo_crk_hitthosedrones";
	level.scr_sound[var_03]["seo_jkn_theyreeverywhere"] = "seo_jkn_theyreeverywhere";
	level.scr_sound[var_01]["seo_crk_empsat50"] = "seo_crk_empsat50";
	level.scr_sound[var_01]["seo_crk_empscharged"] = "seo_crk_empscharged";
	level.scr_sound[var_01]["seo_crk_activatetheemp"] = "seo_crk_activatetheemp";
	level.scr_sound[var_01]["seo_crk_fireoffthatemp"] = "seo_crk_fireoffthatemp";
	level.scr_sound[var_03]["seo_jkn_hooah"] = "seo_jkn_hooah";
	level.scr_sound[var_01]["seo_crk_goodworksolider"] = "seo_crk_goodworksolider";
	level.scr_sound[var_02]["seo_wil_niceshooting"] = "seo_wil_niceshooting";
	level.scr_sound[var_03]["seo_jkn_thoughtweweredead"] = "seo_jkn_thoughtweweredead";
	level.scr_sound[var_01]["seo_crk_granitesquadfallout"] = "seo_crk_granitesquadfallout";
	level.scr_sound[var_02]["seo_wil_roadsblockedsir"] = "seo_wil_roadsblockedsir";
	level.scr_sound[var_01]["seo_crk_getthistruckofftheroad"] = "seo_crk_getthistruckofftheroad";
	level.scr_sound[var_02]["seo_wil_copymitchellgivemea"] = "seo_wil_copymitchellgivemea";
	level.scr_sound[var_02]["seo_wil_helpmeoutman"] = "seo_wil_helpmeoutman";
	level.scr_sound[var_01]["seo_crk_mitchellyoureonirons"] = "seo_crk_mitchellyoureonirons";
	level.scr_sound[var_02]["seo_wil_feelstrongashellinthis"] = "seo_wil_feelstrongashellinthis";
	level.scr_sound[var_01]["seo_crk_okayletsmove"] = "seo_crk_okayletsmove";
	level.scr_sound[var_02]["seo_wil_havoclauncheratournine"] = "seo_wil_havoclauncheratournine";
	level.scr_sound[var_01]["seo_crk_demoteamonethisisgranite"] = "seo_crk_demoteamonethisisgranite";
	level.scr_radio[var_0B]["seo_dmo_hearyougranitezeroone"] = "seo_dmo_hearyougranitezeroone";
	level.scr_sound[var_01]["seo_crk_copywearereciving"] = "seo_crk_copywearereciving";
	level.scr_radio[var_0B]["seo_dmo_copythatwearestong"] = "seo_dmo_copythatwearestong";
	level.scr_sound[var_01]["seo_crk_okayletshustlegranite"] = "seo_crk_okayletshustlegranite";
	level.scr_sound[var_01]["seo_crk_mitchellhitthedoor"] = "seo_crk_mitchellhitthedoor";
	level.scr_sound[var_01]["seo_crk_hitthatdoormitchell"] = "seo_crk_hitthatdoormitchell";
	level.scr_sound[var_01]["seo_crk_throughthelobby"] = "seo_crk_throughthelobby";
	level.scr_sound[var_02]["seo_wil_ziplinerscomingin"] = "seo_wil_ziplinerscomingin";
	level.scr_sound[var_01]["seo_crk_needtocrossover"] = "seo_crk_needtocrossover";
	level.scr_sound[var_01]["seo_crk_ironsyoureupfirst"] = "seo_crk_ironsyoureupfirst";
	level.scr_sound[var_02]["seo_wil_onlyliveonce"] = "seo_wil_onlyliveonce";
	level.scr_sound[var_01]["seo_crk_youreupmitchell"] = "seo_crk_youreupmitchell";
	level.scr_sound[var_02]["seo_wil_theytookoutthe"] = "seo_wil_theytookoutthe";
	level.scr_sound[var_01]["seo_crk_weregonnahvetogetaround"] = "seo_crk_weregonnahvetogetaround";
	level.scr_sound[var_02]["seo_wil_lookout1"] = "seo_wil_lookout1";
	level.scr_sound[var_03]["seo_jkn_dronesdrones"] = "seo_jkn_dronesdrones";
	level.scr_sound[var_01]["seo_crk_civilianscheckyourfire"] = "seo_crk_civilianscheckyourfire";
	level.scr_sound[var_0C]["seo_cv1_itsmylegithinkitsbroken"] = "seo_cv1_itsmylegithinkitsbroken";
	level.scr_sound[var_0D]["seo_cv2_youregoingtobealright"] = "seo_cv2_youregoingtobealright";
	level.scr_sound[var_0E]["seo_cv3_whenisthemilitarygoingto"] = "seo_cv3_whenisthemilitarygoingto";
	level.scr_sound[var_0C]["seo_cv1_idontthinkicanwalk"] = "seo_cv1_idontthinkicanwalk";
	level.scr_sound[var_0D]["seo_cv2_soldiersshouldbehereto"] = "seo_cv2_soldiersshouldbehereto";
	level.scr_sound[var_0E]["seo_cv3_wevebeendownherefor"] = "seo_cv3_wevebeendownherefor";
	level.scr_sound[var_0C]["seo_cv1_ohgodweregoingtodie"] = "seo_cv1_ohgodweregoingtodie";
	level.scr_sound[var_0C]["seo_cv1_ineedtocallmyhusband"] = "seo_cv1_ineedtocallmyhusband";
	level.scr_sound[var_01]["seo_crk_mitchellgetthatgate"] = "seo_crk_mitchellgetthatgate";
	level.scr_sound[var_01]["seo_crk_getthegatemitchell"] = "seo_crk_getthegatemitchell";
	level.scr_sound[var_02]["seo_wil_checkfireblueblue"] = "seo_wil_checkfireblueblue";
	level.scr_sound[var_01]["seo_crk_idyourselves"] = "seo_crk_idyourselves";
	level.scr_sound[var_05]["seo_gdn_atlaspmcrescueforece"] = "seo_gdn_atlaspmcrescueforece";
	level.scr_sound[var_01]["seo_crk_howstheweathersouthside"] = "seo_crk_howstheweathersouthside";
	level.scr_sound[var_05]["seo_gdn_itsafuckinmessbetterodds"] = "seo_gdn_itsafuckinmessbetterodds";
	level.scr_sound[var_01]["seo_crk_copythat"] = "seo_crk_copythat";
	level.scr_sound[var_05]["seo_gdn_goodluckletsmove"] = "seo_gdn_goodluckletsmove";
	level.scr_sound[var_03]["seo_jkn_atlaswillisntthatyourdads"] = "seo_jkn_atlaswillisntthatyourdads";
	level.scr_sound[var_02]["seo_wil_yep"] = "seo_wil_yep";
	level.scr_sound[var_03]["seo_jkn_theygotthebestgear"] = "seo_jkn_theygotthebestgear";
	level.scr_sound[var_02]["seo_wil_wantedtoservemycountry"] = "seo_wil_wantedtoservemycountry";
	level.scr_sound[var_01]["seo_crk_patroldropem"] = "seo_crk_patroldropem";
	level.scr_sound[var_03]["seo_crk_jkn_morecomingin"] = "seo_crk_jkn_morecomingin";
	level.scr_sound[var_02]["seo_wil_mitchellivegotyou"] = "seo_wil_mitchellivegotyou";
	level.scr_radio[var_0B]["seo_dmo_granitewherethehell"] = "seo_dmo_granitewherethehell";
	level.scr_sound[var_01]["seo_crk_demoteamonecomein"] = "seo_crk_demoteamonecomein";
	level.scr_sound[var_01]["seo_crk_shitwegottamoveit"] = "seo_crk_shitwegottamoveit";
	level.scr_sound[var_01]["seo_crk_droneswarminside"] = "seo_crk_droneswarminside";
	level.scr_sound[var_01]["seo_crk_getoffthestreet"] = "seo_crk_getoffthestreet";
	level.scr_sound[var_02]["seo_wil_thoseweretheswarm"] = "seo_wil_thoseweretheswarm";
	level.scr_sound[var_01]["seo_crk_weneedtogeteyes"] = "seo_crk_weneedtogeteyes";
	level.scr_sound[var_01]["seo_crk_overheremitchell"] = "seo_crk_overheremitchell";
	level.scr_sound[var_01]["seo_crk_mitchellmoveit"] = "seo_crk_mitchellmoveit";
	level.scr_sound[var_01]["seo_crk_theresthehavoclauncher"] = "seo_crk_theresthehavoclauncher";
	level.scr_sound[var_02]["seo_wil_overthereshittheyrekia"] = "seo_wil_overthereshittheyrekia";
	level.scr_sound[var_01]["seo_crk_okayokayicanseetheir"] = "seo_crk_okayokayicanseetheir";
	level.scr_sound[var_03]["seo_jkn_sirwearentademo"] = "seo_jkn_sirwearentademo";
	level.scr_sound[var_01]["seo_crk_nowerenotbutwewaitfor"] = "seo_crk_nowerenotbutwewaitfor";
	level.scr_sound[var_02]["seo_wil_illgetthechargessir"] = "seo_wil_illgetthechargessir";
	level.scr_sound[var_01]["seo_crk_yoursurewill"] = "seo_crk_yoursurewill";
	level.scr_sound[var_02]["seo_wil_yeahicanmakeit"] = "seo_wil_yeahicanmakeit";
	level.scr_sound[var_01]["seo_crk_okaymitchellyourewithirons"] = "seo_crk_okaymitchellyourewithirons";
	level.scr_sound[var_02]["seo_wil_letsdoit"] = "seo_wil_letsdoit";
	level.scr_sound[var_01]["seo_crk_grabthosedronecontrols"] = "seo_crk_grabthosedronecontrols";
	level.scr_sound[var_02]["seo_wil_getthosedronesgoing"] = "seo_wil_getthosedronesgoing";
	level.scr_sound[var_02]["seo_wil_activatethedrones"] = "seo_wil_activatethedrones";
	level.scr_sound[var_02]["seo_wil_contact"] = "seo_wil_contact";
	level.scr_sound[var_02]["seo_wil_usethosedrones"] = "seo_wil_usethosedrones";
	level.scr_sound[var_02]["seo_wil_gogo"] = "seo_wil_gogo";
	level.scr_sound[var_02]["seo_wil_timedchargesgrabem"] = "seo_wil_timedchargesgrabem";
	level.scr_sound[var_02]["seo_wil_getthecharges"] = "seo_wil_getthecharges";
	level.scr_sound[var_02]["seo_wil_grabthosecharges"] = "seo_wil_grabthosecharges";
	level.scr_radio[var_01]["seo_crk_willthatlauncherisheavily"] = "seo_crk_willthatlauncherisheavily";
	level.scr_sound[var_02]["seo_wil_copythatsir"] = "seo_wil_copythatsir";
	level.scr_sound[var_02]["seo_wil_mitchelloverhere"] = "seo_wil_mitchelloverhere";
	level.scr_sound[var_02]["seo_wil_mitchellineedthe"] = "seo_wil_mitchellineedthe";
	level.scr_sound[var_02]["seo_wil_comeonmitchell"] = "seo_wil_comeonmitchell";
	level.scr_sound[var_02]["seo_wil_holdthathatchopen"] = "seo_wil_holdthathatchopen";
	level.scr_sound[var_02]["seo_wil_okaytimersetletsget"] = "seo_wil_okaytimersetletsget";
	level.scr_sound[var_02]["seo_wil_damnthinkmyarmsbroke"] = "seo_wil_damnthinkmyarmsbroke";
	level.scr_sound[var_02]["seo_wil_okaypull"] = "seo_wil_okaypull";
	level.scr_sound[var_02]["seo_wil_shitdontworryaboutthat"] = "seo_wil_shitdontworryaboutthat";
	level.scr_sound[var_02]["seo_wil_nnnnngh"] = "seo_wil_nnnnngh";
	level.scr_sound[var_02]["seo_wil_itsliftingoffyougottago"] = "seo_wil_itsliftingoffyougottago";
	level.scr_sound[var_02]["seo_wil_mitchellwereoutoftime"] = "seo_wil_mitchellwereoutoftime";
	level.scr_sound[var_02]["seo_wil_makeadifference"] = "seo_wil_makeadifference";
	level.scr_sound[var_01]["seo_crk_mitchellmitchell"] = "seo_crk_mitchellmitchell";
	level.scr_sound[var_01]["seo_crk_holdonmanholdon"] = "seo_crk_holdonmanholdon";
	level.scr_sound[var_01]["seo_crk_staywithme"] = "seo_crk_staywithme";
	level.scr_sound[var_01]["seo_crk_youregoingtobealright"] = "seo_crk_youregoingtobealright";
	level.scr_sound[var_01]["seo_crk_weregettingyouhome"] = "seo_crk_weregettingyouhome";
	level.scr_sound[var_01]["seo_crk_openthehatchmitchell"] = "seo_crk_openthehatchmitchell";
	level.scr_sound[var_01]["seo_crk_mitchellgetusoutof"] = "seo_crk_mitchellgetusoutof";
	level.scr_sound[var_02]["seo_wil_damn2"] = "seo_wil_damn2";
	level.scr_sound[var_00]["seo_spn_keepyoureyesopenfor"] = "seo_spn_keepyoureyesopenfor";
	level.scr_sound[var_01]["seo_crk_copythan"] = "seo_crk_copythan";
	level.scr_sound[var_11]["seo_knr_checkthatdoorwayoverhere"] = "seo_knr_checkthatdoorwayoverhere";
	level.scr_sound[var_01]["seo_crk_contactcontact"] = "seo_crk_contactcontact";
	level.scr_sound[var_01]["seo_crk_clear3"] = "seo_crk_clear3";
	level.scr_sound[var_01]["seo_crk_staytogethermitchell"] = "seo_crk_staytogethermitchell";
	level.scr_sound[var_01]["seo_crk_stayonmission"] = "seo_crk_stayonmission";
	level.scr_sound[var_01]["seo_crk_overhere2"] = "seo_crk_overhere2";
	level.scr_sound[var_01]["seo_crk_whereareyougoingsoldier"] = "seo_crk_whereareyougoingsoldier";
	level.scr_sound[var_10]["seo_tnt_icantgetalock"] = "seo_tnt_icantgetalock";
	level.scr_sound[var_10]["seo_tnt_theyrealloverus"] = "seo_tnt_theyrealloverus";
	level.scr_sound[var_10]["seo_tnt_takingheavydamage"] = "seo_tnt_takingheavydamage";
	level.scr_sound[var_10]["seo_tnt_tankingtoomuchdamstatic"] = "seo_tnt_tankingtoomuchdamstatic";
	level.scr_sound[var_10]["seo_tnt_thanksforthehelpbadger"] = "seo_tnt_thanksforthehelpbadger";
	level.scr_sound[var_01]["seo_crk_keeponthem"] = "seo_crk_keeponthem";
	level.scr_sound[var_01]["seo_crk_getonthosedronesmitchell"] = "seo_crk_getonthosedronesmitchell";
	level.scr_sound[var_01]["seo_crk_goodworkkeepitup"] = "seo_crk_goodworkkeepitup";
	level.scr_sound[var_01]["seo_crk_aimatthosedrones"] = "seo_crk_aimatthosedrones";
	level.scr_sound[var_01]["seo_crk_mitchelloverhere"] = "seo_crk_mitchelloverhere";
	level.scr_sound[var_01]["seo_crk_useyourboosterstoget"] = "seo_crk_useyourboosterstoget";
	level.scr_sound[var_01]["seo_crk_jumpoverthetruckmitchell"] = "seo_crk_jumpoverthetruckmitchell";
	level.scr_sound[var_01]["seo_crk_useyourboosters2"] = "seo_crk_useyourboosters2";
	level.scr_sound[var_01]["seo_crk_weneedtopushthrough"] = "seo_crk_weneedtopushthrough";
	level.scr_sound[var_01]["seo_crk_gogo2"] = "seo_crk_gogo2";
	level.scr_sound[var_02]["seo_wil_thisisnothinglikebasic"] = "seo_wil_thisisnothinglikebasic";
	level.scr_sound[var_03]["seo_jcn_thiswholecityisfucked"] = "seo_jcn_thiswholecityisfucked";
	level.scr_sound[var_01]["seo_crk_securethatshitkeepmoving"] = "seo_crk_securethatshitkeepmoving";
	level.scr_sound[var_02]["seo_wil_whatthehellhitthis"] = "seo_wil_whatthehellhitthis";
	level.scr_sound[var_01]["seo_crk_thehavoclauncher"] = "seo_crk_thehavoclauncher";
	level.scr_sound[var_03]["seo_jcn_havoclauncherdeadahead"] = "seo_jcn_havoclauncherdeadahead";
	level.scr_sound[var_01]["seo_crk_thatsourtarget"] = "seo_crk_thatsourtarget";
	level.scr_sound[var_01]["seo_crk_throughthesubwaycar"] = "seo_crk_throughthesubwaycar";
	level.scr_sound[var_01]["seo_crk_theyrepoppingsmoke"] = "seo_crk_theyrepoppingsmoke";
	level.scr_sound[var_01]["seo_crk_clear2"] = "seo_crk_clear2";
	level.scr_sound[var_02]["seo_wil_shit2"] = "seo_wil_shit2";
	level.scr_sound[var_01]["seo_crk_stayfocused"] = "seo_crk_stayfocused";
	level.scr_sound[var_02]["seo_wil_gotsomewoundedheresir"] = "seo_wil_gotsomewoundedheresir";
	level.scr_sound[var_01]["seo_crk_negativewill"] = "seo_crk_negativewill";
	level.scr_sound[var_10]["seo_pa_allcitizensproceedtoevacuation"] = "seo_pa_allcitizensproceedtoevacuation";
	level.scr_sound[var_10]["seo_pa_returntoyourhomes"] = "seo_pa_returntoyourhomes";
	level.scr_sound[var_10]["seo_pa_alllawenforcementpersonnelreport"] = "seo_pa_alllawenforcementpersonnelreport";
	level.scr_sound[var_10]["seo_pa_reportanysuspiciousactivityto"] = "seo_pa_reportanysuspiciousactivityto";
	level.scr_sound[var_01]["seo_crk_cutthechattermovementahead"] = "seo_crk_cutthechattermovementahead";
	level.scr_sound[var_0F]["seo_rzr_thisisdefender23coming"] = "seo_rzr_thisisdefender23coming";
	level.scr_sound[var_0F]["seo_rzr_gunsgunsguns"] = "seo_rzr_gunsgunsguns";
	level.scr_sound[var_0F]["seo_rzr_switchingtargets"] = "seo_rzr_switchingtargets";
	level.scr_sound[var_0F]["seo_rzr_weretakinghitsmovingposition"] = "seo_rzr_weretakinghitsmovingposition";
	level.scr_sound[var_00]["seo_spn_cormackthatlauncheristearing"] = "seo_spn_cormackthatlauncheristearing";
	level.scr_sound[var_01]["seo_crk_demoteamiskia"] = "seo_crk_demoteamiskia";
	level.scr_sound[var_02]["seo_wil_okletsmakesurethese"] = "seo_wil_okletsmakesurethese";
	level.scr_sound[var_02]["seo_wil_keephittingthemmitchell"] = "seo_wil_keephittingthemmitchell";
	level.scr_sound[var_02]["seo_wil_pushtothelauncher"] = "seo_wil_pushtothelauncher";
	level.scr_sound[var_02]["seo_wil_wecandothis"] = "seo_wil_wecandothis";
	level.scr_sound[var_01]["seo_crk_overheremitchell2"] = "seo_crk_overheremitchell2";
	level.scr_sound[var_01]["seo_crk_keepmoving"] = "seo_crk_keepmoving";
}

//Function Number: 4
start_dialogue_threads()
{
	thread dialogue_droppod_prelaunch();
	thread dialogue_droppod_intro();
	thread dialogue_hotel_top_floor_landing();
	thread dialogue_hotel_top_floor_nk_soldier_spotted();
	thread dialogue_hotel_top_floor_landassist();
	thread dialogue_hotel_mid_floor_glass_gag();
	thread dialogue_hotel_mid_floor_contact();
	thread dialogue_hotel_mid_floor_fight_over();
	thread dialogue_hotel_missile_dodge();
	thread dialogue_hotel_exit();
	thread dialogue_trench_demo_team();
	thread dialogue_drone_swarm_intro();
	thread dialogue_drone_turret_sequence();
	thread dialogue_truck_push_sequence();
	thread dialogue_performing_arts_entrance();
	thread vo_push_through_hotel();
	thread vo_zipliners_hotel();
	thread dialogue_building_jump();
	thread vo_nk_first_contact();
	thread vo_jump_training();
	thread vo_post_building_jump();
	thread vo_fob_meetup();
	thread vo_sinkhole();
	thread vo_subway_car();
	thread vo_subway_threat_grenade_moment();
	thread vo_subway();
	thread vo_meet_atlas_dialogue();
	thread vo_shopping_district();
	thread vo_sd_drone_swarm_dialogue();
	thread vo_canal();
	thread vo_canal_plant_explosives();
	thread vo_canal_razorback();
	thread vo_canal_finale();
	thread vo_canal_e3();
	thread radio_walkby_guy_vo();
	thread injured_guy_vo();
	thread generic_keep_moving();
	thread generic_clear();
}

//Function Number: 5
generic_keep_moving()
{
	var_00 = ["seo_crk_gogo2","seo_crk_keepmoving"];
	for(;;)
	{
		level waittill("vo_keep_moving");
		level.cormack maps\_utility::dialogue_queue(common_scripts\utility::random(var_00));
	}
}

//Function Number: 6
generic_clear()
{
	var_00 = ["seo_crk_clear2"];
	for(;;)
	{
		level waittill("vo_area_clear");
		level.cormack maps\_utility::dialogue_queue(common_scripts\utility::random(var_00));
	}
}

//Function Number: 7
dialogue_droppod_prelaunch()
{
	common_scripts\utility::flag_wait("dialogue_droppod_prelaunch");
	soundscripts\_snd::snd_message("dialogue_droppod_intro_prelaunch");
	level maps\_utility::dialogue_queue("seo_spm_allunitsallunits");
	level.cormack_intro maps\_utility::dialogue_queue("seo_crk_granitezeroone");
	maps\_utility::dialogue_queue("seo_bcr_allpodsset");
	level maps\_utility::dialogue_queue("seo_spm_copydroppingatgrid");
	soundscripts\_snd::snd_message("droppod_intro_radio_duck");
	maps\_utility::dialogue_queue("seo_bcr_beadvisedenemycontact");
	thread maps\_utility::flag_set_delayed("dialogue_droppod_prelaunch_end",6);
	level maps\_utility::dialogue_queue("seo_spm_allpodsready");
}

//Function Number: 8
dialogue_droppod_intro()
{
	common_scripts\utility::flag_wait("dialogue_droppod_intro_phase_2b_2");
	level.jackson_intro maps\_utility::dialogue_queue("seo_jkn_goddamn");
	level.cormack_intro maps\_utility::dialogue_queue("seo_crk_30seconds");
	common_scripts\utility::flag_wait("dialogue_droppod_intro_phase_3");
}

//Function Number: 9
dialogue_hotel_top_floor_landing()
{
	level waittill("vo_start_spaceman_warn");
	wait(9);
	maps\_utility::dialogue_queue("seo_spn_keepyoureyesopenfor");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("seo_crk_copythan");
	level waittill("droppod_begin_fall");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_lookout");
	wait(3);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_damn2");
	level thread maps\_utility::notify_delay("begin_building_traversal",2);
	level.cormack maps\_utility::dialogue_queue("seo_crk_okayweneedtoget2");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_yessir");
	common_scripts\utility::flag_set("vo_hotel_top_floor_ended");
}

//Function Number: 10
dialogue_hotel_pod_exit_begin()
{
}

//Function Number: 11
dialogue_hotel_top_floor_nk_soldier_spotted()
{
	thread dialog_hotel_top_floor_nk_alerted();
	level waittill("nk_soldier_spotted");
}

//Function Number: 12
dialog_hotel_top_floor_nk_alerted()
{
	var_00 = 2;
	while(var_00 > 0)
	{
		var_01 = getaiarray("bad_guys");
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03) && var_03 cansee(level.player))
			{
				if(var_00 == 2)
				{
					var_03 soundscripts\_snd_playsound::snd_play_linked("dds_nk0_thrt_acquired");
					wait(1);
					var_00--;
					continue;
				}

				if(var_00 == 1)
				{
					var_03 soundscripts\_snd_playsound::snd_play_linked("dds_nk0_react_suppress");
					return;
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 13
vo_nk_first_contact()
{
	common_scripts\utility::flag_wait("vo_nk_first_contact_start");
	maps\_utility::dialogue_queue("seo_knr_checkthatdoorwayoverhere");
	wait(1.5);
	level.cormack maps\_utility::dialogue_queue("seo_crk_contactcontact");
	level waittill("first_fight_done");
	level waittill("first_fight_guy_dead");
	wait(1.5);
	level.cormack maps\_utility::dialogue_queue("seo_crk_clear3");
}

//Function Number: 14
dialogue_hotel_top_floor_landassist()
{
	common_scripts\utility::flag_wait("dialogue_hotel_top_floor_landassist");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_gotasheerdrop");
	level.cormack maps\_utility::dialogue_queue("seo_crk_wellhavetojump");
	level.cormack maps\_utility::dialogue_queue("seo_crk_remembershortbursts");
	thread nag_player_land_assist();
	wait(5);
	common_scripts\utility::flag_set("dialogue_hotel_top_floor_landassist_end");
	common_scripts\utility::flag_wait("dialogue_player_landassist_jump");
	wait(3);
	level.cormack maps\_utility::dialogue_queue("seo_crk_everyoneup");
	level.cormack maps\_utility::dialogue_queue("seo_crk_commandpostshould");
}

//Function Number: 15
nag_player_land_assist()
{
	level.cormack waittill("i_have_landed");
	wait(5);
	if(!common_scripts\utility::flag("dialogue_player_landassist_jump"))
	{
		maps\_utility::dialogue_queue("seo_crk_jumpitmitchell");
	}
}

//Function Number: 16
dialogue_hotel_mid_floor_glass_gag()
{
	common_scripts\utility::flag_wait("dialogue_hotel_mid_floor_glass_gag");
	wait(3);
	level.jackson maps\_utility::dialogue_queue("seo_jkn_whatthehell");
	level.cormack maps\_utility::dialogue_queue("seo_crk_havocmissiles");
	level.jackson maps\_utility::dialogue_queue("seo_jkn_damn");
}

//Function Number: 17
dialogue_hotel_mid_floor_contact()
{
	common_scripts\utility::flag_wait("dialogue_hotel_mid_floor_contact");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_contactcontact");
	level.cormack maps\_utility::dialogue_queue("seo_crk_lightemup");
}

//Function Number: 18
dialogue_hotel_mid_floor_fight_over()
{
	common_scripts\utility::flag_wait("dialogue_hotel_mid_floor_fight_over");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("seo_crk_clear");
	level.cormack maps\_utility::dialogue_queue("seo_crk_everyonesticktogether");
	level.jackson maps\_utility::dialogue_queue("seo_jkn_anotherdropover");
	level.cormack maps\_utility::dialogue_queue("seo_crk_okheaddown");
	level notify("dialogue_hotel_mid_floor_fight_over_end");
}

//Function Number: 19
dialogue_hotel_missile_dodge()
{
	common_scripts\utility::flag_wait("dialogue_hotel_missile_dodge_pt1");
	level.cormack maps\_utility::dialogue_queue("seo_crk_throughhere");
	common_scripts\utility::flag_wait("dialogue_hotel_missile_dodge_pt2");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_missilesincoming");
	level.cormack maps\_utility::dialogue_queue("seo_crk_gogogo");
	common_scripts\utility::flag_wait("dialogue_hotel_missile_dodge_pt3");
	level.cormack maps\_utility::dialogue_queue("seo_crk_jump");
}

//Function Number: 20
dialogue_hotel_exit()
{
}

//Function Number: 21
dialogue_trench_demo_team()
{
	if(1)
	{
		level waittill("begin_walker_stepover_anim");
		wait(8.4);
		level.will_irons maps\_utility::dialogue_queue("seo_wil_watchyerhead");
	}
	else
	{
		common_scripts\utility::flag_wait("dialogue_trench_demo_team");
		level.cormack maps\_utility::dialogue_queue("seo_crk_demoteamone");
		level.cormack maps\_utility::dialogue_queue("seo_crk_damnnotgetting");
		level.will_irons maps\_utility::dialogue_queue("seo_wil_watchyerhead");
		level maps\_utility::dialogue_queue("seo_spm_granitezeroone");
		level.cormack maps\_utility::dialogue_queue("seo_crk_copythateveryonekeep");
	}

	thread dialogue_exit_trench();
}

//Function Number: 22
dialogue_exit_trench()
{
	for(;;)
	{
		var_00 = getaiarray("bad_guys");
		foreach(var_02 in var_00)
		{
			if(var_02 cansee(level.player))
			{
				level.will_irons maps\_utility::dialogue_queue("seo_wil_contact");
				maps\_utility::battlechatter_on("allies");
				maps\_utility::battlechatter_on("axis");
				return;
			}
		}

		wait(0.5);
	}
}

//Function Number: 23
dialogue_drone_swarm_intro()
{
	common_scripts\utility::flag_wait("dialogue_drone_swarm_intro");
	wait(3);
	level.jackson maps\_utility::dialogue_queue("seo_jkn_hereitcomes");
	level.cormack maps\_utility::dialogue_queue("seo_crk_swarmeveryonegetdown");
	level.jackson maps\_utility::dialogue_queue("seo_jkn_dronesdrones");
	level.jackson maps\_utility::dialogue_queue("seo_jkn_holyshit");
	soundscripts\_snd::snd_message("seo_start_drone_submix");
	wait(3);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_grabcovergrabcover");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_protectyourselves");
	if(0)
	{
		return;
	}

	level.cormack maps\_utility::dialogue_queue("seo_crk_someonegetonthat");
	level notify("turret_objective_given");
	wait(10);
	while(!common_scripts\utility::flag("dialogue_drone_turret_sequence"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_mitchellgettothe");
		wait(6);
		if(!common_scripts\utility::flag("dialogue_drone_turret_sequence"))
		{
			if(common_scripts\utility::cointoss())
			{
				level.cormack maps\_utility::dialogue_queue("seo_crk_usethatturret");
				continue;
			}

			level.cormack maps\_utility::dialogue_queue("seo_crk_usethatturret");
			wait(randomfloatrange(3,5));
		}
	}
}

//Function Number: 24
dialogue_drone_turret_sequence()
{
	common_scripts\utility::flag_wait("dialogue_drone_turret_sequence");
	thread walker_tank_dialgue();
	level.cormack maps\_utility::dialogue_queue("seo_crk_keepthosedronesoffus");
	wait(10);
	level.cormack maps\_utility::dialogue_queue("seo_crk_hitthosedrones");
	common_scripts\utility::flag_wait("dialogue_drone_turret_sequence_emp_1");
	maps\_utility::dialogue_queue("seo_crk_empsat50");
	common_scripts\utility::flag_wait("dialogue_drone_turret_sequence_emp_2");
	maps\_utility::dialogue_queue("seo_crk_empscharged");
	var_00 = ["seo_crk_empscharged","seo_crk_activatetheemp","seo_crk_fireoffthatemp"];
	while(!common_scripts\utility::flag("dialogue_drone_turret_sequence_emp_3"))
	{
		wait(randomfloatrange(2,4));
		if(common_scripts\utility::cointoss() && !common_scripts\utility::flag("dialogue_drone_turret_sequence_emp_3"))
		{
			maps\_utility::dialogue_queue(common_scripts\utility::random(var_00));
		}
	}
}

//Function Number: 25
walker_tank_dialgue()
{
	level endon("end_cherry_picker");
	while(!isdefined(level.walker_tank))
	{
		wait 0.05;
	}

	var_00 = level.walker_tank;
	var_00 endon("death");
	var_00 thread walker_tank_death_vo();
	var_00 thread walker_tank_success_vo();
	wait(4);
	var_00 waittill("damage");
	maps\_utility::dialogue_queue("seo_tnt_theyrealloverus");
	wait(2);
	var_00 waittill("tank_shot");
	maps\_utility::dialogue_queue("seo_tnt_icantgetalock");
	wait(2);
	var_00 waittill("damage");
	maps\_utility::dialogue_queue("seo_tnt_takingheavydamage");
}

//Function Number: 26
walker_tank_success_vo()
{
	self endon("death");
	level waittill("end_cherry_picker");
	wait(2);
	if(isdefined(self))
	{
		level maps\_utility::dialogue_queue("seo_tnt_thanksforthehelpbadger");
		level notify("que_cormack_congratulate");
	}
	else
	{
		level notify("que_cormack_congratulate");
	}

	level maps\_utility::dialogue_queue("seo_crk_goodworksolider");
}

//Function Number: 27
walker_tank_death_vo()
{
	self waittill("death");
	level maps\_utility::dialogue_queue("seo_tnt_tankingtoomuchdamstatic");
}

//Function Number: 28
vo_jump_training()
{
	level endon("jump_training_end");
	common_scripts\utility::flag_wait("vo_jump_training_start");
	wait(2);
	level.cormack maps\_utility::dialogue_queue("seo_crk_mitchelloverhere");
	var_00 = ["seo_crk_useyourboosterstoget","seo_crk_jumpoverthetruckmitchell","seo_crk_useyourboosters2"];
	while(!common_scripts\utility::flag("jump_training_ended"))
	{
		var_01 = common_scripts\utility::array_randomize(var_00);
		foreach(var_03 in var_01)
		{
			level.cormack maps\_utility::dialogue_queue(var_03);
			wait(randomfloatrange(5,8));
		}
	}
}

//Function Number: 29
dialogue_truck_push_sequence()
{
	common_scripts\utility::flag_wait("dialogue_truck_push_sequence");
	wait(5);
	level.cormack maps\_utility::dialogue_queue("seo_crk_getthistruckofftheroad");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_copymitchellgivemea");
	while(!common_scripts\utility::flag("dialogue_truck_push_sequence_start"))
	{
		if(!common_scripts\utility::flag("dialogue_truck_push_sequence_start"))
		{
			wait(randomfloatrange(2,4));
		}

		if(!common_scripts\utility::flag("dialogue_truck_push_sequence_start"))
		{
			level.will_irons maps\_utility::dialogue_queue("seo_wil_helpmeoutman");
		}
		else
		{
			break;
		}

		if(!common_scripts\utility::flag("dialogue_truck_push_sequence_start"))
		{
			wait(randomfloatrange(2,4));
		}

		if(!common_scripts\utility::flag("dialogue_truck_push_sequence_start"))
		{
			level.cormack maps\_utility::dialogue_queue("seo_crk_mitchellyoureonirons");
			continue;
		}

		break;
	}

	common_scripts\utility::flag_wait("dialogue_truck_push_sequence_end");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_feelstrongashellinthis");
	common_scripts\utility::flag_set("dialogue_performing_arts_entrance");
}

//Function Number: 30
vo_push_through_hotel()
{
	var_00 = getent("trigger_hotel_push_vo","targetname");
	var_00 waittill("trigger");
	level.cormack maps\_utility::dialogue_queue("seo_crk_weneedtopushthrough");
}

//Function Number: 31
dialogue_performing_arts_entrance()
{
	common_scripts\utility::flag_wait("vo_will_wep_nineoclock");
	level.jackson maps\_utility::dialogue_queue("seo_jcn_havoclauncherdeadahead");
	if(!common_scripts\utility::flag("video_log_playing"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_thatsourtarget");
	}

	if(!common_scripts\utility::flag("video_log_playing"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_theytookoutthe");
	}

	if(!common_scripts\utility::flag("video_log_playing"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_thehavoclauncher");
	}

	if(!common_scripts\utility::flag("video_log_playing"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_weregonnahvetogetaround");
	}

	common_scripts\utility::flag_set("vo_havoc_launcher_done");
	common_scripts\utility::flag_wait("dialogue_performing_arts_entrance_2");
	level.cormack maps\_utility::dialogue_queue("seo_crk_demoteamonethisisgranite");
	maps\_utility::dialogue_queue("seo_dmo_hearyougranitezeroone");
	level.cormack maps\_utility::dialogue_queue("seo_crk_copywearereciving");
	maps\_utility::dialogue_queue("seo_dmo_copythatwearestong");
	level.cormack maps\_utility::dialogue_queue("seo_crk_okayletshustlegranite");
}

//Function Number: 32
vo_zipliners_hotel()
{
	level waittill("zipline_triggered",var_00,var_01);
	wait(1);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_ziplinerscomingin");
}

//Function Number: 33
dialogue_building_jump()
{
	common_scripts\utility::flag_wait("dialogue_building_jump");
	soundscripts\_snd::snd_music_message("exit_int_mall");
	level.cormack maps\_utility::dialogue_queue("seo_crk_needtocrossover");
	while(!isdefined(level.will_irons.building_jump_initiate))
	{
		wait 0.05;
	}

	wait(6);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_onlyliveonce");
	wait(3);
	if(!common_scripts\utility::flag("first_building_jump_complete"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_youreupmitchell");
	}
}

//Function Number: 34
vo_fob_meetup()
{
	common_scripts\utility::flag_wait("dialogue_start_fob_meetup");
	wait(1);
	if(!isdefined(level.guide))
	{
		return;
	}

	soundscripts\_snd::snd_message("fob_meetup_vo","notify_vo_fob_meetup_done");
	wait(1.2);
	level.guide maps\_utility::dialogue_queue("seo_dnl_whothehellareyou");
	level.cormack maps\_utility::dialogue_queue("seo_crk_granitesquad");
	level.guide maps\_utility::dialogue_queue("seo_dnl_theyrealreadyonthe");
	level.cormack maps\_utility::dialogue_queue("seo_crk_whatstheirposition");
	level.guide maps\_utility::dialogue_queue("seo_dnl_twoklicksnorth");
	level.cormack maps\_utility::dialogue_queue("seo_crk_alrightweremoving");
	if(0)
	{
		level.guide maps\_utility::dialogue_queue("seo_dnl_aresaresweneedsome");
		level.marine_3 maps\_utility::dialogue_queue("seo_mrn3_notgettingthrough");
	}

	level notify("notify_vo_fob_meetup_done");
	if(1)
	{
		wait(1);
		level maps\_utility::dialogue_queue("seo_spm_granitezeroone");
		level.cormack maps\_utility::dialogue_queue("seo_crk_copythateveryonekeep");
	}
}

//Function Number: 35
vo_post_building_jump()
{
	common_scripts\utility::flag_wait("first_building_jump_complete");
	while(!isdefined(level.cormack.jump_complete))
	{
		wait 0.05;
	}

	while(!isdefined(level.will_irons.jump_complete))
	{
		wait 0.05;
	}

	level.will_irons maps\_utility::dialogue_queue("seo_wil_thisisnothinglikebasic");
	level.jackson maps\_utility::dialogue_queue("seo_jcn_thiswholecityisfucked");
	level.cormack maps\_utility::dialogue_queue("seo_crk_securethatshitkeepmoving");
}

//Function Number: 36
vo_sinkhole()
{
	common_scripts\utility::flag_wait("vo_sinkhole_view");
	common_scripts\utility::flag_wait("vo_sinkhole_first_drones");
	wait(2);
	level.jackson maps\_utility::dialogue_queue("seo_jkn_dronesdrones");
}

//Function Number: 37
vo_subway_car()
{
	common_scripts\utility::flag_wait("vo_subway_car_start");
	level.cormack maps\_utility::dialogue_queue("seo_crk_throughthesubwaycar");
}

//Function Number: 38
vo_subway_threat_grenade_moment()
{
	common_scripts\utility::flag_wait("vo_subway_threat_moment");
	level.cormack maps\_utility::dialogue_queue("seo_crk_theyrepoppingsmoke");
	common_scripts\utility::flag_wait("vo_subway_threat_moment_clear");
	wait(1.5);
	level.cormack maps\_utility::dialogue_queue("seo_crk_clear2");
}

//Function Number: 39
vo_subway_pa_announcements()
{
	var_00 = getentarray("org_subway_pa_speaker","targetname");
	for(;;)
	{
		level waittill("player_entered_subway");
		thread play_announcment_over_pa(var_00);
		level waittill("player_leaving_subway");
	}
}

//Function Number: 40
play_announcment_over_pa(param_00)
{
	level endon("player_leaving_subway");
	level endon("atlas_scene_start");
	var_01 = ["seo_pa_allcitizensproceedtoevacuation","seo_pa_returntoyourhomes","seo_pa_alllawenforcementpersonnelreport","seo_pa_reportanysuspiciousactivityto"];
	for(;;)
	{
		foreach(var_03 in var_01)
		{
			var_04 = undefined;
			foreach(var_06 in param_00)
			{
				var_04 = soundscripts\_snd_playsound::snd_play_at(var_03,var_06.origin);
			}

			var_04 waittill("sounddone");
			wait(3);
		}
	}
}

//Function Number: 41
vo_subway()
{
	thread vo_subway_pa_announcements();
	common_scripts\utility::flag_wait("vo_subway_see_civilians");
	wait(8);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_shit2");
	level.cormack maps\_utility::dialogue_queue("seo_crk_stayfocused");
	common_scripts\utility::flag_wait("vo_near_gate");
	level.cormack maps\_utility::dialogue_queue("seo_crk_mitchellgetthatgate");
}

//Function Number: 42
vo_subway_civ_convo1()
{
	common_scripts\utility::flag_wait("vo_civ_convo1");
	level.civ2 maps\_utility::dialogue_queue("seo_cv1_itsmylegithinkitsbroken");
}

//Function Number: 43
vo_subway_civ_convo2()
{
	common_scripts\utility::flag_wait("vo_civ_convo2");
	level.civ4 maps\_utility::dialogue_queue("seo_cv1_idontthinkicanwalk");
}

//Function Number: 44
vo_subway_civ_convo3()
{
	common_scripts\utility::flag_wait("vo_civ_convo3");
	level.civ7 maps\_utility::dialogue_queue("seo_cv1_ohgodweregoingtodie");
}

//Function Number: 45
vo_subway_civ_convo4()
{
	common_scripts\utility::flag_wait("vo_civ_convo4");
	level.civ8 maps\_utility::dialogue_queue("seo_cv1_ineedtocallmyhusband");
}

//Function Number: 46
vo_meet_atlas_dialogue()
{
	common_scripts\utility::flag_wait("vo_begin_seo_meet_atlas");
	thread vo_cutoff_subway_vo_early_check();
	level waittill("dialogue_atlas_meetup_done");
	wait(3);
	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.jackson maps\_utility::dialogue_queue("seo_jkn_atlaswillisntthatyourdads");
	}

	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_yep");
	}

	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.jackson maps\_utility::dialogue_queue("seo_jkn_theygotthebestgear");
	}

	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_wantedtoservemycountry");
	}

	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_cutthechattermovementahead");
	}

	common_scripts\utility::flag_clear("vo_begin_seo_meet_atlas");
	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		level.cormack maps\_utility::dialogue_queue("seo_crk_patroldropem");
	}
}

//Function Number: 47
vo_cutoff_subway_vo_early_check()
{
	common_scripts\utility::flag_wait("sd_combat_start");
	level.will_irons soundscripts\_snd_playsound::snd_stop_sound();
	level.jackson soundscripts\_snd_playsound::snd_stop_sound();
}

//Function Number: 48
vo_shopping_district()
{
	common_scripts\utility::flag_wait("vo_sd_first_reinforcements");
	wait(4);
	level.jackson maps\_utility::dialogue_queue("seo_crk_jkn_morecomingin");
	common_scripts\utility::flag_wait("vo_inside_restaurant");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_mitchellivegotyou");
}

//Function Number: 49
vo_sd_drone_swarm_dialogue()
{
	common_scripts\utility::flag_wait("vo_sd_demo_team_call");
	soundscripts\_snd::snd_message("vo_sd_demo_team_call");
	maps\_utility::dialogue_queue("seo_dmo_granitewherethehell");
	level.cormack maps\_utility::dialogue_queue("seo_crk_demoteamonecomein");
	level.cormack maps\_utility::dialogue_queue("seo_crk_shitwegottamoveit");
	common_scripts\utility::flag_wait("vo_sd_swarm_attacks");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("seo_crk_droneswarminside");
	level.cormack maps\_utility::dialogue_queue("seo_crk_getoffthestreet");
}

//Function Number: 50
vo_canal()
{
	thread canals_part_2();
	common_scripts\utility::flag_wait("vo_canal_call_to_window");
	wait(2);
	level.cormack maps\_utility::dialogue_queue("seo_crk_weneedtogeteyes");
	common_scripts\utility::flag_wait("vo_canal_strategy_scene");
	level.cormack maps\_utility::dialogue_queue("seo_crk_theresthehavoclauncher");
	common_scripts\utility::flag_set("vo_havoc_launcher_line_done");
	maps\_utility::dialogue_queue("seo_wil_overthereshittheyrekia");
	level.cormack maps\_utility::dialogue_queue("seo_crk_okayokayicanseetheir");
	common_scripts\utility::flag_set("vo_demo_team_lines_done");
	maps\_utility::dialogue_queue("seo_jkn_sirwearentademo");
	level.cormack maps\_utility::dialogue_queue("seo_crk_nowerenotbutwewaitfor");
	maps\_utility::dialogue_queue("seo_wil_illgetthechargessir");
	level.cormack maps\_utility::dialogue_queue("seo_crk_yoursurewill");
	maps\_utility::dialogue_queue("seo_wil_yeahicanmakeit");
	level.cormack maps\_utility::dialogue_queue("seo_crk_okaymitchellyourewithirons");
	common_scripts\utility::flag_clear("vo_canal_strategy_scene");
	common_scripts\utility::flag_set("demo_team_seen");
	maps\_utility::dialogue_queue("seo_wil_letsdoit");
	level notify("kill_seo_sd_demo_team_call_mix");
	soundscripts\_snd::snd_music_message("mus_canal_action_begin");
}

//Function Number: 51
canals_part_2()
{
	common_scripts\utility::flag_wait("vo_canal_grab_explosives");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_timedchargesgrabem");
	level waittill("will_begin_vo_fornothing");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_okletsmakesurethese");
	level notify("timed_charges_vo_done");
	level waittill("will_push_forward_01");
	if(!common_scripts\utility::flag("prep_will_for_finale"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_keephittingthemmitchell");
	}

	level waittill("will_push_forward_02");
	common_scripts\utility::flag_set("vo_canal_spaceman");
	if(!common_scripts\utility::flag("prep_will_for_finale"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_wecandothis");
	}

	level waittill("will_push_forward_03");
	if(!common_scripts\utility::flag("prep_will_for_finale"))
	{
		level.will_irons maps\_utility::dialogue_queue("seo_wil_pushtothelauncher");
	}
}

//Function Number: 52
vo_canal_plant_explosives()
{
	common_scripts\utility::flag_wait("vo_bomb_planting_instructions");
	soundscripts\_snd::snd_message("timed_charges_vo");
	maps\_utility::dialogue_queue("seo_crk_willthatlauncherisheavily");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_copythatsir");
	common_scripts\utility::flag_clear("vo_bomb_planting_instructions");
	level thread maps\_utility::notify_delay("will_begin_vo_fornothing",2);
	common_scripts\utility::flag_wait("vo_canal_spaceman");
	wait(3);
	if(!common_scripts\utility::flag("canal_bomb_plant_trigger_on"))
	{
		maps\_utility::dialogue_queue("seo_spn_cormackthatlauncheristearing");
	}

	if(!common_scripts\utility::flag("canal_bomb_plant_trigger_on"))
	{
		maps\_utility::dialogue_queue("seo_crk_demoteamiskia");
	}

	common_scripts\utility::flag_wait("vo_bomb_plant_reminder");
	wait(1);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_mitchelloverhere");
}

//Function Number: 53
vo_canal_razorback()
{
	common_scripts\utility::flag_wait("vo_canal_razorback_arrival");
	wait(8);
	maps\_utility::dialogue_queue("seo_rzr_thisisdefender23coming");
	wait(5);
	maps\_utility::dialogue_queue("seo_rzr_switchingtargets");
	wait(8);
	maps\_utility::dialogue_queue("seo_rzr_weretakinghitsmovingposition");
	wait(2);
	common_scripts\utility::flag_set("vo_canal_spaceman");
	common_scripts\utility::flag_wait("vo_canal_razorback_attacked");
}

//Function Number: 54
vo_canal_finale()
{
	common_scripts\utility::flag_wait("vo_canal_finale_scene");
}

//Function Number: 55
vo_canal_e3()
{
	common_scripts\utility::flag_wait("vo_canal_e3_only");
	soundscripts\_snd::snd_music_message("mus_canal_action_begin",3);
	maps\_utility::dialogue_queue("seo_crk_willthatlauncherisheavily");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_copythatsir");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_letsdoit");
	common_scripts\utility::flag_wait("vo_canal_e3_pt2");
	level.will_irons maps\_utility::dialogue_queue("seo_wil_mitchellivegotyou");
	common_scripts\utility::flag_wait("vo_bomb_plant_reminder");
	wait(1);
	level.will_irons maps\_utility::dialogue_queue("seo_wil_mitchelloverhere");
}

//Function Number: 56
radio_walkby_guy_vo()
{
	common_scripts\utility::flag_wait("play_radio_walkby_guy_vo");
	if(isdefined(level.resdhirt1))
	{
		thread fob_ambient_battle_chatter();
		level.resdhirt1 maps\_utility::dialogue_queue("seo_mrn1_thisisbadgertwo");
		level.resdhirt1 soundscripts\_snd_playsound::snd_play_linked("seo_spm_badgertwothisis");
	}
}

//Function Number: 57
injured_guy_vo()
{
	common_scripts\utility::flag_wait("soldier_injured_dialogue");
	level.healer maps\_utility::dialogue_queue("seo_mrn2_wehaveaman");
	level.healer soundscripts\_snd_playsound::snd_play_linked("seo_bcr_solidcopybravothree");
}

//Function Number: 58
fob_ambient_battle_chatter()
{
	var_00 = [(33392,8385,1378),(33338,6501,1378),(33946,6769,1375),(34525,6901,1377),(33837,8109,1379),(33385,7891,1379)];
	var_01 = [];
	var_02 = 13;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_03 + 1;
		var_05 = "seo_amb_bc_" + var_04;
		if(var_04 < 10)
		{
			var_05 = "seo_amb_bc_0" + var_04;
		}

		var_01[var_03] = var_05;
	}

	var_06 = 0;
	var_07 = 1;
	while(var_06 < var_02)
	{
		var_05 = var_01[var_06];
		var_08 = var_00[randomint(var_00.size)];
		var_06 = var_06 + 1;
		var_09 = var_07;
		if(common_scripts\utility::flag("dialogue_start_fob_meetup"))
		{
			var_09 = var_07 * 0.75;
		}

		soundscripts\_snd_playsound::snd_play_at(var_05,var_08,undefined,0,0,var_09);
		wait(randomfloatrange(1,3));
	}
}

//Function Number: 59
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_drop_phase1a_cormack,"aud_start_pod_drop_phase1a_cormack",::seo_droppod1_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_drop_phase1a_will,"aud_start_pod_drop_phase1a_will",::seo_droppod1_will);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_phase2b_will,"will_aud",::seo_droppod2_alt_will);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_phase3_cormack,"cormack_aud",::seo_droppod2_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_phase4a_intro_cormack,"aud_seo_pod_phase4a_intro_start",::seo_droppod3_intro_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_pod_crash_wake_up_cormack,"aud_seo_pod_exit_start",::seo_droppod3_exit);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_meet_atlas_cormack,"aud_seo_meet_atlas_start_cormack",::seo_atlas_meet_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_meet_atlas_gideon,"aud_seo_meet_atlas_start_gideon",::seo_atlas_meet_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_meet_atlas_will,"aud_seo_meet_atlas_start_will",::seo_atlas_meet_will);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_finale_runup_will,"aud_start_seoul_door_open",::seo_will_death_hatch_open_wait_cycle);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_finale_plantbomb_will,"aud_start_seoul_finale",::seo_will_death_plant_charge_part1);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_finale_part2_will,"aud_start_finale_part2_will_death",::seo_will_death_plant_charge_part2);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%seo_finale_phase2_silo_collapse_cormack,"aud_start_fusion_scene5_burke_rescue",::seo_finale_cormack_rescue);
}

//Function Number: 60
seo_droppod1_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_everyoneholdtight",16.12);
}

//Function Number: 61
seo_droppod1_will(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_justlikeintraining",21.15,"seo_wil_justlikeintraining_done");
}

//Function Number: 62
seo_droppod2_alt_will(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_heyseeyouontheother",1.03,"seo_wil_heyseeyouontheother_sound_done");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_spacemanimseeingheavy",7.15,"seo_crk_spacemanimseeingheavy_sound_done");
	level maps\_utility::delaythread(12,::maps\_utility::dialogue_queue,"seo_spm_copythatgranite");
}

//Function Number: 63
seo_droppod2_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_exertion3",2.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_rds_ahhh",2.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_holdon",4.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_mitchellclosetheblast",6.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_comeonmitchellnow",10.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_mitchellnow",13.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_resettingdroppoint",22.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_jkn_shit",28);
}

//Function Number: 64
seo_droppod3_intro_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_braceyourselves",0.15);
}

//Function Number: 65
seo_droppod3_exit(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_youstillinonepiece",1.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_mitchellgetthedoor",9.21);
	soundscripts\_snd::snd_music_message("mus_podcrash_done");
}

//Function Number: 66
seo_atlas_meet_will(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_checkfireblueblue",0.03);
}

//Function Number: 67
seo_atlas_meet_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_gdn_atlaspmcrescueforece",2.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_gdn_itsafuckinmessbetterodds",8.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_gdn_goodluckletsmove",12.12);
}

//Function Number: 68
seo_atlas_meet_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_idyourselves",1.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_howstheweathersouthside",7.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_copythat",11.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_onme",13.18,"dialogue_atlas_meetup_done");
	wait(13);
	soundscripts\_snd::snd_music_message("dialogue_atlas_meetup_done");
}

//Function Number: 69
seo_will_death_hatch_open_wait_cycle(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_grunt1",0.15);
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
}

//Function Number: 70
seo_will_death_plant_charge_part1(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_givemethecharge",1.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_okaytimersetletsget",5.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_damnthinkmyarmsbroke",9.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_okaypull",13.21);
}

//Function Number: 71
seo_will_death_plant_charge_part2(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_ehrahhhh",0);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_shitdontworryaboutthat",1.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_nnnnngh",7.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_wereliftingoffyougottago",8.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_mitchellwereoutoftime",11.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_wil_itsokayseeyouontheother",17.09);
	soundscripts\_snd::snd_music_message("mus_will_death_plant_charge_part2");
}

//Function Number: 72
seo_finale_cormack_rescue(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_exersions3",0);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_mitchellmitchell",3.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_spacemangranitetwois",6.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_holdon1",10.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_staywithme",16);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_youregonnabealright",17.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("seo_crk_weregonnagetyouhome",25.15);
}