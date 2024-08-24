/*
*	 Creator : kalitos
*	 Project : ChangeTeamFix
*    Mode : Multiplayer H2
*	 Date : 2024/08/23 	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;


init()
{
    level thread onPlayerConnect();
    level thread Txtscrolling();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player notifyOnPlayerCommand("changeteamaction", "+talk");
        player thread changeTeamAction();
    }
}

changeTeamAction()
{
	self endon("disconnect");
	level endon("game_ended");
	
	while(true)
	{
		self waittill("changeteamaction");
		
		self thread maps\mp\gametypes\_playerlogic::setuioptionsmenu( 1 ); //Credits to whom it may concern.
			
	}	
}

Txtscrolling()
{
	level endon("game_ended");

	level.txtBottom = "Press ^1[{+talk}] ^2(VoiceChatKey) ^7for Change team";
    level.canScroll = 1;
	level.scrollSpeed = 30;	
	level.hudBottom = createServerFontString ("Objective", 1);
	level.hudBottom setPoint ("BOTTOMCENTER", "BOTTOMCENTER", 0, -5 );
	level.hudBottom.foreground = true;
	level.hudBottom.hideWhenInMenu = true;
	level.hudBottom setText(level.txtBottom);
	level.hudBottom thread destroy_endgame();
	

	if ( level.canScroll == 1 )
	{
		for ( ;; )
		{
			level.hudBottom setPoint( "CENTER", "BOTTOM", 1100, -5 );
			level.hudBottom moveOverTime( level.scrollSpeed );
			level.hudBottom.x = -700;
			wait 30 ;
		}
	}	
}

destroy_endgame()
{
  level waittill("end_game");
  self destroy();
}
