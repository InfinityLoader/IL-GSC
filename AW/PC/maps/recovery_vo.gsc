/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 128
 * Decompile Time: 1843 ms
 * Timestamp: 4/22/2024 2:35:03 AM
*******************************************************************/

//Function Number: 1
prepare_dialogue()
{
	init_dialogue_flags();
	thread play_dialogue();
	thread init_pcap_vo();
	level.scr_sound["gideon"]["rec_gdn_areasclearkeepmoving"] = "rec_gdn_areasclearkeepmoving";
	level.scr_sound["gideon"]["rec_gdn_yourdronesdown"] = "rec_gdn_yourdronesdown";
	level.scr_sound["gideon"]["rec_gdn_useyoursmartgrenades"] = "rec_gdn_useyoursmartgrenades";
	level.scr_sound["gideon"]["rec_gdn_pushforward"] = "rec_gdn_pushforward";
	level.scr_sound["gideon"]["rec_gdn_dontletup"] = "rec_gdn_dontletup";
	level.scr_sound["joker"]["rec_jkr_getathreatgrenadeon"] = "rec_jkr_getathreatgrenadeon";
	level.scr_sound["joker"]["rec_jkr_mitchellyoualright"] = "rec_jkr_mitchellyoualright";
	level.scr_sound["joker"]["rec_jkr_mitchellyoualright2"] = "rec_jkr_mitchellyoualright2";
	level.scr_sound["joker"]["rec_jkr_poolsclear2"] = "rec_jkr_poolsclear2";
	level.scr_sound["joker"]["rec_jkr_poolsclear3"] = "rec_jkr_poolsclear3";
	level.scr_sound["joker"]["rec_jkr_whatthehellswrongwith"] = "rec_jkr_whatthehellswrongwith";
	level.scr_sound["joker"]["rec_jkr_thehellswrongwithyour"] = "rec_jkr_thehellswrongwithyour";
	level.scr_sound["joker"]["rec_jkr_youusedthewrongdamn"] = "rec_jkr_youusedthewrongdamn";
	level.scr_sound["joker"]["rec_jkr_hitemmitchell"] = "rec_jkr_hitemmitchell";
	level.scr_radio["rec_pa_exomark3demonstrationbeginning"] = "rec_pa_exomark3demonstrationbeginning";
	level.scr_radio["rec_pa_remindersecuritybadgesmustbe"] = "rec_pa_remindersecuritybadgesmustbe";
	level.scr_sound["joker"]["rec_jkr_poppinsmoke"] = "rec_jkr_poppinsmoke";
	level.scr_sound["gideon"]["rec_gdn_useyourshield"] = "rec_gdn_useyourshield";
	level.scr_sound["gideon"]["rec_gdn_useoverdrive"] = "rec_gdn_useoverdrive";
	level.scr_radio["rec_pa_resettingsimulation"] = "rec_pa_resettingsimulation";
	level.scr_radio["rec_ch11_raptor23cominginto"] = "rec_ch11_raptor23cominginto";
	level.scr_sound["ilona"]["rec_iln1_shit"] = "rec_iln1_shit";
	level.scr_sound["gideon"]["rec_gdn_goinsidemitchell"] = "rec_gdn_goinsidemitchell";
	level.scr_sound["gideon"]["rec_gdn_getyourarmfixedmitchell"] = "rec_gdn_getyourarmfixedmitchell";
	level.scr_sound["gideon"]["rec_gdn_theyrewaiting"] = "rec_gdn_theyrewaiting";
	level.scr_sound["gideon"]["rec_gdn_shehadafamilymitchell"] = "rec_gdn_shehadafamilymitchell";
	level.scr_sound["gideon"]["rec_gdn_good2"] = "rec_gdn_good2";
	level.scr_sound["gideon"]["rec_gdn_grenadesonlymitchell"] = "rec_gdn_grenadesonlymitchell";
	level.scr_sound["gideon"]["rec_gdn_topjob"] = "rec_gdn_topjob";
	level.scr_sound["gideon"]["rec_gdn_heh3"] = "rec_gdn_heh3";
	level.scr_sound["gideon"]["rec_gdn_averageisright"] = "rec_gdn_averageisright";
	level.scr_sound["gideon"]["rec_gdn_theotherelevatormitchell"] = "rec_gdn_theotherelevatormitchell";
	level.scr_sound["gideon"]["rec_gdn_chooseyourloadout"] = "rec_gdn_chooseyourloadout";
	level.scr_sound["gideon"]["rec_gdn_tossathreatgrenade"] = "rec_gdn_tossathreatgrenade";
	level.scr_sound["gideon"]["rec_gdn_tossathreatgrenade2"] = "rec_gdn_tossathreatgrenade2";
	level.scr_radio["rec_cm1_activatingdronetraining"] = "rec_cm1_activatingdronetraining";
	level.scr_radio["rec_cm1_losingconnection"] = "rec_cm1_losingconnection";
	level.scr_radio["rec_cm1_dronetrainingcomplete"] = "rec_cm1_dronetrainingcomplete";
	level.scr_sound["joker"]["rec_jkr_welldothisquiet"] = "rec_jkr_welldothisquiet";
	level.scr_sound["gideon"]["rec_gdn_gettothewarbirdmitchell"] = "rec_gdn_gettothewarbirdmitchell";
	level.scr_sound["gideon"]["rec_gdn_jokerwerebringingmitchellover"] = "rec_gdn_jokerwerebringingmitchellover";
	level.scr_radio["rec_jkr_yougotitboss"] = "rec_jkr_yougotitboss";
	level.scr_sound["gideon"]["rec_gdn_alrightshowsoverletsmove"] = "rec_gdn_alrightshowsoverletsmove";
	level.scr_sound["ambient_soldier_vo_01"]["rec_at11_theysaiditwasa"] = "rec_at11_theysaiditwasa";
	level.scr_sound["ambient_soldier_vo_02"]["rec_at2_thosefuckersgetbolderby"] = "rec_at2_thosefuckersgetbolderby";
	level.scr_sound["ambient_soldier_vo_01"]["rec_at11_killedeveryhostage"] = "rec_at11_killedeveryhostage";
	level.scr_sound["ambient_soldier_vo_02"]["rec_at2_thenwewontnegotiateeither"] = "rec_at2_thenwewontnegotiateeither";
	level.scr_sound["ambient_soldier_vo_03"]["rec_at11_theysaiditwasa"] = "rec_at11_theysaiditwasa";
	level.scr_sound["ambient_soldier_vo_04"]["rec_at2_thosefuckersgetbolderby"] = "rec_at2_thosefuckersgetbolderby";
	level.scr_sound["ambient_soldier_vo_03"]["rec_at11_killedeveryhostage"] = "rec_at11_killedeveryhostage";
	level.scr_sound["ambient_soldier_vo_04"]["rec_at2_thenwewontnegotiateeither"] = "rec_at2_thenwewontnegotiateeither";
	level.scr_sound["ambient_soldier_vo_05"]["rec_at11_theysaiditwasa"] = "rec_at11_theysaiditwasa";
	level.scr_sound["ambient_soldier_vo_06"]["rec_at2_thosefuckersgetbolderby"] = "rec_at2_thosefuckersgetbolderby";
	level.scr_sound["ambient_soldier_vo_05"]["rec_at11_killedeveryhostage"] = "rec_at11_killedeveryhostage";
	level.scr_sound["ambient_soldier_vo_06"]["rec_at2_thenwewontnegotiateeither"] = "rec_at2_thenwewontnegotiateeither";
	level.scr_sound["ambient_soldier_vo_01"]["rec_at3_nearlybrokehisneckusing"] = "rec_at3_nearlybrokehisneckusing";
	level.scr_sound["ambient_soldier_vo_02"]["rec_at4_justtakesskillman"] = "rec_at4_justtakesskillman";
	level.scr_sound["ambient_soldier_vo_01"]["rec_at3_soyouveneverusedit"] = "rec_at3_soyouveneverusedit";
	level.scr_sound["ambient_soldier_vo_02"]["rec_at4_hellnoyoucrazy"] = "rec_at4_hellnoyoucrazy";
	level.scr_sound["ambient_soldier_vo_03"]["rec_at3_nearlybrokehisneckusing"] = "rec_at3_nearlybrokehisneckusing";
	level.scr_sound["ambient_soldier_vo_04"]["rec_at4_justtakesskillman"] = "rec_at4_justtakesskillman";
	level.scr_sound["ambient_soldier_vo_03"]["rec_at3_soyouveneverusedit"] = "rec_at3_soyouveneverusedit";
	level.scr_sound["ambient_soldier_vo_04"]["rec_at4_hellnoyoucrazy"] = "rec_at4_hellnoyoucrazy";
	level.scr_sound["ambient_soldier_vo_05"]["rec_at3_nearlybrokehisneckusing"] = "rec_at3_nearlybrokehisneckusing";
	level.scr_sound["ambient_soldier_vo_06"]["rec_at4_justtakesskillman"] = "rec_at4_justtakesskillman";
	level.scr_sound["ambient_soldier_vo_05"]["rec_at3_soyouveneverusedit"] = "rec_at3_soyouveneverusedit";
	level.scr_sound["ambient_soldier_vo_06"]["rec_at4_hellnoyoucrazy"] = "rec_at4_hellnoyoucrazy";
	level.scr_sound["gideon"]["rec_gdn_useyourthreatgrenadeagain"] = "rec_gdn_useyourthreatgrenadeagain";
	level.scr_sound["gideon"]["rec_gdn_shootthroughwallstohit"] = "rec_gdn_shootthroughwallstohit";
	level.scr_sound["gideon"]["rec_gdn_getintheelevator"] = "rec_gdn_getintheelevator";
	level.scr_sound["gideon"]["rec_gdn_intheelevatornow"] = "rec_gdn_intheelevatornow";
	level.scr_sound["gideon"]["rec_gdn_moveitrookie"] = "rec_gdn_moveitrookie";
	level.scr_sound["gideon"]["rec_gdn_goodjob"] = "rec_gdn_goodjob";
	level.scr_sound["gideon"]["rec_gdn_fuckme2"] = "rec_gdn_fuckme2";
	level.scr_sound["gideon"]["rec_gdn_watchthefriendlies"] = "rec_gdn_watchthefriendlies";
	level.scr_sound["gideon"]["rec_gdn_theoverdrivebatteryburnsup"] = "rec_gdn_theoverdrivebatteryburnsup";
	level.scr_sound["gideon"]["rec_gdn_itllbeachallengewith"] = "rec_gdn_itllbeachallengewith";
	level.scr_radio["rec_cmr1_yourscorewasexcellent"] = "rec_cmr1_yourscorewasexcellent";
	level.scr_radio["rec_cmr1_beginround3"] = "rec_cmr1_beginround3";
	level.scr_radio["rec_cmr1_beginround2"] = "rec_cmr1_beginround2";
	level.scr_radio["rec_cmr1_useoverdrive"] = "rec_cmr1_useoverdrive";
	level.scr_sound["irons"]["rec_irs_hesreadyforrealwork"] = "rec_irs_hesreadyforrealwork";
	level.scr_sound["gideon"]["rec_gdn_hesgettingtheresir"] = "rec_gdn_hesgettingtheresir";
	level.scr_sound["irons"]["rec_irs_lookslikewehavean"] = "rec_irs_lookslikewehavean";
	level.scr_sound["gideon"]["rec_gdn_mitchelloverhere"] = "rec_gdn_mitchelloverhere";
	level.scr_sound["gideon"]["rec_gdn_gettothewarbird"] = "rec_gdn_gettothewarbird";
	level.scr_sound["gideon"]["rec_gdn_theresourexfil"] = "rec_gdn_theresourexfil";
	level.scr_sound["gideon"]["rec_gdn_copyprophetalrightdigin"] = "rec_gdn_copyprophetalrightdigin";
	level.scr_radio["rec_prt_copyatlaszeroone2"] = "rec_prt_copyatlaszeroone2";
	level.scr_sound["gideon"]["rec_gdn_prophetpackageissecure"] = "rec_gdn_prophetpackageissecure";
	level.scr_sound["gideon"]["rec_gdn_openthefuckingdoormitchell"] = "rec_gdn_openthefuckingdoormitchell";
	level.scr_sound["gideon"]["rec_gdn_mitchellsecurethepresident"] = "rec_gdn_mitchellsecurethepresident";
	level.scr_sound["gideon"]["rec_gdn_getthepresidentinside"] = "rec_gdn_getthepresidentinside";
	level.scr_radio["rec_prt_copythatatlaszeroone"] = "rec_prt_copythatatlaszeroone";
	level.scr_sound["gideon"]["rec_gdn_prophetwereapproachiongthenorth"] = "rec_gdn_prophetwereapproachiongthenorth";
	level.scr_sound["gideon"]["rec_gdn_keepmoving"] = "rec_gdn_keepmoving";
	level.scr_sound["gideon"]["rec_gdn_gogo"] = "rec_gdn_gogo";
	level.scr_sound["gideon"]["rec_gdn_copythatprophet"] = "rec_gdn_copythatprophet";
	level.scr_radio["rec_prt_atlaszeroonebeadvisedwe"] = "rec_prt_atlaszeroonebeadvisedwe";
	level.scr_sound["gideon"]["rec_gdn_useyourdrone"] = "rec_gdn_useyourdrone";
	level.scr_sound["gideon"]["rec_gdn_getyourdroneinthe"] = "rec_gdn_getyourdroneinthe";
	level.scr_sound["gideon"]["rec_gdn_launchyourassaultdrone"] = "rec_gdn_launchyourassaultdrone";
	level.scr_sound["gideon"]["rec_gdn_mitchelluseyourassaultdrone"] = "rec_gdn_mitchelluseyourassaultdrone";
	level.scr_sound["gideon"]["rec_gdn_useyouremps"] = "rec_gdn_useyouremps";
	level.scr_sound["joker"]["rec_jkr_drones"] = "rec_jkr_drones";
	level.scr_sound["gideon"]["rec_gdn_confirmedstaybehindus"] = "rec_gdn_confirmedstaybehindus";
	level.scr_sound["president"]["rec_pts_alphazulutango"] = "rec_pts_alphazulutango";
	level.scr_sound["gideon"]["rec_gdn_mr"] = "rec_gdn_mr";
	level.scr_sound["joker"]["rec_jkr_clear3"] = "rec_jkr_clear3";
	level.scr_sound["gideon"]["rec_gdn_breachthedoor"] = "rec_gdn_breachthedoor";
	level.scr_sound["gideon"]["rec_gdn_bustthatdoormitchell"] = "rec_gdn_bustthatdoormitchell";
	level.scr_sound["gideon"]["rec_gdn_hitthedoormitchell"] = "rec_gdn_hitthedoormitchell";
	level.scr_sound["gideon"]["rec_gdn_mitchellwherethehellare"] = "rec_gdn_mitchellwherethehellare";
	level.scr_sound["gideon"]["rec_gdn_mitchellgettothemedia"] = "rec_gdn_mitchellgettothemedia";
	level.scr_sound["gideon"]["rec_gdn_contact"] = "rec_gdn_contact";
	level.scr_sound["joker"]["rec_jkr_goingthroughthelivingroom"] = "rec_jkr_goingthroughthelivingroom";
	level.scr_sound["joker"]["rec_jkr_enteringthekitchen"] = "rec_jkr_enteringthekitchen";
	level.scr_sound["joker"]["rec_jkr_takingthefrontentrance"] = "rec_jkr_takingthefrontentrance";
	level.scr_sound["gideon"]["rec_gdn_alrightpickyourentrypoint"] = "rec_gdn_alrightpickyourentrypoint";
	level.scr_sound["gideon"]["rec_gdn_clearmoveup"] = "rec_gdn_clearmoveup";
	level.scr_sound["gideon"]["rec_gdn_takeemdown"] = "rec_gdn_takeemdown";
	level.scr_sound["joker"]["rec_jkr_heretheycome"] = "rec_jkr_heretheycome";
	level.scr_radio["rec_prt_atlaszeroonewearetracking2"] = "rec_prt_atlaszeroonewearetracking2";
	level.scr_sound["gideon"]["rec_gdn_okmyleadmyway"] = "rec_gdn_okmyleadmyway";
	level.scr_radio["rec_cmr1_simulationstartingin32"] = "rec_cmr1_simulationstartingin32";
	level.scr_radio["rec_cmr1_preparingassaultmode"] = "rec_cmr1_preparingassaultmode";
	level.scr_sound["joker"]["rec_jkr_copythat2"] = "rec_jkr_copythat2";
	level.scr_sound["gideon"]["rec_gdn_jokerwereheadingup"] = "rec_gdn_jokerwereheadingup";
	level.scr_sound["gideon"]["rec_gdn_kitup"] = "rec_gdn_kitup";
	level.scr_sound["gideon"]["rec_gdn_staysharpironsisgoing"] = "rec_gdn_staysharpironsisgoing";
	level.scr_sound["gideon"]["rec_gdn_letsmove"] = "rec_gdn_letsmove";
	level.scr_radio["rec_cmr1_activatinggrenadetraining"] = "rec_cmr1_activatinggrenadetraining";
	level.scr_sound["gideon"]["rec_gdn_fuckinimpressive"] = "rec_gdn_fuckinimpressive";
	level.scr_sound["gideon"]["rec_gdn_decent"] = "rec_gdn_decent";
	level.scr_sound["gideon"]["rec_gdn_prettyaverage"] = "rec_gdn_prettyaverage";
	level.scr_sound["gideon"]["rec_gdn_fuckmetheyreplacethe"] = "rec_gdn_fuckmetheyreplacethe";
	level.scr_sound["gideon"]["rec_gdn_tossasmartgrenadeand"] = "rec_gdn_tossasmartgrenadeand";
	level.scr_sound["gideon"]["rec_gdn_switchtoempstotake"] = "rec_gdn_switchtoempstotake";
	level.scr_sound["gideon"]["rec_gdn_switchtothreat"] = "rec_gdn_switchtothreat";
	level.scr_sound["gideon"]["rec_gdn_activatetheconsole"] = "rec_gdn_activatetheconsole";
	level.scr_sound["gideon"]["rec_gdn_variablegrenadesletyouswitch"] = "rec_gdn_variablegrenadesletyouswitch";
	level.scr_sound["gideon"]["rec_gdn_alrightgrabsomegrenadesand"] = "rec_gdn_alrightgrabsomegrenadesand";
	level.scr_sound["gideon"]["rec_gdn_copy"] = "rec_gdn_copy";
	level.scr_radio["rec_jkr_bosswegotthesim"] = "rec_jkr_bosswegotthesim";
	level.scr_sound["gideon"]["rec_gdn_overtothegrenaderange"] = "rec_gdn_overtothegrenaderange";
	level.scr_sound["gideon"]["rec_gdn_illbedamnednicework"] = "rec_gdn_illbedamnednicework";
	level.scr_sound["gideon"]["rec_gdn_notbad"] = "rec_gdn_notbad";
	level.scr_sound["gideon"]["rec_gdn_thatthebestyougot"] = "rec_gdn_thatthebestyougot";
	level.scr_sound["gideon"]["rec_gdn_bloodyhellthatwaspathetic"] = "rec_gdn_bloodyhellthatwaspathetic";
	level.scr_radio["rec_cmr1_yourscorewasperfect"] = "rec_cmr1_yourscorewasperfect";
	level.scr_radio["rec_cmr1_yourscorewasgood"] = "rec_cmr1_yourscorewasgood";
	level.scr_radio["rec_cmr1_yourscorewasaverage"] = "rec_cmr1_yourscorewasaverage";
	level.scr_radio["rec_cmr1_yourscorewaspoor"] = "rec_cmr1_yourscorewaspoor";
	level.scr_radio["rec_cmr1_trainingcomplete"] = "rec_cmr1_trainingcomplete";
	level.scr_radio["rec_cmr1_begin"] = "rec_cmr1_begin";
	level.scr_radio["rec_cmr1_activatingtargettraining"] = "rec_cmr1_activatingtargettraining";
	level.scr_sound["gideon"]["rec_gdn_pickitupmitchell"] = "rec_gdn_pickitupmitchell";
	level.scr_sound["gideon"]["rec_gdn_mitchellgetstarted"] = "rec_gdn_mitchellgetstarted";
	level.scr_sound["gideon"]["rec_gdn_stepuptothestation"] = "rec_gdn_stepuptothestation";
	level.scr_sound["gideon"]["rec_gdn_yourexoisequippedwith"] = "rec_gdn_yourexoisequippedwith";
	level.scr_sound["gideon"]["rec_gdn_donthaveallfuckinday"] = "rec_gdn_donthaveallfuckinday";
	level.scr_sound["gideon"]["rec_gdn_grabagunmitchell"] = "rec_gdn_grabagunmitchell";
	level.scr_sound["gideon"]["rec_gdn_alrightkitup"] = "rec_gdn_alrightkitup";
	level.scr_sound["gideon"]["rec_gdn_heh2"] = "rec_gdn_heh2";
	level.scr_sound["ilona"]["rec_iln1_dontneedtotry"] = "rec_iln1_dontneedtotry";
	level.scr_sound["gideon"]["rec_gdn_hereagainilona"] = "rec_gdn_hereagainilona";
	level.scr_radio["rec_pa_attentionatlasteamalphareport"] = "rec_pa_attentionatlasteamalphareport";
	level.scr_sound["gideon"]["rec_gdn_heh"] = "rec_gdn_heh";
	level.scr_sound["gideon"]["rec_gdn_letsheadtotherange"] = "rec_gdn_letsheadtotherange";
	level.scr_sound["repairer_1"]["rec_tc4_goaheadandplaceyour"] = "rec_tc4_goaheadandplaceyour";
	level.scr_sound["repairer_1"]["rec_tc4_tryandmoveyourarm"] = "rec_tc4_tryandmoveyourarm";
	level.scr_sound["repairer_1"]["rec_tc4_okagainplease"] = "rec_tc4_okagainplease";
	level.scr_sound["repairer_1"]["rec_tc4_ithinkiseethe"] = "rec_tc4_ithinkiseethe";
	level.scr_sound["repairer_1"]["rec_tc4_onemoretimeplease"] = "rec_tc4_onemoretimeplease";
	level.scr_sound["repairer_1"]["rec_tc4_alrightyouregoodbuti"] = "rec_tc4_alrightyouregoodbuti";
	level.scr_sound["repairer_1"]["rec_tc4_makingasmalladjustmenthangon"] = "rec_tc4_makingasmalladjustmenthangon";
	level.scr_sound["repairer_1"]["rec_tc4_okjustgoingtorunsome"] = "rec_tc4_okjustgoingtorunsome";
	level.scr_sound["repairer_1"]["rec_tc4_ineedyouoverhere"] = "rec_tc4_ineedyouoverhere";
	level.scr_sound["repairer_1"]["rec_tc4_overhereplease"] = "rec_tc4_overhereplease";
	level.scr_sound["repairer_1"]["rec_tc4_pleasestepoverhere"] = "rec_tc4_pleasestepoverhere";
	level.scr_sound["repairer_1"]["rec_tc4_hellomitchell"] = "rec_tc4_hellomitchell";
	level.scr_sound["gideon"]["rec_gdn_techniciansarewaitingforyou"] = "rec_gdn_techniciansarewaitingforyou";
	level.scr_sound["gideon"]["rec_gdn_thespecialistexoyourewearing"] = "rec_gdn_thespecialistexoyourewearing";
	level.scr_sound["gideon"]["rec_gdn_assaultisequippedwithboost"] = "rec_gdn_assaultisequippedwithboost";
	level.scr_sound["gideon"]["rec_gdn_wevedevelopedtwotypesof"] = "rec_gdn_wevedevelopedtwotypesof";
	level.scr_sound["exo_climb_tech_03"]["rec_tc3_alrightonemoretimeplease"] = "rec_tc3_alrightonemoretimeplease";
	level.scr_sound["exo_climb_tech_03"]["rec_tc3_andgo"] = "rec_tc3_andgo";
	level.scr_sound["exo_climb_tech_03"]["rec_tc3_okletsgetreadyto"] = "rec_tc3_okletsgetreadyto";
	level.scr_sound["exo_climb_tech_01"]["rec_tc1_heh"] = "rec_tc1_heh";
	level.scr_sound["exo_climb_tech_02"]["rec_tc2_thenewcoilshavecleared"] = "rec_tc2_thenewcoilshavecleared";
	level.scr_sound["exo_climb_tech_01"]["rec_tc1_stillgettingadhesionproblemson"] = "rec_tc1_stillgettingadhesionproblemson";
	level.scr_radio["rec_pa_dr"] = "rec_pa_dr";
	level.scr_radio["rec_pa_commencingtest772"] = "rec_pa_commencingtest772";
	level.scr_sound["gideon"]["rec_gdn_ironshastakenashine"] = "rec_gdn_ironshastakenashine";
	level.scr_sound["gideon"]["rec_gdn_alrightoverhere"] = "rec_gdn_alrightoverhere";
	level.scr_sound["irons"]["rec_irs_nowgogetthatarm"] = "rec_irs_nowgogetthatarm";
	level.scr_sound["irons"]["rec_irs_iknowyourenotin"] = "rec_irs_iknowyourenotin";
	level.scr_sound["irons"]["rec_irs_thetruthisweare"] = "rec_irs_thetruthisweare";
	level.scr_sound["irons"]["rec_irs_powerisntjustaboutour"] = "rec_irs_powerisntjustaboutour";
	level.scr_sound["irons"]["rec_irs_unlikethegovernmentwedont"] = "rec_irs_unlikethegovernmentwedont";
	level.scr_sound["irons"]["rec_irs_whatyoureseeingisadvanced"] = "rec_irs_whatyoureseeingisadvanced";
	level.scr_sound["gideon"]["rec_gdn_hurryupmitchell"] = "rec_gdn_hurryupmitchell";
	level.scr_sound["gideon"]["rec_gdn_getin2"] = "rec_gdn_getin2";
	level.scr_sound["gideon"]["rec_gdn_getinthejeepmitchell"] = "rec_gdn_getinthejeepmitchell";
	level.scr_sound["irons"]["rec_irs_jumpin"] = "rec_irs_jumpin";
	level.scr_sound["irons"]["rec_irs_wellthenkeepworking"] = "rec_irs_wellthenkeepworking";
	level.scr_sound["gideon"]["rec_gdn_hesaworkinprogress"] = "rec_gdn_hesaworkinprogress";
	level.scr_sound["irons"]["rec_irs_thatarmsworthmoreto"] = "rec_irs_thatarmsworthmoreto";
	level.scr_sound["gideon"]["rec_gdn_itshisarmsir"] = "rec_gdn_itshisarmsir";
	level.scr_sound["gideon"]["rec_gdn_equipmentfailureisnoexcuse"] = "rec_gdn_equipmentfailureisnoexcuse";
	level.scr_sound["gideon"]["rec_gdn_reset"] = "rec_gdn_reset";
	level.scr_sound["gideon"]["rec_gdn_sloppy"] = "rec_gdn_sloppy";
	level.scr_sound["joker"]["rec_jkr_getthatdooropen"] = "rec_jkr_getthatdooropen";
	level.scr_sound["joker"]["rec_jkr_moveitnow"] = "rec_jkr_moveitnow";
	level.scr_sound["joker"]["rec_jkr_mitchellgetthedoor"] = "rec_jkr_mitchellgetthedoor";
	level.scr_sound["joker"]["rec_jkr_theresourride"] = "rec_jkr_theresourride";
	level.scr_radio["rec_prt_atlaszerooneexfilison"] = "rec_prt_atlaszerooneexfilison";
	level.scr_sound["joker"]["rec_jkr_holdthemoff"] = "rec_jkr_holdthemoff";
	level.scr_sound["rivers"]["rec_rvs_hostilesontheroadcoming"] = "rec_rvs_hostilesontheroadcoming";
	level.scr_sound["joker"]["rec_jkr_weregoingtohaveto"] = "rec_jkr_weregoingtohaveto";
	level.scr_radio["rec_prt_transportiscominginhot"] = "rec_prt_transportiscominginhot";
	level.scr_sound["joker"]["rec_jkr_prophetwereapproachingthenorth"] = "rec_jkr_prophetwereapproachingthenorth";
	level.scr_sound["joker"]["rec_jkr_mitchellstayoncourse"] = "rec_jkr_mitchellstayoncourse";
	level.scr_sound["joker"]["rec_jkr_wereclearmoveon"] = "rec_jkr_wereclearmoveon";
	level.scr_sound["joker"]["rec_jkr_shitclearthemout"] = "rec_jkr_shitclearthemout";
	level.scr_sound["joker"]["rec_jkr_okmove"] = "rec_jkr_okmove";
	level.scr_sound["joker"]["rec_jkr_dontengagejustletthem"] = "rec_jkr_dontengagejustletthem";
	level.scr_sound["joker"]["rec_jkr_hitthedeck"] = "rec_jkr_hitthedeck";
	level.scr_sound["joker"]["rec_jkr_patrolapproachinggetdown"] = "rec_jkr_patrolapproachinggetdown";
	level.scr_sound["joker"]["rec_jkr_gogo"] = "rec_jkr_gogo";
	level.scr_sound["rivers"]["rec_rvs_poolsclear"] = "rec_rvs_poolsclear";
	level.scr_sound["rivers"]["rec_rvs_contactbelowus"] = "rec_rvs_contactbelowus";
	level.scr_sound["joker"]["rec_jkr_dropem"] = "rec_jkr_dropem";
	level.scr_sound["rivers"]["rec_rvs_multiplehostilesbythepool"] = "rec_rvs_multiplehostilesbythepool";
	level.scr_sound["joker"]["rec_jkr_takethemout2"] = "rec_jkr_takethemout2";
	level.scr_sound["rivers"]["rec_rvs_dronesdrones"] = "rec_rvs_dronesdrones";
	level.scr_sound["joker"]["rec_jkr_letthempass"] = "rec_jkr_letthempass";
	level.scr_sound["rivers"]["rec_rvs_igotdronesonthe"] = "rec_rvs_igotdronesonthe";
	level.scr_sound["joker"]["rec_jkr_thisway"] = "rec_jkr_thisway";
	level.scr_sound["joker"]["rec_jkr_letsgethimoutof"] = "rec_jkr_letsgethimoutof";
	level.scr_sound["joker"]["rec_jkr_copythat"] = "rec_jkr_copythat";
	level.scr_radio["rec_prt_copyatlaszeroone"] = "rec_prt_copyatlaszeroone";
	level.scr_sound["joker"]["rec_jkr_prophetwehavethepackage"] = "rec_jkr_prophetwehavethepackage";
	level.scr_sound["president"]["rec_pts_alrightson"] = "rec_pts_alrightson";
	level.scr_sound["joker"]["rec_jkr_ok2"] = "rec_jkr_ok2";
	level.scr_sound["president"]["rec_pts_uhalphazulutango"] = "rec_pts_uhalphazulutango";
	level.scr_sound["joker"]["rec_jkr_mr"] = "rec_jkr_mr";
	level.scr_sound["rivers"]["rec_rvs_roomclear"] = "rec_rvs_roomclear";
	level.scr_sound["kva"]["rec_kva_what"] = "rec_kva_what";
	level.scr_sound["joker"]["rec_jkr_letsgomitchell"] = "rec_jkr_letsgomitchell";
	level.scr_sound["joker"]["rec_jkr_stackupnow"] = "rec_jkr_stackupnow";
	level.scr_sound["joker"]["rec_jkr_getthatmutechargeready"] = "rec_jkr_getthatmutechargeready";
	level.scr_sound["joker"]["rec_jkr_stackupatthedoor"] = "rec_jkr_stackupatthedoor";
	level.scr_sound["joker"]["rec_jkr_clear2"] = "rec_jkr_clear2";
	level.scr_sound["joker"]["rec_rvs_contact"] = "rec_rvs_contact";
	level.scr_sound["gideon"]["rec_jkr_mitchellsweepthebedrooms"] = "rec_jkr_mitchellsweepthebedrooms";
	level.scr_sound["joker"]["rec_jkr_cleartheroom"] = "rec_jkr_cleartheroom";
	level.scr_sound["rivers"]["rec_rvs_clear"] = "rec_rvs_clear";
	level.scr_sound["joker"]["rec_jkr_dammit"] = "rec_jkr_dammit";
	level.scr_sound["joker"]["rec_jkr_hitem"] = "rec_jkr_hitem";
	level.scr_sound["joker"]["rec_jkr_useathreatgrenademitchell"] = "rec_jkr_useathreatgrenademitchell";
	level.scr_sound["joker"]["rec_jkr_mitchelltossathreatgrenade"] = "rec_jkr_mitchelltossathreatgrenade";
	level.scr_sound["joker"]["rec_jkr_copyprophetwereinternal"] = "rec_jkr_copyprophetwereinternal";
	level.scr_radio["rec_prt_atlaszeroonewearetracking"] = "rec_prt_atlaszeroonewearetracking";
	level.scr_sound["joker"]["rec_jkr_closeonthekitchen"] = "rec_jkr_closeonthekitchen";
	level.scr_sound["joker"]["rec_jkr_gothim"] = "rec_jkr_gothim";
	level.scr_sound["joker"]["rec_jkr_goodkill"] = "rec_jkr_goodkill";
	level.scr_sound["rivers"]["rec_rvs_gotanotherone"] = "rec_rvs_gotanotherone";
	level.scr_sound["joker"]["rec_jkr_theyspottedusdropem"] = "rec_jkr_theyspottedusdropem";
	level.scr_sound["joker"]["rec_jkr_payattentionmitchell"] = "rec_jkr_payattentionmitchell";
	level.scr_sound["joker"]["rec_jkr_takethemout"] = "rec_jkr_takethemout";
	level.scr_sound["joker"]["rec_jkr_onyoumitchelldropem"] = "rec_jkr_onyoumitchelldropem";
	level.scr_sound["joker"]["rec_jkr_checkthatthree"] = "rec_jkr_checkthatthree";
	level.scr_sound["joker"]["rec_jkr_twoontheterrace"] = "rec_jkr_twoontheterrace";
	level.scr_sound["joker"]["rec_jkr_okeveryoneknowswhatto"] = "rec_jkr_okeveryoneknowswhatto";
	level.scr_sound["irons"]["rec_irs_dontletwillsdeathbe"] = "rec_irs_dontletwillsdeathbe";
	level.scr_sound["irons"]["rec_irs_willtoldmewhatkind"] = "rec_irs_willtoldmewhatkind";
	level.scr_sound["irons"]["rec_irs_iknowallaboutmitchells"] = "rec_irs_iknowallaboutmitchells";
	level.scr_sound["cormack"]["rec_crk_imsorrymr"] = "rec_crk_imsorrymr";
	level.scr_sound["irons"]["rec_irs_itwasworsethanunfortunate"] = "rec_irs_itwasworsethanunfortunate";
	level.scr_sound["cormack"]["rec_crk_itwasanunfortunatetragedy"] = "rec_crk_itwasanunfortunatetragedy";
	level.scr_sound["irons"]["rec_irs_imsureyouaresergeant"] = "rec_irs_imsureyouaresergeant";
	level.scr_sound["cormack"]["rec_crk_mr"] = "rec_crk_mr";
	level.scr_sound["irons"]["rec_irs_excusemeprivatemitchell"] = "rec_irs_excusemeprivatemitchell";
	level.scr_sound["cormack"]["rec_crk_imsorrymitchell"] = "rec_crk_imsorrymitchell";
	level.scr_sound["cormack"]["rec_crk_heleavesbehindfamilyfriends"] = "rec_crk_heleavesbehindfamilyfriends";
}

