/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 91
 * Decompile Time: 1392 ms
 * Timestamp: 4/22/2024 2:25:51 AM
*******************************************************************/

//Function Number: 1
prepare_dialog()
{
	level.scr_sound["gideon"]["bet_gdn_howdoesitfeelto"] = "bet_gdn_howdoesitfeelto";
	level.scr_radio["bet_iln1_gideonmitchell"] = "bet_iln1_gideonmitchell";
	level.scr_sound["gideon"]["bet_gdn_ilonawhatitis"] = "bet_gdn_ilonawhatitis";
	level.scr_radio["bet_iln1_meetmeinmaintenanceroom"] = "bet_iln1_meetmeinmaintenanceroom";
	level.scr_sound["gideon"]["bet_gdn_alrightweremoving"] = "bet_gdn_alrightweremoving";
	level.scr_sound["gideon"]["bet_gdn_letsseewhatthehell"] = "bet_gdn_letsseewhatthehell";
	level.scr_sound["atlas_emp_1"]["bet_at1_congratulationssir"] = "bet_at1_congratulationssir";
	level.scr_sound["gideon"]["bet_gdn_hardtobelievethisis"] = "bet_gdn_hardtobelievethisis";
	level.scr_sound["gideon"]["bet_gdn_echoteamtookdownanother"] = "bet_gdn_echoteamtookdownanother";
	level.scr_sound["gideon"]["bet_gdn_theworldsrunningoutof"] = "bet_gdn_theworldsrunningoutof";
	level.scr_sound["atlas_emp_2"]["bet_atd_afternoonsir"] = "bet_atd_afternoonsir";
	level.scr_sound["gideon"]["bet_gdn_thisisit"] = "bet_gdn_thisisit";
	level.scr_sound["ilana"]["bet_iln1_didyoutellanyoneyou"] = "bet_iln1_didyoutellanyoneyou";
	level.scr_sound["gideon"]["bet_gdn_no"] = "bet_gdn_no";
	level.scr_sound["ilana"]["bet_iln1_thescramblerwillonlybuy"] = "bet_iln1_thescramblerwillonlybuy";
	level.scr_sound["gideon"]["bet_gdn_whatthebloodyhellsgoing"] = "bet_gdn_whatthebloodyhellsgoing";
	level.scr_sound["ilana"]["bet_iln1_justwatchthis"] = "bet_iln1_justwatchthis";
	level.scr_sound["ilana"]["bet_iln1_rememberlagos"] = "bet_iln1_rememberlagos";
	level.scr_sound["gideon"]["bet_gdn_theguywepulledout"] = "bet_gdn_theguywepulledout";
	level.scr_sound["ilana"]["bet_iln1_henevermadeitback"] = "bet_iln1_henevermadeitback";
	level.scr_sound["technologist"]["bet_tct_thekvaareplanningan"] = "bet_tct_thekvaareplanningan";
	level.scr_sound["irons"]["bet_irs_whatkindofattack"] = "bet_irs_whatkindofattack";
	level.scr_sound["technologist"]["bet_tct_nuclearpowerplantsallover"] = "bet_tct_nuclearpowerplantsallover";
	level.scr_sound["irons"]["bet_irs_whereexactlyaretheyhitting"] = "bet_irs_whereexactlyaretheyhitting";
	level.scr_sound["technologist"]["bet_tct_seattleparistokyothousandswilldie"] = "bet_tct_seattleparistokyothousandswilldie";
	level.scr_sound["irons"]["bet_irs_okitsalright"] = "bet_irs_okitsalright";
	level.scr_sound["gideon"]["bet_gdn_fuckme"] = "bet_gdn_fuckme";
	level.scr_sound["ilana"]["bet_iln1_heknewit"] = "bet_iln1_heknewit";
	level.scr_sound["gideon"]["bet_gdn_wheredidyougetthis"] = "bet_gdn_wheredidyougetthis";
	level.scr_sound["ilana"]["bet_iln1_hades"] = "bet_iln1_hades";
	level.scr_sound["gideon"]["bet_gdn_couldbefake"] = "bet_gdn_couldbefake";
	level.scr_sound["ilana"]["bet_iln1_itwascodedandencrypted"] = "bet_iln1_itwascodedandencrypted";
	level.scr_sound["gideon"]["bet_gdn_vocalizationforflashbangsequence"] = "bet_gdn_vocalizationforflashbangsequence";
	level.scr_sound["ilana"]["bet_iln1_vocalizationforflashbangsequence"] = "bet_iln1_vocalizationforflashbangsequence";
	level.scr_sound["atlas_guard_1"]["bet_at11_nobodymove"] = "bet_at11_nobodymove";
	level.scr_sound["ilana"]["bet_iln1_wesawit"] = "bet_iln1_wesawit";
	level.scr_sound["irons"]["bet_irs_whatdidyousee"] = "bet_irs_whatdidyousee";
	level.scr_sound["ilana"]["bet_iln1_youknewabouttheattacks"] = "bet_iln1_youknewabouttheattacks";
	level.scr_sound["irons"]["bet_irs_yousawaforgedrecording"] = "bet_irs_yousawaforgedrecording";
	level.scr_sound["ilana"]["bet_iln1_youreinsaneyoureamonster"] = "bet_iln1_youreinsaneyoureamonster";
	level.scr_sound["irons"]["bet_irs_youvedisappointedme"] = "bet_irs_youvedisappointedme";
	level.scr_sound["gideon"]["bet_gdn_yessir"] = "bet_gdn_yessir";
	level.scr_sound["ilana"]["bet_iln1_gideon2"] = "bet_iln1_gideon2";
	level.scr_sound["gideon"]["bet_gdn_hesaiditsafake"] = "bet_gdn_hesaiditsafake";
	level.scr_sound["irons"]["bet_irs_hesmadehisdecision"] = "bet_irs_hesmadehisdecision";
	level.scr_sound["guard1"]["bet_at11_juststaywhereyouare"] = "bet_at11_juststaywhereyouare";
	level.scr_radio["bet_x_listen"] = "bet_x_listen";
	level.scr_radio["bet_x_gonow"] = "bet_x_gonow";
	level.scr_sound["guard1"]["bet_at11_aarrrgh"] = "bet_at11_aarrrgh";
	level.scr_sound["ilana"]["bet_iln1_comeon"] = "bet_iln1_comeon";
	level.scr_radio["bet_x_headtowardstheserverroom"] = "bet_x_headtowardstheserverroom";
	level.scr_sound["ilana"]["bet_iln1_whoareyou"] = "bet_iln1_whoareyou";
	level.scr_radio["bet_x_afriendjustkeepmoving"] = "bet_x_afriendjustkeepmoving";
	level.scr_sound["scripted"]["bet_at11_prophetthefiredoorsinthe"] = "bet_at11_prophetthefiredoorsinthe";
	level.scr_radio["bet_prt_copythat"] = "bet_prt_copythat";
	level.scr_radio["bet_pa_firesuppressionsystemactivated"] = "bet_pa_firesuppressionsystemactivated";
	level.scr_radio["bet_pa_allsecuritypersonellreportto"] = "bet_pa_allsecuritypersonellreportto";
	level.scr_sound["ilana"]["bet_iln1_deadend"] = "bet_iln1_deadend";
	level.scr_radio["bet_x_holdon"] = "bet_x_holdon";
	level.scr_radio["bet_x_startclimbingandgetto"] = "bet_x_startclimbingandgetto";
	level.scr_sound["ilana"]["bet_iln1_wellhavetouseour"] = "bet_iln1_wellhavetouseour";
	level.scr_sound["ilana"]["bet_iln1_climbupmitchell"] = "bet_iln1_climbupmitchell";
	level.scr_sound["ilana"]["bet_iln1_gomitchell"] = "bet_iln1_gomitchell";
	level.scr_sound["PA"]["bet_pa_attention"] = "bet_pa_attention";
	level.scr_radio["bet_x_theyregoingtoactivatea"] = "bet_x_theyregoingtoactivatea";
	level.scr_sound["ilana"]["bet_iln1_wellbetrappedupthere"] = "bet_iln1_wellbetrappedupthere";
	level.scr_radio["bet_x_trustme"] = "bet_x_trustme";
	level.scr_sound["ilana"]["bet_iln1_swarmrun"] = "bet_iln1_swarmrun";
	level.scr_sound["ilana"]["bet_iln1_wevegottogetaway"] = "bet_iln1_wevegottogetaway";
	level.scr_sound["ilana"]["bet_iln1_overhere"] = "bet_iln1_overhere";
	level.scr_sound["PA"]["bet_pa_securitylockdownineffect"] = "bet_pa_securitylockdownineffect";
	level.scr_radio["bet_x_imoverridingthegates"] = "bet_x_imoverridingthegates";
	level.scr_sound["ilana"]["bet_iln1_werefivestoriesup"] = "bet_iln1_werefivestoriesup";
	level.scr_radio["bet_x_doitnow"] = "bet_x_doitnow";
	level.scr_sound["ilana"]["bet_iln1_jump"] = "bet_iln1_jump";
	level.scr_sound["ilana"]["bet_iln1_jumpmitchell"] = "bet_iln1_jumpmitchell";
	level.scr_sound["roof_guard_1"]["bet_atr1_aahhh"] = "bet_atr1_aahhh";
	level.scr_radio["bet_x_seweraccessisdirectlyahead"] = "bet_x_seweraccessisdirectlyahead";
	level.scr_sound["ilana"]["bet_iln1_coughing"] = "bet_iln1_coughing";
	level.scr_sound["ilana"]["bet_iln1_sowhatnow"] = "bet_iln1_sowhatnow";
	level.scr_radio["bet_x_youllneedtogetthrough"] = "bet_x_youllneedtogetthrough";
	level.scr_sound["ilana"]["bet_iln1_theyregoingtolockdown"] = "bet_iln1_theyregoingtolockdown";
	level.scr_radio["bet_x_thatswhyyouneedto"] = "bet_x_thatswhyyouneedto";
	level.scr_sound["PA_2"]["bet_pa2_attentionthisisasecurity"] = "bet_pa2_attentionthisisasecurity";
	level.scr_sound["civilian_1"]["bet_cvl_guardshelpus"] = "bet_cvl_guardshelpus";
	level.scr_sound["atlas_guard_1"]["bet_at11_dontmove"] = "bet_at11_dontmove";
	level.scr_sound["civilian_2"]["bet_cvl1_thereweremenwithguns"] = "bet_cvl1_thereweremenwithguns";
	level.scr_sound["atlas_guard_1"]["bet_at11_onyourkneesnow"] = "bet_at11_onyourkneesnow";
	level.scr_radio["bet_x_theyreroundingupcivilians"] = "bet_x_theyreroundingupcivilians";
	level.scr_sound["ilana"]["bet_iln1_throughhere"] = "bet_iln1_throughhere";
	level.scr_radio["bet_x_dropdowntothestreet"] = "bet_x_dropdowntothestreet";
	level.scr_sound["atlas_guard_2"]["bet_at2_theretheyare"] = "bet_at2_theretheyare";
	level.scr_sound["atlas_guard_3"]["bet_at3_openfire"] = "bet_at3_openfire";
	level.scr_sound["atlas_guard_2"]["bet_at2_atlasonewevegottherunners"] = "bet_at2_atlasonewevegottherunners";
	level.scr_sound["ilana"]["bet_iln1_takecover"] = "bet_iln1_takecover";
	level.scr_radio["bet_x_keepmovingbothofyou"] = "bet_x_keepmovingbothofyou";
	level.scr_radio["bet_x_keepgoingyourerunningout"] = "bet_x_keepgoingyourerunningout";
	level.scr_radio["bet_x_gettothedocks"] = "bet_x_gettothedocks";
	level.scr_sound["ilana"]["bet_iln1_lookforflankingroutes"] = "bet_iln1_lookforflankingroutes";
	level.scr_sound["ilana"]["bet_iln1_gogogo"] = "bet_iln1_gogogo";
	level.scr_sound["ilana"]["bet_iln1_wevegottokeeppushing"] = "bet_iln1_wevegottokeeppushing";
	level.scr_sound["ilana"]["bet_iln1_runmitchell"] = "bet_iln1_runmitchell";
	level.scr_sound["ilana"]["bet_iln1_fastermitchell"] = "bet_iln1_fastermitchell";
	level.scr_sound["PA"]["bet_pa_attentioncitizensreturnto"] = "bet_pa_attentioncitizensreturnto";
	level.scr_sound["PA"]["bet_pa_donotattempttoleave"] = "bet_pa_donotattempttoleave";
	level.scr_sound["PA"]["bet_pa_fugitivesarelooseinoldtown"] = "bet_pa_fugitivesarelooseinoldtown";
	level.scr_sound["ilana"]["bet_iln1_thedocksareupahead"] = "bet_iln1_thedocksareupahead";
	level.scr_radio["bet_x_ileftyouatool"] = "bet_x_ileftyouatool";
	level.scr_sound["ilana"]["bet_iln1_astincoming"] = "bet_iln1_astincoming";
	level.scr_sound["ilana"]["bet_iln1_useyourempagainstit"] = "bet_iln1_useyourempagainstit";
	level.scr_sound["ilana"]["bet_iln1_astisdown"] = "bet_iln1_astisdown";
	level.scr_radio["bet_x_theboatsonthesecond"] = "bet_x_theboatsonthesecond";
	level.scr_sound["ilana"]["bet_iln1_mitchellgetintheboat"] = "bet_iln1_mitchellgetintheboat";
	level.scr_sound["ilana"]["bet_iln1_intheboatnow"] = "bet_iln1_intheboatnow";
	level.scr_sound["ilana"]["bet_iln1_comeonmitchell"] = "bet_iln1_comeonmitchell";
	level.scr_radio["bet_x_putonthatgrappleattachement"] = "bet_x_putonthatgrappleattachement";
	level.scr_radio["bet_x_headdownthecanaltowards"] = "bet_x_headdownthecanaltowards";
	level.scr_sound["ilana"]["bet_iln1_wevegotdronesinpursuit"] = "bet_iln1_wevegotdronesinpursuit";
	level.scr_sound["ilana"]["bet_iln1_diveunderthoseboats"] = "bet_iln1_diveunderthoseboats";
	level.scr_sound["ilana"]["bet_iln1_gofaster"] = "bet_iln1_gofaster";
	level.scr_radio["bet_x_gogo"] = "bet_x_gogo";
	level.scr_sound["ilana"]["bet_iln1_hittheramp"] = "bet_iln1_hittheramp";
	level.scr_sound["ilana"]["bet_iln1_missilelockdive"] = "bet_iln1_missilelockdive";
	level.scr_sound["ilana"]["bet_iln1_incomingdive"] = "bet_iln1_incomingdive";
	level.scr_sound["ilana"]["bet_iln1_keepgoing"] = "bet_iln1_keepgoing";
	level.scr_sound["ilana"]["bet_iln1_lookout"] = "bet_iln1_lookout";
	level.scr_sound["ilana"]["bet_iln1_watchout"] = "bet_iln1_watchout";
	level.scr_sound["ilana"]["bet_iln1_dive2"] = "bet_iln1_dive2";
	level.scr_sound["ilana"]["bet_iln1_lookout2"] = "bet_iln1_lookout2";
	level.scr_sound["ilana"]["bet_iln1_moremissiles"] = "bet_iln1_moremissiles";
	level.scr_radio["bet_x_youregettingclose"] = "bet_x_youregettingclose";
	level.scr_sound["ilana"]["bet_iln1_closetowhat"] = "bet_iln1_closetowhat";
	level.scr_radio["bet_x_youllsee"] = "bet_x_youllsee";
	level.scr_radio["bet_x_mitchellilonacanyouhear"] = "bet_x_mitchellilonacanyouhear";
	level.scr_sound["ilana"]["bet_iln1_areyoualright"] = "bet_iln1_areyoualright";
	level.scr_radio["bet_x_canyoumove"] = "bet_x_canyoumove";
	level.scr_sound["ilana"]["bet_iln1_copy"] = "bet_iln1_copy";
	level.scr_radio["bet_x_extractionpointisrightabove"] = "bet_x_extractionpointisrightabove";
	level.scr_sound["ilana"]["bet_iln1_howarewesupposedto"] = "bet_iln1_howarewesupposedto";
	level.scr_radio["bet_x_useyourgrapple"] = "bet_x_useyourgrapple";
	level.scr_sound["ilana"]["bet_iln1_mitchellwecangrappleup"] = "bet_iln1_mitchellwecangrappleup";
	level.scr_sound["ilana"]["bet_iln1_anothergrapplepointaboveus"] = "bet_iln1_anothergrapplepointaboveus";
	level.scr_sound["ilana"]["bet_iln1_keepmovingup"] = "bet_iln1_keepmovingup";
	level.scr_sound["ilana"]["bet_iln1_contactgettocover"] = "bet_iln1_contactgettocover";
	level.scr_sound["ilana"]["bet_iln1_watchthosecontainers"] = "bet_iln1_watchthosecontainers";
	level.scr_sound["ilana"]["bet_iln1_careful"] = "bet_iln1_careful";
	level.scr_radio["bet_x_yourealmosttherejustgrapple"] = "bet_x_yourealmosttherejustgrapple";
	level.scr_sound["ilana"]["bet_iln1_keepheadingup"] = "bet_iln1_keepheadingup";
	level.scr_radio["bet_x_grappletothatledge"] = "bet_x_grappletothatledge";
	level.scr_sound["ilana"]["bet_iln1_wellhavetouseour2"] = "bet_iln1_wellhavetouseour2";
	level.scr_radio["bet_x_getuptotheskybridge"] = "bet_x_getuptotheskybridge";
	level.scr_radio["bet_x_dropdownandcrossthe"] = "bet_x_dropdownandcrossthe";
	level.scr_radio["bet_x_getacrosstheskybridge"] = "bet_x_getacrosstheskybridge";
	level.scr_radio["bet_x_gettothatcraneand"] = "bet_x_gettothatcraneand";
	level.scr_radio["bet_x_useyourmaggripson"] = "bet_x_useyourmaggripson";
	level.scr_radio["bet_x_getonthecrane"] = "bet_x_getonthecrane";
	level.scr_sound["ilana"]["bet_iln1_careful2"] = "bet_iln1_careful2";
	level.scr_sound["ilana"]["bet_iln1_thisway"] = "bet_iln1_thisway";
	level.scr_sound["ilana"]["bet_iln1_grappleupmitchell"] = "bet_iln1_grappleupmitchell";
	level.scr_radio["bet_x_startgrappling"] = "bet_x_startgrappling";
	level.scr_sound["ilana"]["bet_iln1_keepgoing2"] = "bet_iln1_keepgoing2";
	level.scr_sound["ilana"]["bet_iln1_uhhnnn"] = "bet_iln1_uhhnnn";
	level.scr_sound["cormack"]["bet_crk_yourememberyouroldsergeant"] = "bet_crk_yourememberyouroldsergeant";
	level.scr_sound["sentinel_1"]["bet_snv_warbirdincoming"] = "bet_snv_warbirdincoming";
	level.scr_sound["joker"]["bet_jkr_whatstheplayboss"] = "bet_jkr_whatstheplayboss";
	level.scr_sound["gideon"]["bet_gdn_standdown"] = "bet_gdn_standdown";
	level.scr_sound["gideon"]["bet_gdn_ifyourewrongaboutirons"] = "bet_gdn_ifyourewrongaboutirons";
	level.scr_sound["ilana"]["bet_iln1_imnotwrong"] = "bet_iln1_imnotwrong";
	level.scr_sound["gideon"]["bet_gdn_wellsee"] = "bet_gdn_wellsee";
	level.scr_sound["atlas_command"]["bet_atr_atlasonewhatsyourstatus"] = "bet_atr_atlasonewhatsyourstatus";
	level.scr_sound["gideon"]["bet_gdn_roofisclear"] = "bet_gdn_roofisclear";
	level.scr_sound["cormack"]["bet_crk_insidenow"] = "bet_crk_insidenow";
	level.scr_radio["bet_x_yourecompromised"] = "bet_x_yourecompromised";
	level.scr_radio["bet_x_theyveseenyou"] = "bet_x_theyveseenyou";
	level.scr_radio["bet_x_theyvefoundyou"] = "bet_x_theyvefoundyou";
	level.scr_radio["bet_x_youvebeendiscoveredatlasforces"] = "bet_x_youvebeendiscoveredatlasforces";
	level.scr_sound["ilana"]["bet_iln1_theyveseenus"] = "bet_iln1_theyveseenus";
	level.scr_sound["guard"]["bet_at11_suspectsspotted"] = "bet_at11_suspectsspotted";
	level.scr_sound["guard"]["bet_at11_theretheyaremovein"] = "bet_at11_theretheyaremovein";
	level.scr_sound["guard"]["bet_at11_overtheretakethemout"] = "bet_at11_overtheretakethemout";
	level.scr_sound["guard"]["bet_at11_thereiseethem"] = "bet_at11_thereiseethem";
	level.scr_sound["guard"]["bet_at11_ivespottedthemthere"] = "bet_at11_ivespottedthemthere";
}

