/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 184 ms
 * Timestamp: 4/22/2024 2:32:15 AM
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
}

//Function Number: 3
setup_vo()
{
}

//Function Number: 4
start_dialogue_threads()
{
}

//Function Number: 5
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_intro_ally_1,"aud_ie_intro_ally_1",::ie_intro_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_briefing_start_ilona,"aud_ie_briefing_start_ilona_start",::ie_briefing_start_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_briefing_start_cormack,"aud_ie_briefing_start_cormack_start",::ie_briefing_start_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_briefing_start_cormack,"cormack_briefing_anim_start",::ie_briefing_start_cormack_2);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_hangar_kva,"aud_ie_hangar_kva_start",::ie_hangar_kva);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_hangar_irons,"aud_ie_hangar_irons_start",::ie_hangar_irons);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%ie_car_ride_driving_cormack,"aud_ie_car_ride_driving_cormack_start",::ie_car_ride);
}

//Function Number: 6
ie_intro_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_frontdoor",18.35);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_readyhooks",23.25);
}

//Function Number: 7
ie_briefing_start_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_iln_herehecomes",2);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_iln_upagainstold",9.03);
}

//Function Number: 8
ie_briefing_start_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_goodtohaveyou",5.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_knowthisisdiff",17);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_thisisbigger",21.27);
}

//Function Number: 9
ie_briefing_start_cormack_2(param_00)
{
	wait(5.95);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_greenlight",0.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_privateestate",4);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_insertionteam",9.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_gatherintel",14);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crmk_getitdone",20);
}

//Function Number: 10
ie_hangar_kva(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_doc_aslongas",1.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_doc_wearemoving",10);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_doc_iwillhavefailed",17.12);
}

//Function Number: 11
ie_hangar_irons(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_irs_veryserious",5.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_irs_concernforsafety",14.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_irs_dontworry",22.12);
}

//Function Number: 12
ie_car_ride(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_runthatname",0.09);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("ie_knx_alreadyonit",3.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_thekvadoc",8.12);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("ie_iln_sodidi",12.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_getallthis",14.15);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("ie_knx_copythat",19.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("ie_crk_readynow",26.21);
}