//Function Number: 2
play_dialogue()
{
	thread play_funeral_dialog();
	thread play_training_s1_joker_everyone_knows();
	thread play_training_s1_joker_two_terrace();
	thread play_training_s1_joker_on_you();
	thread play_training_s1_joker_good_kill();
	thread play_training_s1_joker_spotted_us();
	thread play_training_s1_rivers_got_another();
	thread play_training_s1_joker_close_kitchen();
	thread play_training_s1_prophet_tracking_potus();
	thread play_training_s1_joker_threat_grenade();
	thread play_training_s1_wrong_grenade();
	thread play_training_s1_joker_hit_em();
	thread play_training_s1_joker_dammit();
	thread play_training_s1_rivers_clear();
	thread play_training_s1_joker_clear_room();
	thread play_training_s1_joker_stack_up();
	thread play_training_s1_joker_mute_charge();
	thread play_training_s1_rivers_room_clear();
	thread play_training_s1_joker_mr_president();
	thread play_training_s1_rivers_got_drones();
	thread play_training_s1_joker_take_out();
	thread play_training_s1_joker_patrol_approaching();
	thread play_training_s1_joker_dont_engage();
	thread play_training_s1_joker_ok_move();
	thread play_training_s1_shit_clear();
	thread play_training_s1_joker_were_clear();
	thread play_training_s1_joker_our_ride();
	thread play_training_s1_rivers_multiple_hostiles();
	thread play_training_s1_reload_malfunctions();
	thread play_training_s1_joker_drop_em();
	thread play_training_s1_rivers_contact_below();
	thread play_training_s1_joker_hit_em_mitchell();
	thread play_training_s1_joker_go_go();
	thread play_training_s1_rivers_pools_clear();
	thread play_training_s1_joker_pools_clear();
	thread play_training_s1_joker_pools_clear_stealth();
	thread play_training_s1_flag_vo_training_s1_joker_prophet_approaching();
	thread play_training_s1_rivers_hostiles_road();
	thread play_training_vo_prophet_exfil_approach();
	thread play_training_s1_joker_poppin_smoke();
	thread play_training_s1_gideon_jeep_nag();
	thread play_training_s1_kva_what();
	thread play_tour_start_dialog1();
	thread play_exo_room_dialog1();
	thread play_arm_room_dialog();
	thread play_exo_room_dialog2();
	thread play_exo_room_techs_dialog1();
	thread play_exo_room_techs_dialog2();
	thread play_base_soldier_group_dialog();
	thread play_pa_exo_dialog1();
	thread play_pa_exo_dialog2();
	thread play_pa_street_dialog1();
	thread play_pa_dialog_reset();
	thread play_base_radio_dialog1();
	thread play_shooting_range_dialog1();
	thread play_shooting_range_dialog3();
	thread play_shooting_range_dialog4();
	thread play_shooting_range_dialog_friendlies();
	thread play_shooting_range_dialog_overdrive();
	thread play_grenade_range_dialog1();
	thread play_grenade_range_dialog2();
	thread play_grenade_range_dialog3();
	thread play_grenade_range_dialog4();
	thread play_grenade_range_dialog5();
	thread play_drone_range_dialog1();
	thread play_drone_range_dialog2();
	thread play_drone_range_dialog3();
	thread play_ready_room_dialog1();
	thread play_ready_room_dialog2();
	thread play_ready_room_dialog3();
	thread play_ready_room_dialog4();
	thread play_training_s2_gideon_my_lead();
	thread play_training_s2_joker_here_they();
	thread play_training_s2_gideon_use_overdrive();
	thread play_training_s2_gideon_clear_move();
	thread play_training_s2_joker_living_room();
	thread play_training_s2_joker_entering_kitchen();
	thread play_training_s2_joker_front_entrance();
	thread play_training_s2_gideon_mitchell_sweep();
	thread play_training_s2_joker_contact();
	thread play_training_s2_joker_clear();
	thread play_training_s2_gideon_media_room();
	thread play_training_s2_gideon_mr_president();
	thread play_training_s2_joker_drones();
	thread play_training_s2_gideon_dont_let_up();
	thread play_training_s2_gideon_smart_grenades();
	thread play_training_s2_prophet_large_qrf();
	thread play_training_s2_gideon_mitchell_assault_drone();
	thread play_training_s2_gideon_go_go();
	thread play_training_s2_gideon_prophet_approaching();
	thread play_training_s2_gideon_president_inside();
	thread play_training_s2_gideon_package_secure();
	thread play_training_s2_gideon_use_your_shield();
	thread play_training_s2_gideon_our_exfil();
	thread play_training_s2_gideon_the_warbird();
}