//Function Number: 2
stop_vo_on_entity(param_00,param_01)
{
	self endon(param_01);
	level waittill(param_00);
	if(isdefined(self.function_stack))
	{
		maps\_utility::function_stack_clear();
	}

	self stopsounds();
}

//Function Number: 3
stop_vo_on_radio(param_00,param_01)
{
	level endon(param_01);
	level waittill(param_00);
	maps\_utility::radio_dialogue_stop();
}

//Function Number: 4
play_dialog()
{
	thread init_pcap_vo();
	level thread play_dialogue_office();
	level thread play_dialogue_confrontation();
	level thread play_dialogue_escape();
	level thread play_dialogue_roof();
	level thread play_dialogue_swim();
	level thread play_dialogue_sewer();
	level thread play_dialogue_oldtown();
	level thread play_dialogue_docks();
	level thread play_dialogue_boat();
	level thread play_dialogue_climb();
}

//Function Number: 5
play_dialogue_office()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_office");
	level thread play_dialogue_office_block_congrats();
	level thread play_dialogue_office_block_baghdad();
	level thread play_dialogue_office_block_kva();
	level thread play_dialogue_office_block_guard();
	level thread play_dialogue_office_block_door();
}

//Function Number: 6
play_dialogue_office_block_congrats()
{
	common_scripts\utility::flag_wait("flag_dialogue_office_congrats");
	level.office_civ maps\_utility::dialogue_queue("bet_at1_congratulationssir");
}

