Feature: naval-game starts a game

	As a player
	I want to start a new game
	So that I can play

	Scenario: setup default game
		Given I am not yet playing
		When I start a new game
		Then I should see "            NORTH ATLANTIC 86"
		And I should see "            COPYRIGHT 1982"
		And I should see "            BY GARY GRIGSBY"
		And I should see "           (redux by skorens)"
		And I should see "      ( 1 ) GAME TYPE:"
		And I should see " ===>   NEW GAME"
		And I should see "        SAVED GAME"
		And I should see "      ( 2 ) SCREEN TYPE:"
		And I should see " ===>   COLOR"
		And I should see "        BLACK AND WHITE"
		And I should see "      ( 3 ) PLAYER TYPE:"
		And I should see " ===>   SOLITAIRE"
		And I should see "        TWO PLAYER"
		And I should see "      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):"
		And I should see "        1"
		And I should see "        2"
		And I should see " ===>   3"
		And I should see "        4"
		And I should see "SCENARIOS:"
		And I should see " ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)"
		And I should see "      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)"
		And I should see "      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)"
		And I should see "      ( 8 ) ICELAND        (NOV11-NOV20 1986)"
		And I should see "PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN."

	Scenario: setup easy default game
		Given I have setup an easy game
		Then I should see " ===>   4"

	Scenario: setup saved black and white two player level one campaign 2 game
		Given I have setup a custom game
		Then I should see " ===>   SAVED GAME"
		And I should see " ===>   BLACK AND WHITE"
		And I should see " ===>   TWO PLAYER"
		And I should see " ===>   1"
		And I should see " ===> ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)"
		