//Function Number: 3
init_dialogue_flags()
{
	common_scripts\utility::flag_init("flag_vo_funeral_cormack");
	common_scripts\utility::flag_init("flag_vo_funeral_irons");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_everyone_knows");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_two_terrace");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_on_you");
	common_scripts\utility::flag_init("flag_training_s1_joker_close_kitchen");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_threat_grenade");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_wrong_grenade");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_mute_charge");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_got_drones");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_patrol_approaching");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_ok_move");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_our_ride");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_dont_engage");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_multiple_hostiles");
	common_scripts\utility::flag_init("flag_vo_training_s1_reload_malfunction");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_drop_em");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_got_another");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_got_him");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_contact_below");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_hit_em_micthell");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_go_go");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_pools_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_pools_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_pools_clear_stealth");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_stack_up");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_mr_president");
	common_scripts\utility::flag_init("flag_vo_training_s1_shit_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_were_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_prophet_approaching");
	common_scripts\utility::flag_init("flag_vo_training_s1_prophet_exfil_approach");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_hostiles_road");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_take_out");
	common_scripts\utility::flag_init("flag_vo_training_gideon_jeep_nag");
	common_scripts\utility::flag_init("flag_vo_training_s1_prophet_tracking_potus");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_good_kill");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_spotted_us");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_hit_em");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_dammit");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_clear_room");
	common_scripts\utility::flag_init("flag_vo_training_s1_kva_what");
	common_scripts\utility::flag_init("flag_vo_training_s1_rivers_room_clear");
	common_scripts\utility::flag_init("flag_vo_training_s1_joker_poppin_smoke");
	common_scripts\utility::flag_init("flag_vo_pa_reset");
	common_scripts\utility::flag_init("flag_tour_start_dialog1");
	common_scripts\utility::flag_init("flag_tour_start_dialog2");
	common_scripts\utility::flag_init("flag_tour_start_dialog3");
	common_scripts\utility::flag_init("flag_tour_start_dialog4");
	common_scripts\utility::flag_init("flag_vo_exo_push_dialog");
	common_scripts\utility::flag_init("flag_vo_arm_room_01");
	common_scripts\utility::flag_init("flag_vo_arm_room_02");
	common_scripts\utility::flag_init("flag_vo_arm_room_03");
	common_scripts\utility::flag_init("flag_vo_arm_room_04");
	common_scripts\utility::flag_init("flag_vo_arm_room_05");
	common_scripts\utility::flag_init("flag_vo_exo_room_03");
	common_scripts\utility::flag_init("flag_vo_exo_room_05");
	common_scripts\utility::flag_init("flag_vo_shooting_range_01");
	common_scripts\utility::flag_init("flag_vo_shooting_range_02");
	common_scripts\utility::flag_init("flag_vo_shooting_range_computer_activate");
	common_scripts\utility::flag_init("flag_vo_shooting_range_computer_begin");
	common_scripts\utility::flag_init("flag_vo_shooting_range_computer_round_2");
	common_scripts\utility::flag_init("flag_vo_shooting_range_computer_round_3");
	common_scripts\utility::flag_init("flag_vo_shooting_range_friendly");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_bad");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_average");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_good");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_excellent");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_perfect");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_ilona");
	common_scripts\utility::flag_init("flag_vo_shooting_range_result_ilona_used");
	common_scripts\utility::flag_init("flag_vo_shooting_range_overdrive_ready");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_intro");
	common_scripts\utility::flag_init("flag_vo_grenade_range_bullet_penetration");
	common_scripts\utility::flag_init("flag_vo_grenade_range_threat_1");
	common_scripts\utility::flag_init("flag_vo_grenade_range_threat_2");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_threat");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_emp");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_smart");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_contact");
	common_scripts\utility::flag_init("flag_vo_grenade_range_gideon_again");
	common_scripts\utility::flag_init("flag_vo_grenade_range_grenades_only");
	common_scripts\utility::flag_init("flag_vo_grenade_range_computer_activate");
	common_scripts\utility::flag_init("flag_vo_grenade_range_computer_begin");
	common_scripts\utility::flag_init("flag_vo_grenade_range_result_bad");
	common_scripts\utility::flag_init("flag_vo_grenade_range_result_average");
	common_scripts\utility::flag_init("flag_vo_grenade_range_result_good");
	common_scripts\utility::flag_init("flag_vo_grenade_range_result_excellent");
	common_scripts\utility::flag_init("flag_vo_grenade_range_result_perfect");
	common_scripts\utility::flag_init("flag_vo_ready_room_01");
	common_scripts\utility::flag_init("flag_vo_ready_room_02");
	common_scripts\utility::flag_init("flag_vo_ready_room_03");
	common_scripts\utility::flag_init("flag_vo_ready_room_04");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_my_lead");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_push_forward");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_clear_move");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_living_room");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_entering_kitchen");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_front_entrance");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_mitchell_sweep");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_media_room");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_hit_door_nag_off");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_mr_president");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_drones");
	common_scripts\utility::flag_init("flag_vo_training_s2_prophet_large_qrf");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_go_go");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_prophet_approaching");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_president_inside");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_package_secure");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_use_your_shield");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_our_exfil");
	common_scripts\utility::flag_init("flag_vo_training_s2_warbird_pilot");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_mitchell_assault_drone");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_drone_down");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_dont_let_up");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_smart_grenades");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_here_they");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_contact");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_use_overdrive");
	common_scripts\utility::flag_init("flag_vo_training_s2_joker_clear");
	common_scripts\utility::flag_init("flag_vo_training_s2_gideon_the_warbird");
}