//Function Number: 7
play_dialogue_office_block_baghdad()
{
	common_scripts\utility::flag_wait("flag_dialogue_office_baghdad");
	var_00 = getent("intro_gideon_city_lookat","targetname");
	level.gideon setlookatentity(var_00);
	common_scripts\utility::delay_script_call(5,::gideon_look_off);
	level.gideon maps\_utility::dialogue_queue("bet_gdn_hardtobelievethisis");
}

//Function Number: 8
gideon_look_off()
{
	level.gideon setlookatentity();
}

//Function Number: 9
play_dialogue_office_block_kva()
{
	common_scripts\utility::flag_wait("flag_dialogue_office_kva");
	level.gideon maps\_utility::dialogue_queue("bet_gdn_echoteamtookdownanother");
	level.gideon maps\_utility::dialogue_queue("bet_gdn_theworldsrunningoutof");
}

//Function Number: 10
play_dialogue_office_block_guard()
{
	common_scripts\utility::flag_wait("flag_dialogue_office_guard");
	level.office_guard maps\_utility::dialogue_queue("bet_atd_afternoonsir");
}

//Function Number: 11
play_dialogue_office_block_door()
{
	common_scripts\utility::flag_wait("flag_dialogue_office_door");
	wait(5);
	level.gideon maps\_utility::dialogue_queue("bet_gdn_thisisit");
}