//Function Number: 4
play_funeral_dialog()
{
	common_scripts\utility::flag_wait("flag_vo_funeral_cormack");
	common_scripts\utility::flag_wait("flag_vo_funeral_irons");
}

//Function Number: 5
play_training_s1_joker_everyone_knows()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_everyone_knows");
	thread maps\_utility::autosave_by_name();
}

//Function Number: 6
play_training_s1_joker_two_terrace()
{
	level endon("training_s1_start_enemies_alert");
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_two_terrace");
	if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
	{
		var_00 = [];
		var_00 = level.enemies1;
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size > 1)
		{
			level.joker maps\_utility::dialogue_queue("rec_jkr_twoontheterrace");
		}

		var_00 = [];
		var_00 = level.enemies1;
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size > 2)
		{
			level.joker maps\_utility::dialogue_queue("rec_jkr_checkthatthree");
		}
	}
}

//Function Number: 7
play_training_s1_joker_on_you()
{
	level endon("training_s1_start_enemies_alert");
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_on_you");
	thread play_training_s1_joker_take_out_nag();
	if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
	{
		var_00 = [];
		var_00 = level.enemies1;
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size > 0)
		{
			level.joker maps\_utility::dialogue_queue("rec_jkr_onyoumitchelldropem");
		}
	}
}

//Function Number: 8
play_training_s1_joker_take_out_nag()
{
	level endon("training_s1_joker_take_out_nag_off");
	level endon("training_s1_start_enemies_alert");
	level endon("training_s1_prepare_breach_room");
	for(;;)
	{
		wait(8);
		if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
		{
			level.joker maps\_utility::dialogue_queue("rec_jkr_takethemout");
		}

		wait(8);
		if(common_scripts\utility::flag("training_s1_start_alerted") == 0)
		{
			level.joker maps\_utility::dialogue_queue("rec_jkr_payattentionmitchell");
		}
	}
}

//Function Number: 9
play_training_s1_rivers_got_another()
{
	level endon("training_s1_start_enemies_alert");
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_got_another");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_gotanotherone");
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_got_him");
	level.joker maps\_utility::dialogue_queue("rec_jkr_gothim");
}

//Function Number: 10
play_training_s1_joker_good_kill()
{
	level endon("training_s1_start_enemies_alert");
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_good_kill");
	level.joker maps\_utility::dialogue_queue("rec_jkr_goodkill");
}