//Function Number: 12
play_dialogue_confrontation()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_confrontation");
	level thread play_dialog_confrontation_block_mrx();
	level thread play_dialog_confrontation_block_go();
	level thread play_dialog_confrontation_block_leave();
}

//Function Number: 13
play_dialog_confrontation_block_mrx()
{
	common_scripts\utility::flag_wait("flag_dialog_confrontation_mrX");
	level thread maps\_shg_utility::play_videolog("betrayal_videolog_02","screen_add");
	level.escape_take_down_guard maps\_utility::dialogue_queue("bet_at11_juststaywhereyouare");
	level maps\_utility::dialogue_queue("bet_x_listen");
}

//Function Number: 14
play_dialog_confrontation_block_go()
{
	common_scripts\utility::flag_wait("flag_dialog_confrontation_go");
	level.escape_take_down_guard maps\_utility::dialogue_queue("bet_at11_aarrrgh");
	level maps\_utility::dialogue_queue("bet_x_gonow");
}

//Function Number: 15
play_dialog_confrontation_block_leave()
{
	common_scripts\utility::flag_wait("flag_dialog_confrontation_leave");
}

//Function Number: 16
play_dialogue_escape()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_escape");
	level thread play_dialogue_escape_block_intros();
	level thread play_dialogue_escape_block_guarddoor();
	level thread play_dialogue_escape_block_announce();
	level thread play_dialogue_escape_block_deadend();
	level thread play_dialogue_escape_block_climb();
	level thread play_dialogue_escape_block_swarm();
}

//Function Number: 17
play_dialogue_escape_block_intros()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_intros");
	level maps\_utility::dialogue_queue("bet_x_headtowardstheserverroom");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_whoareyou");
	level maps\_utility::dialogue_queue("bet_x_afriendjustkeepmoving");
}

//Function Number: 18
play_dialogue_escape_block_guarddoor()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_guarddoor");
	level.escape_scene_side_door_guards[0] maps\_utility::dialogue_queue("bet_at11_prophetthefiredoorsinthe");
}

//Function Number: 19
play_dialogue_escape_block_announce()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_announce");
	level thread maps\_utility::dialogue_queue("bet_pa_firesuppressionsystemactivated");
	wait(3);
	level thread maps\_utility::dialogue_queue("bet_pa_allsecuritypersonellreportto");
}