//Function Number: 11
play_training_s1_joker_spotted_us()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_spotted_us");
	level.joker maps\_utility::dialogue_queue("rec_jkr_theyspottedusdropem");
}

//Function Number: 12
play_training_s1_joker_close_kitchen()
{
	common_scripts\utility::flag_wait("flag_training_s1_joker_close_kitchen");
	level.joker maps\_utility::dialogue_queue("rec_jkr_closeonthekitchen");
}

//Function Number: 13
play_training_s1_prophet_tracking_potus()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_prophet_tracking_potus");
	if(common_scripts\utility::flag("training_s1_start_alerted"))
	{
		common_scripts\utility::flag_wait("training_s1_start_alerted_enemies_dead");
	}

	level maps\_utility::dialogue_queue("rec_prt_atlaszeroonewearetracking");
	level.joker maps\_utility::dialogue_queue("rec_jkr_copyprophetwereinternal");
	wait(0.5);
	common_scripts\utility::flag_set("training_s1_enter_vo_complete");
}

//Function Number: 14
play_training_s1_joker_threat_grenade()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_threat_grenade");
	thread player_training_s1_joker_threat_grenade_nag();
	level.joker maps\_utility::dialogue_queue("rec_jkr_mitchelltossathreatgrenade");
}

//Function Number: 15
player_training_s1_joker_threat_grenade_nag()
{
	level endon("training_s1_joker_threat_grenade_nag_off");
	for(;;)
	{
		wait(8);
		common_scripts\utility::flag_wait("player_at_threat_breach");
		level.joker maps\_utility::dialogue_queue("rec_jkr_useathreatgrenademitchell");
		wait(6);
		common_scripts\utility::flag_wait("player_at_threat_breach");
		level.joker maps\_utility::dialogue_queue("rec_jkr_getathreatgrenadeon");
	}
}

//Function Number: 16
play_training_s1_wrong_grenade()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_wrong_grenade");
	level.joker maps\_utility::dialogue_queue("rec_jkr_youusedthewrongdamn");
	wait(2);
	level.joker maps\_utility::dialogue_queue("rec_jkr_cleartheroom");
}

//Function Number: 17
play_training_s1_joker_hit_em()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_hit_em");
	level.joker maps\_utility::dialogue_queue("rec_jkr_hitem");
}

//Function Number: 18
play_training_s1_joker_dammit()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_dammit");
	level.joker maps\_utility::dialogue_queue("rec_jkr_dammit");
	wait(1);
	level.joker maps\_utility::dialogue_queue("rec_jkr_cleartheroom");
}

//Function Number: 19
play_training_s1_rivers_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_clear");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_clear");
}

//Function Number: 20
play_training_s1_joker_clear_room()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_clear_room");
	level.joker maps\_utility::dialogue_queue("rec_jkr_cleartheroom");
}

//Function Number: 21
play_training_s1_joker_stack_up()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_stack_up");
	wait(8);
	level.joker maps\_utility::dialogue_queue("rec_jkr_stackupatthedoor");
}

//Function Number: 22
play_training_s1_joker_mute_charge()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_mute_charge");
	thread play_training_s1_joker_mute_charge_nag();
	level.joker maps\_utility::dialogue_queue("rec_jkr_welldothisquiet");
	common_scripts\utility::flag_clear("aud_auto_combat_music");
}

//Function Number: 23
play_training_s1_joker_mute_charge_nag()
{
	level endon("training_s1_joker_mute_charge_nag_off");
	for(;;)
	{
		wait(8);
		level.joker maps\_utility::dialogue_queue("rec_jkr_stackupnow");
		wait(8);
		level.joker maps\_utility::dialogue_queue("rec_jkr_letsgomitchell");
	}
}

//Function Number: 24
play_training_s1_kva_what()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_kva_what");
}

//Function Number: 25
play_training_s1_rivers_room_clear()
{
}

//Function Number: 26
play_training_s1_joker_mr_president()
{
	level endon("training_s1_rivers_got_drones");
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_room_clear");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_roomclear");
	wait(0.5);
	common_scripts\utility::flag_set("aud_auto_combat_music");
	level.joker maps\_utility::dialogue_queue("rec_jkr_mr");
	level.president maps\_utility::dialogue_queue("rec_pts_uhalphazulutango");
	level.joker maps\_utility::dialogue_queue("rec_jkr_ok2");
	level.president maps\_utility::dialogue_queue("rec_pts_alrightson");
	level.joker maps\_utility::dialogue_queue("rec_jkr_prophetwehavethepackage");
	level maps\_utility::dialogue_queue("rec_prt_copyatlaszeroone");
	level.joker maps\_utility::dialogue_queue("rec_jkr_copythat");
	level.joker maps\_utility::dialogue_queue("rec_jkr_letsgethimoutof");
	level.joker maps\_utility::dialogue_queue("rec_jkr_thisway");
}

//Function Number: 27
play_training_s1_rivers_got_drones()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_got_drones");
	level notify("training_s1_rivers_got_drones");
	if(!common_scripts\utility::flag("training_s1_search_drones_attack"))
	{
		level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_igotdronesonthe");
	}

	if(!common_scripts\utility::flag("training_s1_search_drones_attack"))
	{
		level.joker maps\_utility::dialogue_queue("rec_jkr_letthempass");
	}
}

//Function Number: 28
play_training_s1_joker_take_out()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_take_out");
	wait(0.25);
	level.joker maps\_utility::dialogue_queue("rec_jkr_takethemout2");
}

//Function Number: 29
play_training_s1_rivers_multiple_hostiles()
{
	level endon("flag_obj_rescue1_complete");
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_multiple_hostiles");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_multiplehostilesbythepool");
	wait(1);
	if(common_scripts\utility::flag("training_s1_search_drones_attack") == 0)
	{
		level.joker maps\_utility::dialogue_queue("rec_jkr_dropem");
	}
}

//Function Number: 30
play_training_s1_reload_malfunctions()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_reload_malfunction");
	common_scripts\utility::flag_clear("flag_vo_training_s1_reload_malfunction");
	wait(1.5);
	if(!common_scripts\utility::flag("training_s1_patio_alerted"))
	{
		level.joker maps\_utility::dialogue_queue("rec_jkr_mitchellyoualright");
	}
	else
	{
		level.joker maps\_utility::dialogue_queue("rec_jkr_mitchellyoualright2");
	}

	common_scripts\utility::flag_wait("flag_vo_training_s1_reload_malfunction");
	wait(1.5);
	level.joker maps\_utility::dialogue_queue("rec_jkr_whatthehellswrongwith");
}

//Function Number: 31
play_training_s1_joker_drop_em()
{
}

//Function Number: 32
play_training_s1_rivers_contact_below()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_contact_below");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_contactbelowus");
	wait(1);
	level.joker maps\_utility::dialogue_queue("rec_jkr_hitemmitchell");
}

//Function Number: 33
play_training_s1_joker_hit_em_mitchell()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_hit_em_micthell");
	level.joker maps\_utility::dialogue_queue("rec_jkr_hitemmitchell");
}

//Function Number: 34
play_training_s1_joker_go_go()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_go_go");
	level.joker maps\_utility::dialogue_queue("rec_jkr_gogo");
}

//Function Number: 35
play_training_s1_rivers_pools_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_pools_clear");
	level.ally_squad_member_2 maps\_utility::dialogue_queue("rec_rvs_poolsclear");
}

//Function Number: 36
play_training_s1_joker_pools_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_pools_clear");
	level.joker maps\_utility::dialogue_queue("rec_jkr_poolsclear3");
	wait(2);
	level.joker maps\_utility::dialogue_queue("rec_jkr_gogo");
}

//Function Number: 37
play_training_s1_joker_pools_clear_stealth()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_pools_clear_stealth");
	level.joker maps\_utility::dialogue_queue("rec_jkr_poolsclear2");
}

//Function Number: 38
play_training_s1_joker_patrol_approaching()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_patrol_approaching");
	level.joker maps\_utility::dialogue_queue("rec_jkr_patrolapproachinggetdown");
	wait(4);
	if(level.player getstance() != "prone")
	{
		level.joker maps\_utility::dialogue_queue("rec_jkr_hitthedeck");
	}
}

//Function Number: 39
play_training_s1_joker_dont_engage()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_dont_engage");
	level.joker maps\_utility::dialogue_queue("rec_jkr_dontengagejustletthem");
}

//Function Number: 40
play_training_s1_joker_ok_move()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_ok_move");
	level.joker maps\_utility::dialogue_queue("rec_jkr_okmove");
}

//Function Number: 41
play_training_s1_shit_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_shit_clear");
	level.joker maps\_utility::dialogue_queue("rec_jkr_shitclearthemout");
}

//Function Number: 42
play_training_s1_joker_were_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_were_clear");
	level.joker maps\_utility::dialogue_queue("rec_jkr_wereclearmoveon");
}

//Function Number: 43
play_training_s1_flag_vo_training_s1_joker_prophet_approaching()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_prophet_approaching");
	soundscripts\_snd::snd_music_message("intro_approaching_north_access_road");
	level.joker maps\_utility::dialogue_queue("rec_jkr_prophetwereapproachingthenorth");
	level maps\_utility::dialogue_queue("rec_prt_transportiscominginhot");
	level.joker maps\_utility::dialogue_queue("rec_jkr_weregoingtohaveto");
}

//Function Number: 44
play_training_s1_rivers_hostiles_road()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_rivers_hostiles_road");
	level.joker maps\_utility::dialogue_queue("rec_jkr_holdthemoff");
}

//Function Number: 45
play_training_vo_prophet_exfil_approach()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_prophet_exfil_approach");
	level maps\_utility::dialogue_queue("rec_prt_atlaszerooneexfilison");
}

//Function Number: 46
play_training_s1_joker_our_ride()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_our_ride");
	thread play_training_s1_joker_ride_nag();
	level.joker maps\_utility::dialogue_queue("rec_jkr_theresourride");
}

//Function Number: 47
play_training_s1_joker_poppin_smoke()
{
	common_scripts\utility::flag_wait("flag_vo_training_s1_joker_poppin_smoke");
	level.joker maps\_utility::dialogue_queue("rec_jkr_poppinsmoke");
}

//Function Number: 48
play_training_s1_joker_ride_nag()
{
	level endon("training_s1_joker_ride_nag_off");
	for(;;)
	{
		wait(6);
		level.joker maps\_utility::dialogue_queue("rec_jkr_mitchellgetthedoor");
		wait(6);
		level.joker maps\_utility::dialogue_queue("rec_jkr_moveitnow");
		wait(6);
		level.joker maps\_utility::dialogue_queue("rec_jkr_getthatdooropen");
	}
}

//Function Number: 49
play_training_s1_gideon_jeep_nag()
{
	level endon("training_gideon_jeep_nag_off");
	common_scripts\utility::flag_wait("flag_vo_training_gideon_jeep_nag");
	for(;;)
	{
		wait(8);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_getinthejeepmitchell");
		wait(8);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_getin2");
		wait(8);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_hurryupmitchell");
	}
}

//Function Number: 50
play_tour_start_dialog1()
{
	common_scripts\utility::flag_wait("tour_ride_gideon_pcap");
	common_scripts\utility::flag_wait("flag_tour_start_dialog2");
	common_scripts\utility::flag_wait("flag_tour_start_dialog3");
	common_scripts\utility::flag_wait("flag_tour_start_dialog4");
}

//Function Number: 51
play_exo_room_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_exo_room_01");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_alrightoverhere");
	common_scripts\utility::flag_wait("flag_vo_exo_room_02");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_ironshastakenashine");
	common_scripts\utility::flag_wait("flag_vo_exo_room_03");
	common_scripts\utility::flag_wait_either("player_inside_exo_mode_room","tour_yellow_door_01");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_wevedevelopedtwotypesof");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_assaultisequippedwithboost");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_thespecialistexoyourewearing");
	wait(1);
	common_scripts\utility::flag_set("flag_obj_arm_repair_pre");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_techniciansarewaitingforyou");
	play_exo_room_dialog1_nag();
}

//Function Number: 52
play_exo_room_dialog1_nag()
{
	level endon("flag_vo_arm_room_01");
	for(;;)
	{
		wait(8);
		if(!common_scripts\utility::flag("flag_vo_arm_room_01"))
		{
			level.gideon maps\_utility::dialogue_queue("rec_gdn_goinsidemitchell");
		}

		wait(8);
		if(!common_scripts\utility::flag("flag_vo_arm_room_01"))
		{
			level.gideon maps\_utility::dialogue_queue("rec_gdn_getyourarmfixedmitchell");
		}

		wait(8);
		if(!common_scripts\utility::flag("flag_vo_arm_room_01"))
		{
			level.gideon maps\_utility::dialogue_queue("rec_gdn_theyrewaiting");
		}
	}
}

//Function Number: 53
play_arm_room_dialog()
{
	level endon("flag_start_shooting");
	common_scripts\utility::flag_wait("flag_vo_arm_room_01");
	wait(1.5);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_hellomitchell");
	wait(1);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_pleasestepoverhere");
	wait(0.5);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_goaheadandplaceyour");
	if(!common_scripts\utility::flag("tour_exo_arm"))
	{
		thread play_arm_room_dialog_nag();
	}

	common_scripts\utility::flag_wait("flag_vo_arm_room_02");
	wait(11);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_okjustgoingtorunsome");
	wait(2);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_tryandmoveyourarm");
	common_scripts\utility::flag_wait("flag_vo_arm_room_03");
	wait(2);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_makingasmalladjustmenthangon");
	wait(3.5);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_okagainplease");
	common_scripts\utility::flag_wait("flag_vo_arm_room_04");
	wait(1.5);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_ithinkiseethe");
	wait(4);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_onemoretimeplease");
	common_scripts\utility::flag_wait("flag_vo_arm_room_05");
	wait(2);
	level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_alrightyouregoodbuti");
	common_scripts\utility::flag_wait("tour_yellow_door_03");
	level maps\_utility::dialogue_queue("rec_pa_remindersecuritybadgesmustbe");
}

//Function Number: 54
play_arm_room_dialog_nag()
{
	level endon("tour_exo_arm");
	while(!common_scripts\utility::flag("tour_exo_arm"))
	{
		wait(8);
		level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_overhereplease");
		wait(8);
		level.repair_guy_01 maps\_utility::dialogue_queue("rec_tc4_ineedyouoverhere");
	}
}

//Function Number: 55
play_exo_room_dialog2()
{
	common_scripts\utility::flag_wait("flag_vo_exo_room_04");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_letsheadtotherange");
	common_scripts\utility::flag_wait("flag_vo_exo_room_05");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_heh3");
	level waittill("notify_vo_shows_over");
	var_00 = common_scripts\utility::getstruct("gideon_fight_distance_check","targetname");
	if(distance2d(var_00.origin,level.gideon.origin) <= 650)
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_alrightshowsoverletsmove");
	}
}

//Function Number: 56
play_exo_room_techs_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_exo_room_techs_01");
	level.exo_climb_tech_01 maps\_utility::dialogue_queue("rec_tc1_stillgettingadhesionproblemson");
	wait(0.25);
	level.exo_climb_tech_02 maps\_utility::dialogue_queue("rec_tc2_thenewcoilshavecleared");
}

//Function Number: 57
play_exo_room_techs_dialog2()
{
	level endon("flag_start_shooting");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_vo_exo_room_techs_02");
		common_scripts\utility::flag_wait("flag_vo_exo_push_dialog");
		if(common_scripts\utility::flag("flag_vo_exo_room_techs_02"))
		{
			level.exo_climb_tech_03 maps\_utility::dialogue_queue("rec_tc3_okletsgetreadyto");
			break;
		}
	}

	level waittill("start_anim_push_02");
	wait(10.5);
	level.exo_climb_tech_03 maps\_utility::dialogue_queue("rec_tc3_andgo");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_vo_exo_room_techs_02");
		common_scripts\utility::flag_wait("flag_vo_exo_push_dialog");
		if(common_scripts\utility::flag("flag_vo_exo_room_techs_02"))
		{
			level.exo_climb_tech_03 maps\_utility::dialogue_queue("rec_tc3_alrightonemoretimeplease");
			break;
		}
	}
}

//Function Number: 58
play_base_soldier_group_dialog()
{
	level endon("training_room_elevator_activated");
	var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_ambient_soldier_group_1","flag_vo_ambient_soldier_group_2","flag_vo_ambient_soldier_group_3");
	switch(var_00)
	{
		case "flag_vo_ambient_soldier_group_1":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_1");
			level.ambient_soldier_vo_01 maps\_utility::dialogue_queue("rec_at11_theysaiditwasa");
			wait(0.3);
			level.ambient_soldier_vo_02 maps\_utility::dialogue_queue("rec_at2_thosefuckersgetbolderby");
			wait(0.3);
			level.ambient_soldier_vo_01 maps\_utility::dialogue_queue("rec_at11_killedeveryhostage");
			wait(0.3);
			level.ambient_soldier_vo_02 maps\_utility::dialogue_queue("rec_at2_thenwewontnegotiateeither");
			break;

		case "flag_vo_ambient_soldier_group_2":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_2");
			level.ambient_soldier_vo_03 maps\_utility::dialogue_queue("rec_at11_theysaiditwasa");
			wait(0.3);
			level.ambient_soldier_vo_04 maps\_utility::dialogue_queue("rec_at2_thosefuckersgetbolderby");
			wait(0.3);
			level.ambient_soldier_vo_03 maps\_utility::dialogue_queue("rec_at11_killedeveryhostage");
			wait(0.3);
			level.ambient_soldier_vo_04 maps\_utility::dialogue_queue("rec_at2_thenwewontnegotiateeither");
			break;

		case "flag_vo_ambient_soldier_group_3":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_3");
			level.ambient_soldier_vo_05 maps\_utility::dialogue_queue("rec_at11_theysaiditwasa");
			wait(0.3);
			level.ambient_soldier_vo_06 maps\_utility::dialogue_queue("rec_at2_thosefuckersgetbolderby");
			wait(0.3);
			level.ambient_soldier_vo_05 maps\_utility::dialogue_queue("rec_at11_killedeveryhostage");
			wait(0.3);
			level.ambient_soldier_vo_06 maps\_utility::dialogue_queue("rec_at2_thenwewontnegotiateeither");
			break;
	}

	var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_ambient_soldier_group_1","flag_vo_ambient_soldier_group_2","flag_vo_ambient_soldier_group_3");
	switch(var_00)
	{
		case "flag_vo_ambient_soldier_group_1":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_1");
			level.ambient_soldier_vo_01 maps\_utility::dialogue_queue("rec_at3_nearlybrokehisneckusing");
			wait(0.3);
			level.ambient_soldier_vo_02 maps\_utility::dialogue_queue("rec_at4_justtakesskillman");
			wait(0.3);
			level.ambient_soldier_vo_01 maps\_utility::dialogue_queue("rec_at3_soyouveneverusedit");
			wait(0.3);
			level.ambient_soldier_vo_02 maps\_utility::dialogue_queue("rec_at4_hellnoyoucrazy");
			break;

		case "flag_vo_ambient_soldier_group_2":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_2");
			level.ambient_soldier_vo_03 maps\_utility::dialogue_queue("rec_at3_nearlybrokehisneckusing");
			wait(0.3);
			level.ambient_soldier_vo_04 maps\_utility::dialogue_queue("rec_at4_justtakesskillman");
			wait(0.3);
			level.ambient_soldier_vo_03 maps\_utility::dialogue_queue("rec_at3_soyouveneverusedit");
			wait(0.3);
			level.ambient_soldier_vo_04 maps\_utility::dialogue_queue("rec_at4_hellnoyoucrazy");
			break;

		case "flag_vo_ambient_soldier_group_3":
			common_scripts\utility::flag_clear("flag_vo_ambient_soldier_group_3");
			level.ambient_soldier_vo_05 maps\_utility::dialogue_queue("rec_at3_nearlybrokehisneckusing");
			wait(0.3);
			level.ambient_soldier_vo_06 maps\_utility::dialogue_queue("rec_at4_justtakesskillman");
			wait(0.3);
			level.ambient_soldier_vo_05 maps\_utility::dialogue_queue("rec_at3_soyouveneverusedit");
			wait(0.3);
			level.ambient_soldier_vo_06 maps\_utility::dialogue_queue("rec_at4_hellnoyoucrazy");
			break;
	}
}

//Function Number: 59
play_pa_dialog_reset()
{
	common_scripts\utility::flag_wait("flag_vo_pa_reset");
	wait(26.5);
	level maps\_utility::dialogue_queue("rec_pa_resettingsimulation");
}

//Function Number: 60
play_pa_exo_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_pa_exo_01");
	level maps\_utility::dialogue_queue("rec_pa_commencingtest772");
}

//Function Number: 61
play_pa_exo_dialog2()
{
	common_scripts\utility::flag_wait("flag_vo_pa_exo_02");
	level maps\_utility::dialogue_queue("rec_pa_dr");
}

//Function Number: 62
play_pa_street_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_pa_street_01");
	level maps\_utility::dialogue_queue("rec_pa_attentionatlasteamalphareport");
}

//Function Number: 63
play_base_radio_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_radio_base_01");
	if(!common_scripts\utility::flag("flag_shooting_range_start"))
	{
		level maps\_utility::dialogue_queue("rec_jkr_bosswegotthesim");
	}

	wait(1);
	if(!common_scripts\utility::flag("flag_shooting_range_start"))
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_copy");
	}
}

//Function Number: 64
play_shooting_range_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_shooting_range_01");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_hereagainilona");
	wait(1);
	level.ilona maps\_utility::dialogue_queue("rec_iln1_dontneedtotry");
	wait(0.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_heh2");
	wait(2);
	if(!common_scripts\utility::flag("flag_obj_equip_firing_range"))
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_alrightkitup");
		thread play_shooting_range_dialog1_nag();
	}

	thread play_shooting_range_dialog2();
}

//Function Number: 65
play_shooting_range_dialog2()
{
	common_scripts\utility::flag_wait("flag_vo_shooting_range_02");
	var_00 = level.player getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"unarmed"))
		{
			var_00 = common_scripts\utility::array_remove(var_00,var_02);
		}
	}

	var_04 = 1;
	foreach(var_02 in var_00)
	{
		if(!issubstr(var_00[0],"titan45"))
		{
			var_04 = 0;
			break;
		}
	}

	if(var_04)
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_itllbeachallengewith");
	}

	level.gideon maps\_utility::dialogue_queue("rec_gdn_yourexoisequippedwith");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_theoverdrivebatteryburnsup");
	maps\_utility::autosave_by_name();
	wait(1);
	common_scripts\utility::flag_set("flag_obj_gun_range_active");
	common_scripts\utility::flag_set("flag_shooting_range_playable");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_stepuptothestation");
	if(!common_scripts\utility::flag("flag_shooting_range_start"))
	{
		thread play_shooting_range_dialog2_nag();
	}
}

//Function Number: 66
play_shooting_range_dialog3()
{
	level endon("flag_obj_elevators_exit_complete");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_shooting_range_start");
		play_shooting_range_dialogue_sequence();
	}
}

//Function Number: 67
play_shooting_range_dialogue_sequence()
{
	level endon("flag_shooting_range_start");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_computer_activate");
	level maps\_utility::dialogue_queue("rec_cmr1_activatingtargettraining");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_computer_activate");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_computer_begin");
	level maps\_utility::dialogue_queue("rec_cmr1_begin");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_computer_begin");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_computer_round_2");
	level maps\_utility::dialogue_queue("rec_cmr1_beginround2");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_computer_round_2");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_computer_round_3");
	level maps\_utility::dialogue_queue("rec_cmr1_beginround3");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_computer_round_3");
}