//Function Number: 20
play_dialogue_escape_block_deadend()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_deadend");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_deadend");
	level maps\_utility::dialogue_queue("bet_x_holdon");
	common_scripts\utility::flag_set("flag_escape_open_elevator");
}

//Function Number: 21
play_dialogue_escape_block_climb()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_climb");
	level maps\_utility::dialogue_queue("bet_x_startclimbingandgetto");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_wellhavetouseour");
	while(!maps\_exo_climb::is_exo_climbing())
	{
		wait(randomfloatrange(8,10));
		if(maps\_exo_climb::is_exo_climbing())
		{
			break;
		}

		if(common_scripts\utility::cointoss())
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_climbupmitchell");
			continue;
		}

		level.ilana maps\_utility::dialogue_queue("bet_iln1_gomitchell");
	}
}

//Function Number: 22
play_dialogue_escape_block_swarm()
{
	common_scripts\utility::flag_wait("flag_dialogue_escape_swarm");
	level.escape_pa thread maps\_utility::dialogue_queue("bet_pa_attention");
	wait(3);
	level maps\_utility::dialogue_queue("bet_x_theyregoingtoactivatea");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_wellbetrappedupthere");
	level maps\_utility::dialogue_queue("bet_x_trustme");
}

//Function Number: 23
play_dialogue_roof()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_roof");
	level thread play_dialogue_roof_block_alert();
	level thread play_dialogue_roof_block_away();
	level thread play_dialogue_roof_block_run();
	level thread play_dialogue_roof_block_gates();
	level thread play_dialogue_roof_block_jump();
	level thread play_dialogue_roof_block_fall();
}

//Function Number: 24
play_dialogue_roof_block_alert()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_swarm");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_swarmrun");
	soundscripts\_snd::snd_music_message("swarm_run");
}

//Function Number: 25
play_dialogue_roof_block_away()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_away");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_wevegottogetaway");
}

//Function Number: 26
play_dialogue_roof_block_run()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_run");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_overhere");
}

//Function Number: 27
play_dialogue_roof_block_gates()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_gates");
	level.escape_pa maps\_utility::dialogue_queue("bet_pa_securitylockdownineffect");
	level maps\_utility::dialogue_queue("bet_x_imoverridingthegates");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_werefivestoriesup");
	level maps\_utility::dialogue_queue("bet_x_doitnow");
}

//Function Number: 28
play_dialogue_roof_block_jump()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_jump");
	while(!common_scripts\utility::flag("flag_roof_player_jumped_off_atlas_building"))
	{
		if(common_scripts\utility::cointoss())
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_jump");
			continue;
		}

		level.ilana maps\_utility::dialogue_queue("bet_iln1_jumpmitchell");
		wait(randomfloatrange(5,7));
	}
}

//Function Number: 29
play_dialogue_roof_block_fall()
{
	common_scripts\utility::flag_wait("flag_dialogue_roof_fall");
	level.falling_guard maps\_utility::dialogue_queue("bet_atr1_aahhh");
}

//Function Number: 30
play_dialogue_swim()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_swim");
	level thread play_dialogue_swim_block_sewer();
	level thread play_dialogue_swim_block_cough();
}

//Function Number: 31
play_dialogue_swim_block_sewer()
{
	common_scripts\utility::flag_wait("flag_dialogue_swim_sewer");
	level maps\_utility::dialogue_queue("bet_x_seweraccessisdirectlyahead");
}

//Function Number: 32
play_dialogue_swim_block_cough()
{
	common_scripts\utility::flag_wait("flag_dialogue_swim_cough");
	wait(0.6);
	level.ilana maps\_utility::dialogue_queue("bet_iln1_coughing");
}

//Function Number: 33
play_dialogue_sewer()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_sewer");
	level thread play_dialogue_sewer_block_guards();
	level thread play_dialogue_sewer_block_announcement();
	level thread play_dialogue_sewer_block_checkpoint();
}

//Function Number: 34
play_dialogue_sewer_block_guards()
{
	common_scripts\utility::flag_wait("flag_dialogue_sewer_guards");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_sowhatnow");
	level maps\_utility::dialogue_queue("bet_x_youllneedtogetthrough");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_theyregoingtolockdown");
	level maps\_utility::dialogue_queue("bet_x_thatswhyyouneedto");
}

//Function Number: 35
play_dialogue_sewer_block_announcement()
{
	common_scripts\utility::flag_wait("flag_dialogue_sewer_announcement");
	level.oldtown_pa maps\_utility::dialogue_queue("bet_pa2_attentionthisisasecurity");
}