//Function Number: 68
play_shooting_range_dialog4()
{
	level endon("training_room_elevator_activated");
	var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_shooting_range_result_bad","flag_vo_shooting_range_result_average","flag_vo_shooting_range_result_good","flag_vo_shooting_range_result_excellent","flag_vo_shooting_range_result_perfect");
	soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_trainingcomplete");
	wait(1.6);
	switch(var_00)
	{
		case "flag_vo_shooting_range_result_bad":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewaspoor");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_bloodyhellthatwaspathetic");
			break;

		case "flag_vo_shooting_range_result_average":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasaverage");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_thatthebestyougot");
			break;

		case "flag_vo_shooting_range_result_good":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasgood");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_notbad");
			break;

		case "flag_vo_shooting_range_result_excellent":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasexcellent");
			wait(2.9);
			if(common_scripts\utility::flag("flag_vo_shooting_range_result_ilona"))
			{
				level.ilona maps\_utility::dialogue_queue("rec_iln1_shit");
				common_scripts\utility::flag_set("flag_vo_shooting_range_result_ilona_used");
			}
			else
			{
				level.gideon maps\_utility::dialogue_queue("rec_gdn_goodjob");
			}
			break;

		case "flag_vo_shooting_range_result_perfect":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasperfect");
			wait(2.9);
			if(common_scripts\utility::flag("flag_vo_shooting_range_result_ilona"))
			{
				level.ilona maps\_utility::dialogue_queue("rec_iln1_shit");
				common_scripts\utility::flag_set("flag_vo_shooting_range_result_ilona_used");
			}
			else
			{
				level.gideon maps\_utility::dialogue_queue("rec_gdn_illbedamnednicework");
			}
			break;
	}

	common_scripts\utility::flag_clear("flag_vo_shooting_range_result_bad");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_result_average");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_result_good");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_result_excellent");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_result_perfect");
	wait(3);
	if(!common_scripts\utility::flag("flag_shooting_range_start"))
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_overtothegrenaderange");
	}

	for(;;)
	{
		var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_shooting_range_result_bad","flag_vo_shooting_range_result_average","flag_vo_shooting_range_result_good","flag_vo_shooting_range_result_excellent","flag_vo_shooting_range_result_perfect");
		soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_trainingcomplete");
		wait(1.6);
		switch(var_00)
		{
			case "flag_vo_shooting_range_result_bad":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewaspoor");
				break;
	
			case "flag_vo_shooting_range_result_average":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasaverage");
				break;
	
			case "flag_vo_shooting_range_result_good":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasgood");
				break;
	
			case "flag_vo_shooting_range_result_excellent":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasexcellent");
				break;
	
			case "flag_vo_shooting_range_result_perfect":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasperfect");
				break;
		}

		common_scripts\utility::flag_clear("flag_vo_shooting_range_result_bad");
		common_scripts\utility::flag_clear("flag_vo_shooting_range_result_average");
		common_scripts\utility::flag_clear("flag_vo_shooting_range_result_good");
		common_scripts\utility::flag_clear("flag_vo_shooting_range_result_excellent");
		common_scripts\utility::flag_clear("flag_vo_shooting_range_result_perfect");
		if(common_scripts\utility::flag("flag_vo_shooting_range_result_ilona") && !common_scripts\utility::flag("flag_vo_shooting_range_result_ilona_used"))
		{
			level.ilona maps\_utility::dialogue_queue("rec_iln1_shit");
			common_scripts\utility::flag_set("flag_vo_shooting_range_result_ilona_used");
		}
	}
}

//Function Number: 69
play_shooting_range_dialog1_nag()
{
	level endon("flag_obj_equip_firing_range");
	while(!common_scripts\utility::flag("flag_obj_equip_firing_range"))
	{
		wait(8);
		common_scripts\utility::flag_wait("player_inside_shooting_range");
		if(common_scripts\utility::flag("flag_obj_equip_firing_range"))
		{
			break;
		}

		level.gideon maps\_utility::dialogue_queue("rec_gdn_grabagunmitchell");
		wait(8);
		common_scripts\utility::flag_wait("player_inside_shooting_range");
		if(common_scripts\utility::flag("flag_obj_equip_firing_range"))
		{
			break;
		}

		level.gideon maps\_utility::dialogue_queue("rec_gdn_donthaveallfuckinday");
	}
}

//Function Number: 70
play_shooting_range_dialog2_nag()
{
	level endon("flag_shooting_range_start");
	for(;;)
	{
		wait(8);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_mitchellgetstarted");
		wait(8);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_pickitupmitchell");
	}
}

//Function Number: 71
play_shooting_range_dialog_friendlies()
{
	level endon("shooting_range_completed_once");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_friendly");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_watchthefriendlies");
	wait(3);
	common_scripts\utility::flag_clear("flag_vo_shooting_range_friendly");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_friendly");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_fuckme2");
	wait(3);
	common_scripts\utility::flag_clear("flag_vo_shooting_range_friendly");
	common_scripts\utility::flag_wait("flag_vo_shooting_range_friendly");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_shehadafamilymitchell");
	common_scripts\utility::flag_clear("flag_vo_shooting_range_friendly");
}

//Function Number: 72
play_shooting_range_dialog_overdrive()
{
	level endon("training_room_elevator_activated");
	while(!common_scripts\utility::flag("training_room_elevator_activated"))
	{
		common_scripts\utility::flag_wait("flag_vo_shooting_range_overdrive_ready");
		level maps\_utility::dialogue_queue("rec_cmr1_useoverdrive");
		common_scripts\utility::flag_clear("flag_vo_shooting_range_overdrive_ready");
	}
}

//Function Number: 73
play_grenade_range_dialog1()
{
	level endon("flag_obj_elevators_exit_complete");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_vo_grenade_range_computer_activate");
		level maps\_utility::dialogue_queue("rec_cmr1_activatinggrenadetraining");
		common_scripts\utility::flag_clear("flag_vo_grenade_range_computer_activate");
	}
}

//Function Number: 74
play_grenade_range_dialog2()
{
	level endon("training_room_elevator_activated");
	var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_grenade_range_result_bad","flag_vo_grenade_range_result_average","flag_vo_grenade_range_result_good","flag_vo_grenade_range_result_excellent","flag_vo_grenade_range_result_perfect");
	soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_trainingcomplete");
	wait(1.6);
	switch(var_00)
	{
		case "flag_vo_grenade_range_result_bad":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewaspoor");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_fuckmetheyreplacethe");
			common_scripts\utility::flag_clear("flag_vo_grenade_range_result_bad");
			break;

		case "flag_vo_grenade_range_result_average":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasaverage");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_averageisright");
			common_scripts\utility::flag_clear("flag_vo_grenade_range_result_average");
			break;

		case "flag_vo_grenade_range_result_good":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasgood");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_decent");
			common_scripts\utility::flag_clear("flag_vo_grenade_range_result_good");
			break;

		case "flag_vo_grenade_range_result_excellent":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasexcellent");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_topjob");
			common_scripts\utility::flag_clear("flag_vo_grenade_range_result_excellent");
			break;

		case "flag_vo_grenade_range_result_perfect":
			soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasperfect");
			wait(2.9);
			level.gideon maps\_utility::dialogue_queue("rec_gdn_fuckinimpressive");
			common_scripts\utility::flag_clear("flag_vo_grenade_range_result_perfect");
			break;
	}

	wait(2);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_letsmove");
	wait(3);
	if(!common_scripts\utility::flag("flag_grenade_range_start"))
	{
		level maps\_utility::dialogue_queue("rec_pa_exomark3demonstrationbeginning");
	}

	for(;;)
	{
		var_00 = common_scripts\utility::flag_wait_any_return("flag_vo_grenade_range_result_bad","flag_vo_grenade_range_result_average","flag_vo_grenade_range_result_good","flag_vo_grenade_range_result_excellent","flag_vo_grenade_range_result_perfect");
		soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_trainingcomplete");
		wait(1.6);
		switch(var_00)
		{
			case "flag_vo_grenade_range_result_bad":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewaspoor");
				common_scripts\utility::flag_clear("flag_vo_grenade_range_result_bad");
				break;
	
			case "flag_vo_grenade_range_result_average":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasaverage");
				common_scripts\utility::flag_clear("flag_vo_grenade_range_result_average");
				break;
	
			case "flag_vo_grenade_range_result_good":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasgood");
				common_scripts\utility::flag_clear("flag_vo_grenade_range_result_good");
				break;
	
			case "flag_vo_grenade_range_result_excellent":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasexcellent");
				common_scripts\utility::flag_clear("flag_vo_grenade_range_result_excellent");
				break;
	
			case "flag_vo_grenade_range_result_perfect":
				soundscripts\_snd_playsound::snd_play_2d("rec_cmr1_yourscorewasperfect");
				common_scripts\utility::flag_clear("flag_vo_grenade_range_result_perfect");
				break;
		}
	}
}

//Function Number: 75
play_grenade_range_dialog3()
{
	common_scripts\utility::flag_wait("flag_vo_grenade_range_gideon_intro");
	wait(2);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_alrightgrabsomegrenadesand");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_variablegrenadesletyouswitch");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_activatetheconsole");
	common_scripts\utility::flag_set("flag_obj_grenade_range_pre_2");
}

//Function Number: 76
play_grenade_range_dialog4()
{
	common_scripts\utility::flag_wait("flag_vo_grenade_range_gideon_threat");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_tossathreatgrenade");
	common_scripts\utility::flag_set("flag_obj_grenade_tutorial_threat_start");
	common_scripts\utility::flag_wait("flag_vo_grenade_range_bullet_penetration");
	wait(2.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_shootthroughwallstohit");
	common_scripts\utility::flag_wait("flag_vo_grenade_range_gideon_emp");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_switchtoempstotake");
	common_scripts\utility::flag_wait("flag_vo_grenade_range_gideon_smart");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_tossasmartgrenadeand");
	common_scripts\utility::flag_wait("flag_vo_grenade_range_gideon_again");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_good2");
	common_scripts\utility::flag_wait("flag_vo_grenade_range_threat_2");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_useyourthreatgrenadeagain");
}

//Function Number: 77
play_grenade_range_dialog5()
{
	common_scripts\utility::flag_wait("flag_vo_grenade_range_grenades_only");
	wait(0.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_grenadesonlymitchell");
}

//Function Number: 78
play_drone_range_dialog1()
{
	level endon("training_room_elevator_activated");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_drone_range_start");
		level maps\_utility::dialogue_queue("rec_cm1_activatingdronetraining");
		common_scripts\utility::flag_waitopen("flag_drone_range_start");
	}
}

//Function Number: 79
play_drone_range_dialog2()
{
	level endon("training_room_elevator_activated");
	for(;;)
	{
		level waittill("flag_vo_drone_training_complete");
		level maps\_utility::dialogue_queue("rec_cm1_dronetrainingcomplete");
	}
}

//Function Number: 80
play_drone_range_dialog3()
{
	level waittill("flag_vo_drone_training_exit");
}

//Function Number: 81
play_ready_room_dialog1()
{
	common_scripts\utility::flag_wait("flag_vo_ready_room_01");
	wait(6);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_staysharpironsisgoing");
	wait(0.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_kitup");
	wait(11.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_chooseyourloadout");
}

//Function Number: 82
play_ready_room_dialog2()
{
}

//Function Number: 83
play_ready_room_dialog3()
{
	level endon("training_room_elevator_activated");
	level waittill("gideon_presses_elevator_button");
	wait(5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_getintheelevator");
	thread play_ready_room_elevator_nag();
	common_scripts\utility::flag_wait("player_inside_elevator_right");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_theotherelevatormitchell");
}

//Function Number: 84
play_ready_room_elevator_nag()
{
	level endon("training_room_elevator_activated");
	while(!common_scripts\utility::flag("training_room_elevator_activated"))
	{
		wait(12);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_moveitrookie");
		wait(12);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_intheelevatornow");
	}
}

//Function Number: 85
play_ready_room_dialog4()
{
	common_scripts\utility::flag_wait("flag_vo_ready_room_04");
	wait(3);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_jokerwereheadingup");
	wait(0.25);
	level maps\_utility::dialogue_queue("rec_jkr_copythat2");
	wait(2);
	level maps\_utility::dialogue_queue("rec_cmr1_preparingassaultmode");
	wait(0.25);
	level maps\_utility::dialogue_queue("rec_cmr1_simulationstartingin32");
}

//Function Number: 86
play_training_s2_gideon_my_lead()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_my_lead");
	wait(0.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_okmyleadmyway");
}

//Function Number: 87
play_training_s2_joker_here_they()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_here_they");
	level.joker maps\_utility::dialogue_queue("rec_jkr_heretheycome");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_takeemdown");
	wait(10);
	while(level.player maps\_player_exo::overdrive_is_on() == 1)
	{
		wait 0.05;
	}

	wait(1);
	level maps\_utility::dialogue_queue("rec_prt_atlaszeroonewearetracking2");
}

//Function Number: 88
play_training_s2_gideon_use_overdrive()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_use_overdrive");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_useoverdrive");
}

//Function Number: 89
play_training_s2_gideon_clear_move()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_push_forward");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_pushforward");
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_clear_move");
	wait(1.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_clearmoveup");
	wait(1.5);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_alrightpickyourentrypoint");
}