//Function Number: 36
play_dialogue_sewer_block_checkpoint()
{
	common_scripts\utility::flag_wait("flag_dialogue_sewer_checkpoint");
	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level.civilian1 thread stop_vo_on_entity("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level.civilian1 maps\_utility::dialogue_queue("bet_cvl_guardshelpus");
		level.civilian1 notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level.atlas_guard thread stop_vo_on_entity("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level.atlas_guard maps\_utility::dialogue_queue("bet_at11_dontmove");
		level.atlas_guard notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level.civilian2 thread stop_vo_on_entity("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level.civilian2 maps\_utility::dialogue_queue("bet_cvl1_thereweremenwithguns");
		level.civilian2 notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level.atlas_guard thread stop_vo_on_entity("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level.atlas_guard maps\_utility::dialogue_queue("bet_at11_onyourkneesnow");
		level.atlas_guard notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level thread stop_vo_on_radio("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level maps\_utility::dialogue_queue("bet_x_theyreroundingupcivilians");
		level notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level.ilana thread stop_vo_on_entity("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level.ilana maps\_utility::dialogue_queue("bet_iln1_throughhere");
		level.ilana notify("vo_done");
	}

	if(!common_scripts\utility::flag("flag_sewer_checkpoint_guards_wakeup"))
	{
		level thread stop_vo_on_radio("flag_sewer_checkpoint_guards_wakeup","vo_done");
		level maps\_utility::dialogue_queue("bet_x_dropdowntothestreet");
		level notify("vo_done");
	}
}

//Function Number: 37
play_dialogue_oldtown()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_oldtown");
	level thread play_dialogue_oldtown_block_contact();
	level thread play_dialogue_oldtown_block_naglines();
}

//Function Number: 38
play_dialogue_oldtown_block_contact()
{
	common_scripts\utility::flag_wait("flag_dialogue_oldtown_contact");
	level.atlas_guard2 maps\_utility::dialogue_queue("bet_at2_theretheyare");
	level.atlas_guard3 maps\_utility::dialogue_queue("bet_at3_openfire");
	level.atlas_guard2 maps\_utility::dialogue_queue("bet_at2_atlasonewevegottherunners");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_takecover");
	common_scripts\utility::delay_script_call(randomfloatrange(6,10),::common_scripts\utility::flag_set,"flag_dialogue_oldtown_naglines");
	var_00 = getent("freerun_pa","targetname");
	var_00.animname = "PA";
	while(!common_scripts\utility::flag("oldtown_dock_flyby"))
	{
		wait(randomfloatrange(2,4));
		var_00 maps\_utility::dialogue_queue("bet_pa_attentioncitizensreturnto");
		wait(15);
		var_00 maps\_utility::dialogue_queue("bet_pa_donotattempttoleave");
		wait(15);
		var_00 maps\_utility::dialogue_queue("bet_pa_fugitivesarelooseinoldtown");
		wait(45);
	}
}

//Function Number: 39
play_dialogue_oldtown_block_naglines()
{
	common_scripts\utility::flag_wait("flag_dialogue_oldtown_naglines");
	while(!common_scripts\utility::flag("oldtown_dock_flyby"))
	{
		var_00 = distance(level.player.origin,level.ilana.origin);
		if(var_00 < 500)
		{
			var_01 = randomint(100);
			if(var_01 < 20)
			{
				level.ilana maps\_utility::dialogue_queue("bet_iln1_lookforflankingroutes");
			}
			else if(var_01 < 40)
			{
				level.ilana maps\_utility::dialogue_queue("bet_iln1_gogogo");
			}
			else if(var_01 < 60)
			{
				level.ilana maps\_utility::dialogue_queue("bet_iln1_wevegottokeeppushing");
			}
			else if(var_01 < 80)
			{
				level.ilana maps\_utility::dialogue_queue("bet_iln1_runmitchell");
			}
			else
			{
				level.ilana maps\_utility::dialogue_queue("bet_iln1_fastermitchell");
			}

			continue;
		}

		var_01 = randomint(100);
		if(var_01 < 33)
		{
			level maps\_utility::dialogue_queue("bet_x_keepmovingbothofyou");
			continue;
		}

		if(var_01 < 66)
		{
			level maps\_utility::dialogue_queue("bet_x_keepgoingyourerunningout");
			continue;
		}

		level maps\_utility::dialogue_queue("bet_x_gettothedocks");
		wait(randomfloatrange(25,35));
	}
}

//Function Number: 40
play_dialogue_oldtown_player_spotted(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = "bet_at11_suspectsspotted";
	var_03[1] = "bet_at11_theretheyaremovein";
	var_03[2] = "bet_at11_overtheretakethemout";
	var_03[3] = "bet_at11_thereiseethem";
	var_03[4] = "bet_at11_ivespottedthemthere";
	var_04 = param_00.animname;
	param_00.animname = "guard";
	var_05 = randomint(var_03.size);
	param_00 maps\_utility::dialogue_queue(var_03[var_05]);
	var_03 = maps\_utility::array_remove_index(var_03,var_05);
	param_00.animname = var_04;
	if(isdefined(param_01) && isalive(param_01))
	{
		var_04 = param_01.animname;
		param_01.animname = "guard";
		var_05 = randomint(var_03.size);
		param_01 maps\_utility::dialogue_queue(var_03[var_05]);
		param_01.animname = var_04;
	}

	if(isdefined(param_02) && param_02)
	{
		return;
	}

	var_05 = randomint(100);
	if(var_05 < 20)
	{
		level.ilana maps\_utility::dialogue_queue("bet_iln1_theyveseenus");
		return;
	}

	if(var_05 < 40)
	{
		level maps\_utility::dialogue_queue("bet_x_yourecompromised");
		return;
	}

	if(var_05 < 60)
	{
		level maps\_utility::dialogue_queue("bet_x_theyveseenyou");
		return;
	}

	if(var_05 < 80)
	{
		level maps\_utility::dialogue_queue("bet_x_theyvefoundyou");
		return;
	}

	level maps\_utility::dialogue_queue("bet_x_youvebeendiscoveredatlasforces");
}

//Function Number: 41
play_dialogue_docks()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_docks");
	level thread play_dialogue_docks_block_intro();
	level thread play_dilaogue_docks_block_ast();
	level thread play_dialogue_docks_block_boat();
	level thread play_dialogue_docks_block_boatnag();
	level thread play_dialogue_docks_backtrack();
}

//Function Number: 42
play_dialogue_docks_block_intro()
{
	common_scripts\utility::flag_wait("flag_dialogue_docks_intro");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_thedocksareupahead");
	level maps\_utility::dialogue_queue("bet_x_ileftyouatool");
}

//Function Number: 43
play_dilaogue_docks_block_ast()
{
	common_scripts\utility::flag_wait("flag_dialogue_docks_ast");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_astincoming");
	wait(25);
	if(isalive(level.dock_mech))
	{
		level.ilana maps\_utility::dialogue_queue("bet_iln1_useyourempagainstit");
	}
}

//Function Number: 44
play_dialogue_docks_block_boat()
{
	common_scripts\utility::flag_wait("flag_dialogue_docks_boat");
	wait(2);
	level.ilana maps\_utility::dialogue_queue("bet_iln1_astisdown");
	if(!common_scripts\utility::flag("player_on_boat"))
	{
		level thread stop_vo_on_radio("player_on_boat","vo_done");
		level maps\_utility::dialogue_queue("bet_x_theboatsonthesecond");
		level notify("vo_done");
	}

	if(!common_scripts\utility::flag("player_on_boat"))
	{
		level.ilana thread stop_vo_on_entity("player_on_boat","vo_done");
		level.ilana maps\_utility::dialogue_queue("bet_iln1_mitchellgetintheboat");
		level.ilana notify("vo_done");
	}

	wait(randomfloatrange(9,15));
	common_scripts\utility::flag_set("flag_dialogue_docks_boatnag");
}

//Function Number: 45
play_dialogue_docks_block_boatnag()
{
	common_scripts\utility::flag_wait("flag_dialogue_docks_boatnag");
	while(!common_scripts\utility::flag("player_on_boat"))
	{
		if(common_scripts\utility::cointoss())
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_intheboatnow");
			continue;
		}

		level.ilana maps\_utility::dialogue_queue("bet_iln1_comeonmitchell");
		wait(randomfloatrange(9,15));
	}
}

//Function Number: 46
play_dialogue_docks_backtrack()
{
	common_scripts\utility::flag_wait("flag_dialogue_docks_backtrack");
	level.atlas_guard2 maps\_utility::dialogue_queue("bet_at2_theretheyare");
	level.atlas_guard maps\_utility::dialogue_queue("bet_at11_dontmove");
	level.atlas_guard maps\_utility::dialogue_queue("bet_at11_onyourkneesnow");
	level.atlas_guard3 maps\_utility::dialogue_queue("bet_at3_openfire");
}

//Function Number: 47
play_dialogue_boat()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_boat");
	level thread play_dialogue_boat_block_grapple();
	level thread play_dialogue_boat_block_intro();
	level thread play_dialogue_boat_block_dive();
	level thread play_dialogue_boat_block_ramp();
	level thread play_dialogue_boat_block_close();
	level thread play_dialogue_boat_block_missiles();
}

//Function Number: 48
play_dialogue_boat_block_grapple()
{
	common_scripts\utility::flag_wait("flag_dialogue_boat_grapple");
	level maps\_utility::dialogue_queue("bet_x_putonthatgrappleattachement");
}

//Function Number: 49
play_dialogue_boat_block_intro()
{
	common_scripts\utility::flag_wait("flag_dialogue_boat_intro");
	level maps\_utility::dialogue_queue("bet_x_headdownthecanaltowards");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_wevegotdronesinpursuit");
}

//Function Number: 50
play_dialogue_boat_block_dive()
{
	common_scripts\utility::flag_wait("flag_dialogue_boat_dive");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_diveunderthoseboats");
	wait(6);
	level.ilana maps\_utility::dialogue_queue("bet_iln1_gofaster");
}

//Function Number: 51
play_dialogue_boat_block_ramp()
{
	common_scripts\utility::flag_wait("flag_dialogue_boat_ramp");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_hittheramp");
	wait(2);
	level maps\_utility::dialogue_queue("bet_x_gogo");
}

//Function Number: 52
play_dialogue_boat_block_close()
{
	common_scripts\utility::flag_wait("flag_dialogue_boat_close");
	level maps\_utility::dialogue_queue("bet_x_youregettingclose");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_closetowhat");
	level maps\_utility::dialogue_queue("bet_x_youllsee");
}

//Function Number: 53
play_dialogue_boat_block_missiles()
{
	level endon("boat_scene_cleanup");
	var_00 = [];
	var_00[0] = "bet_iln1_missilelockdive";
	var_00[1] = "bet_iln1_incomingdive";
	var_00[2] = "bet_iln1_keepgoing";
	var_00[3] = "bet_iln1_lookout";
	var_00[4] = "bet_iln1_watchout";
	var_00[5] = "bet_iln1_dive2";
	var_00[6] = "bet_iln1_lookout2";
	var_00[7] = "bet_iln1_moremissiles";
	var_01 = 1;
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_dialogue_boat_missiles");
		var_02 = undefined;
		if(var_01)
		{
			var_02 = 0;
			var_01 = 0;
		}
		else
		{
			var_02 = randomint(var_00.size);
		}

		level.ilana maps\_utility::dialogue_queue(var_00[var_02]);
		common_scripts\utility::flag_clear("flag_dialogue_boat_missiles");
	}
}