//Function Number: 90
play_training_s2_joker_living_room()
{
	level endon("training_s2_player_choose_entrance");
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_living_room");
	level.joker maps\_utility::dialogue_queue("rec_jkr_goingthroughthelivingroom");
	level notify("training_s2_player_choose_entrance");
}

//Function Number: 91
play_training_s2_joker_entering_kitchen()
{
	level endon("training_s2_player_choose_entrance");
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_entering_kitchen");
	level.joker maps\_utility::dialogue_queue("rec_jkr_enteringthekitchen");
	level notify("training_s2_player_choose_entrance");
}

//Function Number: 92
play_training_s2_joker_front_entrance()
{
	level endon("training_s2_player_choose_entrance");
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_front_entrance");
	level.joker maps\_utility::dialogue_queue("rec_jkr_takingthefrontentrance");
	level notify("training_s2_player_choose_entrance");
}

//Function Number: 93
play_training_s2_gideon_mitchell_sweep()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_mitchell_sweep");
	if(!common_scripts\utility::flag("flag_bedrooms_dead"))
	{
		level.gideon maps\_utility::dialogue_queue("rec_jkr_mitchellsweepthebedrooms");
	}
}

//Function Number: 94
play_training_s2_joker_contact()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_contact");
	level.joker maps\_utility::dialogue_queue("rec_rvs_contact");
}

//Function Number: 95
play_training_s2_joker_clear()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_clear");
	level.joker maps\_utility::dialogue_queue("rec_jkr_clear2");
	wait(1);
	common_scripts\utility::flag_set("flag_vo_training_s2_gideon_media_room");
}

//Function Number: 96
play_training_s2_gideon_media_room()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_media_room");
	if(!common_scripts\utility::flag("flag_vo_training_s2_gideon_hit_door_nag_off"))
	{
		thread play_training_s2_gideon_hit_door_nag();
		level.gideon maps\_utility::dialogue_queue("rec_gdn_mitchellgettothemedia");
	}
}

//Function Number: 97
play_training_s2_gideon_hit_door_nag()
{
	if(!common_scripts\utility::flag("flag_vo_training_s2_gideon_hit_door_nag_off"))
	{
		return;
	}

	level endon("flag_vo_training_s2_gideon_hit_door_nag_off");
	while(!common_scripts\utility::flag("flag_vo_training_s2_gideon_hit_door_nag_off"))
	{
		wait(7);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_hitthedoormitchell");
		wait(7);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_bustthatdoormitchell");
		wait(7);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_breachthedoor");
	}
}

//Function Number: 98
play_training_s2_gideon_mr_president()
{
	level endon("joker_drones");
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_mr_president");
	level.joker maps\_utility::dialogue_queue("rec_jkr_clear3");
	wait(3);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_mr");
	level.president maps\_utility::dialogue_queue("rec_pts_alphazulutango");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_confirmedstaybehindus");
	wait(0.5);
	level maps\_utility::dialogue_queue("rec_prt_atlaszeroonebeadvisedwe");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_copythatprophet");
}

//Function Number: 99
play_training_s2_joker_drones()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_joker_drones");
	level notify("joker_drones");
	level.joker maps\_utility::dialogue_queue("rec_jkr_drones");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_useyouremps");
}

//Function Number: 100
play_training_s2_gideon_mitchell_assault_drone()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_mitchell_assault_drone");
	thread play_training_s2_gideon_mitchell_assault_drone_nag();
	thread play_training_s2_gideon_drone_down();
	level.gideon maps\_utility::dialogue_queue("rec_gdn_mitchelluseyourassaultdrone");
}

//Function Number: 101
play_training_s2_gideon_mitchell_assault_drone_nag()
{
	level endon("training_s2_drone_enemies_killed");
	level endon("training_s2_drone_start");
	wait(7);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_launchyourassaultdrone");
	wait(7);
	wait(7);
}

//Function Number: 102
play_training_s2_gideon_drone_down()
{
	level endon("training_s2_drone_enemies_killed");
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_drone_down");
	wait(1.4);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_yourdronesdown");
}

//Function Number: 103
play_training_s2_gideon_dont_let_up()
{
	level endon("training_s2_drone_enemies_killed");
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_dont_let_up");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_dontletup");
}

//Function Number: 104
play_training_s2_gideon_smart_grenades()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_smart_grenades");
	wait(1);
	if(level.player setweaponammostock(level.player getweaponslistoffhands()[1]) > 0)
	{
		level.gideon maps\_utility::dialogue_queue("rec_gdn_useyoursmartgrenades");
	}
}

//Function Number: 105
play_training_s2_prophet_large_qrf()
{
}

//Function Number: 106
play_training_s2_gideon_go_go()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_go_go");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_areasclearkeepmoving");
	soundscripts\_snd::snd_music_message("sim2_complete");
	wait(6);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_gogo");
}

//Function Number: 107
play_training_s2_gideon_prophet_approaching()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_prophet_approaching");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_prophetwereapproachiongthenorth");
	level maps\_utility::dialogue_queue("rec_prt_copythatatlaszeroone");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_keepmoving");
}

//Function Number: 108
play_training_s2_gideon_president_inside()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_president_inside");
	thread play_training_s2_gideon_mitchell_secure_nag();
	level.gideon maps\_utility::dialogue_queue("rec_gdn_getthepresidentinside");
}

//Function Number: 109
play_training_s2_gideon_mitchell_secure_nag()
{
	level endon("training_s2_gideon_mitchell_secure_nag_off");
	wait(9);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_openthefuckingdoormitchell");
	wait(8);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_mitchellsecurethepresident");
}

//Function Number: 110
play_training_s2_gideon_package_secure()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_package_secure");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_prophetpackageissecure");
	level maps\_utility::dialogue_queue("rec_prt_copyatlaszeroone2");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_copyprophetalrightdigin");
	common_scripts\utility::flag_set("training_s2_start_exo_shield_tutorial");
}

//Function Number: 111
play_training_s2_gideon_use_your_shield()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_use_your_shield");
	level.gideon maps\_utility::dialogue_queue("rec_gdn_useyourshield");
}

//Function Number: 112
play_training_s2_gideon_our_exfil()
{
	common_scripts\utility::flag_wait("flag_vo_training_s2_warbird_pilot");
	level maps\_utility::dialogue_queue("rec_ch11_raptor23cominginto");
	common_scripts\utility::flag_wait("flag_vo_training_s2_gideon_our_exfil");
	wait(1);
	level.gideon maps\_utility::dialogue_queue("rec_gdn_theresourexfil");
	soundscripts\_snd::snd_music_message("final_combat");
	wait(4);
	thread training_s2_gideon_mitchell_over_nag();
	level.gideon maps\_utility::dialogue_queue("rec_gdn_gettothewarbirdmitchell");
}

//Function Number: 113
play_training_s2_gideon_the_warbird()
{
}

//Function Number: 114
training_s2_gideon_mitchell_over_nag()
{
	level endon("training_s2_gideon_mitchell_over_nag_off");
	for(;;)
	{
		wait(7);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_gettothewarbird");
		wait(7);
		level.gideon maps\_utility::dialogue_queue("rec_gdn_mitchelloverhere");
	}
}

//Function Number: 115
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_funeral_eulogy_ends_cormack,"aud_start_rec_funeral_eulogy_ends_cormack",::rec_funeral_part_1_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_funeral_altascard_cormack,"aud_start_rec_funeral_altascard_cormack",::rec_funeral_part_2_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_funeral_altascard_irons,"aud_start_rec_funeral_altascard_irons",::rec_funeral_part_2_irons);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_campdavid_intro_guy01,"aud_start_rec_campdavid_intro_guy01",::rec_sim_start_joker);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_ending01_gideon,"aud_start_rec_ending01_gideon",::rec_sim_reveal_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_ending01_irons,"aud_start_rec_ending01_irons",::rec_sim_reveal_irons);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_tour_ride_gideon_dialogue_gideon,"aud_start_tour_ride_gideon",::rec_jeep_adr_gdn);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_tour_ride_a_pt2_irons,"aud_start_rec_tour_ride_a_pt2_irons",::rec_jeep_ride_pt1);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_tour_ride_b_pt2_irons,"aud_start_rec_tour_ride_b_pt2_irons",::rec_jeep_ride_pt2);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_tour_ride_c_pt1_irons,"aud_start_rec_tour_ride_c_pt1_irons",::rec_jeep_ride_pt3);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_ending03_gideon,"aud_start_rec_ending03_gideon",::rec_welcometoatlas_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%rec_ending03_irons,"aud_start_rec_ending03_irons",::rec_welcometoatlas_irons);
}

//Function Number: 116
rec_funeral_part_1_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_crk_heleavesbehindfamilyfriends",2.18);
}

//Function Number: 117
rec_funeral_part_2_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_crk_imsorrymitchell",0.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_crk_mr",13.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_crk_itwasanunfortunatetragedy",23.01);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_crk_mrironsmitchellsbeendischarged",32.06);
}

//Function Number: 118
rec_funeral_part_2_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_excusemeprivatemitchell",8.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_imsureyouaresergeant",16.2);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_itwasmorethanunfortunate",25.04);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_imawareofhisinjuries",35.16);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_willtoldmewhatkind",44.14);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_thinkaboutit",52.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_dontletwillsdeathbe",54.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_sergeant",57.19);
}

//Function Number: 119
rec_sim_start_joker(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_jkr_okayeveryoneknowswhatto",6.03,"notify_intro_stealth");
	thread start_stealth_music("notify_intro_stealth");
}

//Function Number: 120
start_stealth_music(param_00)
{
	level waittill(param_00);
	soundscripts\_snd::snd_music_message("start_intro_stealth");
}

//Function Number: 121
rec_jeep_adr_gdn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_jokerwerebringingmitchellover",1.18);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("rec_jkr_yougotitboss",7.12);
}

//Function Number: 122
rec_jeep_ride_pt1(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_whatyoureseeingisadvanced",2.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_unlikethegovernmentwedont",9.24);
}

//Function Number: 123
rec_jeep_ride_pt2(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_powerisntjustaboutthe",5.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_wedoinafew",14.06);
}

//Function Number: 124
rec_jeep_ride_pt3(param_00)
{
	var_01 = 1.24;
	soundscripts\_snd::snd_music_message("rec_mus_tour_ride_end",var_01);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_mitchelliknowyourenot",var_01);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_nowgogetthatarm",9.09,"sound_done_rec_irs_nowgogetthatarm");
}

//Function Number: 125
rec_sim_reveal_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_sloppymitchell",9.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_reset",15.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_noexcuseforequipmentfailure",18.06,"rec_gdn_noexcuseforequipmentfailure_done");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_itshisarmsir",32.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_hesaworkinprogress",39.24);
	soundscripts\_snd::snd_music_message("rec_sim_reveal_gideon");
}

//Function Number: 126
rec_sim_reveal_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_thatarmsworthmoreto2",34.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_wellkeepworking",41.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_jumpin2",49.03);
}

//Function Number: 127
rec_welcometoatlas_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_gdn_hesgettingtheresir",2.18);
}

//Function Number: 128
rec_welcometoatlas_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_lookslikewehavean",6.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("rec_irs_hesreadyforrealwork",9.24);
}