//Function Number: 54
play_dialogue_climb()
{
	common_scripts\utility::flag_wait("flag_dialogue_start_climb");
	level thread play_dialogue_climb_block_boatexit();
	level thread play_dialogue_climb_block_grapple1();
	level thread play_dialogue_climb_block_grapple2();
	level thread play_dialogue_climb_block_grapple3();
	level thread play_dialogue_climb_block_contact();
	level thread play_dialogue_climb_block_containers();
	level thread play_dialogue_climb_block_careful();
	level thread play_dialogue_climb_block_tower();
	level thread play_dialogue_climb_block_ledge();
	level thread play_dialogue_climb_block_climb();
	level thread play_dialogue_climb_block_way();
	level thread play_dialogue_climb_block_bridge();
	level thread play_dialogue_climb_block_drop();
	level thread play_dialogue_climb_block_cross();
	level thread play_dialogue_climb_block_crane();
	level thread play_dialogue_crane_block_start();
	level thread play_dialogue_crane_block_go();
	level thread play_dialogue_crane_block_jump();
	level thread play_dialogue_crane_block_slide();
}

//Function Number: 55
play_dialogue_climb_block_boatexit()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_boatexit");
	wait(3);
	level maps\_utility::dialogue_queue("bet_x_mitchellilonacanyouhear");
}

//Function Number: 56
play_video_log_climb_block_intro()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_intro");
	maps\_shg_utility::play_videolog("betrayal_videolog","screen_add");
}

//Function Number: 57
play_dialogue_climb_block_grapple1()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_grapple1");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_mitchellwecangrappleup");
	level thread play_dialogue_climb_grapple_nag("flag_dialogue_climb_grapple2");
}

//Function Number: 58
play_dialogue_climb_block_grapple2()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_grapple2");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_anothergrapplepointaboveus");
}

//Function Number: 59
play_dialogue_climb_block_grapple3()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_grapple3");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_keepmovingup");
}

//Function Number: 60
play_dialogue_climb_block_contact()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_contact");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_contactgettocover");
}

//Function Number: 61
play_dialogue_climb_block_containers()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_containers");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_watchthosecontainers");
}

//Function Number: 62
play_dialogue_climb_block_careful()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_careful");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_careful");
}

//Function Number: 63
play_dialogue_climb_grapple_nag(param_00)
{
	level endon(param_00);
	var_01 = -1;
	for(;;)
	{
		wait(8);
		for(;;)
		{
			var_02 = randomint(3);
			if(var_02 != var_01)
			{
				var_01 = var_02;
				break;
			}
		}

		if(var_02 == 0)
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_grappleupmitchell");
			continue;
		}

		if(var_02 == 1)
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_thisway");
			continue;
		}

		level maps\_utility::dialogue_queue("bet_x_startgrappling");
	}
}

//Function Number: 64
play_dialogue_climb_block_tower()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_tower");
	if(common_scripts\utility::flag("flag_dialogue_climb_ledge"))
	{
		return;
	}

	level maps\_utility::dialogue_queue("bet_x_yourealmosttherejustgrapple");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_keepheadingup");
	level thread play_dialogue_climb_grapple_nag("flag_dialogue_climb_ledge");
}

//Function Number: 65
play_dialogue_climb_block_ledge()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_ledge");
	level maps\_utility::dialogue_queue("bet_x_grappletothatledge");
}

//Function Number: 66
play_dialogue_climb_block_climb()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_climb");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_wellhavetouseour2");
	while(!maps\_exo_climb::is_exo_climbing())
	{
		wait(randomfloatrange(8,10));
		if(maps\_exo_climb::is_exo_climbing())
		{
			break;
		}

		if(common_scripts\utility::cointoss())
		{
			level.ilana maps\_utility::dialogue_queue("bet_iln1_climbupmitchell");
			continue;
		}

		level.ilana maps\_utility::dialogue_queue("bet_iln1_gomitchell");
	}
}

//Function Number: 67
play_dialogue_climb_block_way()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_way");
	wait(1);
	level.ilana maps\_utility::dialogue_queue("bet_iln1_thisway");
}

//Function Number: 68
play_dialogue_climb_block_bridge()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_bridge");
	level maps\_utility::dialogue_queue("bet_x_getuptotheskybridge");
}

//Function Number: 69
play_dialogue_climb_block_drop()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_drop");
	level maps\_utility::dialogue_queue("bet_x_dropdownandcrossthe");
}

//Function Number: 70
play_dialogue_climb_block_cross()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_cross");
	level maps\_utility::dialogue_queue("bet_x_getacrosstheskybridge");
}

//Function Number: 71
play_dialogue_climb_block_crane()
{
	common_scripts\utility::flag_wait("flag_dialogue_climb_crane");
	level thread play_dialogue_climb_crane_nag();
	level maps\_utility::dialogue_queue("bet_x_gettothatcraneand");
}

//Function Number: 72
play_dialogue_climb_crane_nag()
{
	level endon("flag_dialogue_climb_crane_nag_stop");
	wait(5);
	var_00 = -1;
	for(;;)
	{
		wait(8);
		for(;;)
		{
			var_01 = randomint(2);
			if(var_01 != var_00)
			{
				var_00 = var_01;
				break;
			}
		}

		if(var_01 == 0)
		{
			level maps\_utility::dialogue_queue("bet_x_useyourmaggripson");
			continue;
		}

		level maps\_utility::dialogue_queue("bet_x_getonthecrane");
	}
}

//Function Number: 73
play_dialogue_crane_block_start()
{
	common_scripts\utility::flag_wait("flag_dialogue_crane_start");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_careful2");
}

//Function Number: 74
play_dialogue_crane_block_go()
{
	common_scripts\utility::flag_wait("flag_dialogue_crane_go");
	level maps\_utility::dialogue_queue("bet_x_gogo");
	wait(3);
	level.ilana maps\_utility::dialogue_queue("bet_iln1_keepgoing2");
}

//Function Number: 75
play_dialogue_crane_block_jump()
{
	common_scripts\utility::flag_wait("flag_dialogue_crane_jump");
	level.ilana maps\_utility::dialogue_queue("bet_iln1_jumpmitchell");
}

//Function Number: 76
play_dialogue_crane_block_slide()
{
	common_scripts\utility::flag_wait("flag_dialogue_crane_slide");
}

//Function Number: 77
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_intro_gideon,"aud_start_bet_intro",::bet_intro_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt1_gideon,"aud_start_confrontation_pt1_gideon",::bet_betrayal_pt1_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt1_ilona,"aud_start_confrontation_pt1_ilona",::bet_betrayal_pt1_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt1_irons,"aud_start_confrontation_pt1_irons",::bet_betrayal_pt1_irons);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt1_technician,"aud_start_confrontation_pt1_tech",::bet_betrayal_pt1_tech);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt2_gideon,"aud_start_confrontation_pt2_gideon",::bet_betrayal_pt2_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt2_ilona,"aud_start_confrontation_pt2_ilona",::bet_betrayal_pt2_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_confrontation_pt2_irons,"aud_start_confrontation_pt2_irons",::bet_betrayal_pt2_irons);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_escape_pt3_ilona,"aud_start_ilona_escape",::bet_escape_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_boat_exit_ilana,"aud_start_boat_exit_ilona",::bet_boat_exit_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_finale_cormack,"aud_start_finale_cormack",::bet_ending_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_finale_gideon,"aud_start_finale_gideon",::bet_ending_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_finale_ilana,"aud_start_finale_ilona",::bet_ending_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%bet_finale_joker,"aud_start_finale_joker",::bet_ending_joker);
}

//Function Number: 78
bet_intro_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_howdoesitfeelto",1.03);
	soundscripts\_snd_playsound::snd_play_delayed_2d("squelch_on_plt",5);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("bet_iln1_gideonmitchell",5.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_ilonawhatisit",9.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("bet_iln1_meetmeinmaintenanceroom",11.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_alrightweremoving2",17.06);
}

//Function Number: 79
bet_betrayal_pt1_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_no",3.04);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_whatthebloodyhellsgoing",7.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_theguywepulledout",13.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_fuckme",48.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_wheredidyougetthis",54.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_howdoyouknowits",59.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_vocalizationforflashbangsequence",69.2);
}

//Function Number: 80
bet_betrayal_pt1_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_didyoutellanyoneyou",1.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_thescramblerwillonlybuy",3.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_justwatchthis",8.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_thatsironswiththetechnologist",10.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_henevermadeitback",15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_heknewit",49.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_hades2",55.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_itwascodedandencrypted",60.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_vocalizationforflashbangsequence",69.19);
}

//Function Number: 81
bet_betrayal_pt1_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_whatkindofattack",20.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_wherearetheyplanningon",27.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_no",37.15);
}

//Function Number: 82
bet_betrayal_pt1_tech(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_tct_thekvaareplanningan",16.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_tct_powerplantsalloverthe",22.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_tct_seattleparistokyothousandswilldie2",29.21);
}

//Function Number: 83
bet_betrayal_pt2_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_yessir",35.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_hesaiditwasa",44.03);
}

//Function Number: 84
bet_betrayal_pt2_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_wesawit",12.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_youknewabouttheattacks",17.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_youreinsaneyoureamonster",22.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_gideon2",36.18);
}

//Function Number: 85
bet_betrayal_pt2_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_yousawwhat",15.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_yousawaforgedrecording2",20.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_imdissapointedinyou",27.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_irs_hesmadehisdecision",46.06);
}

//Function Number: 86
bet_escape_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_weneedtogetout",3.06);
}

//Function Number: 87
bet_boat_exit_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_areyoualright",3.04);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("bet_x_canyoumove",4.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_copy",5.06);
	level maps\_utility::delaythread(5,::play_video_log_climb_block_intro);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("bet_x_extractionpointisrightabove",8.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_howarewesupposedto",11);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("bet_x_useyourgrapple",12.21);
}

//Function Number: 88
bet_ending_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_crk_yourememberyouroldsergeant",5);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_snv_warbirdincoming",10.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_crk_insidenow",31.18);
}

//Function Number: 89
bet_ending_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_standdown",15.09,"sounddone_bet_gdn_standdown");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_ifyourewrongaboutirons",18.21);
	level maps\_utility::delaythread(23.8,::maps\_utility::dialogue_queue,"bet_atr_atlasonewhatsyourstatus");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_gdn_roofisclear",28.24);
}

//Function Number: 90
bet_ending_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_iln1_imnotwrong",21.24);
}

//Function Number: 91
bet_ending_joker(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("bet_jkr_whatstheplayboss",14.12);
}