Feature: naval-game starts a game

	As a player
	I want to start a new game
	So that I can play
	
	Scenario: start game
		Given I am not yet playing
		When I start a new game
		Then I should see "NORTH ATLANTIC 86"
		And I should see "COPYRIGHT 1982"
		And I should see "BY GARY GRIGSBY"
		And I should see "(redux by skorens)"
		And I should see "( 1 ) NEW GAME        SAVED GAME"
		And I should see "( 2 ) COLOR           BLACK AND WHITE"
		And I should see "( 3 ) SOLITAIRE       TWO PLAYER"
		And I should see "( 4 ) SOLITAIRE LEVEL 1  2  3  4"
		And I should see "      (1=HARDEST 4=EASIEST)"
		And I should see "SCENARIOS"
		And I should see " ( 5 ) CAMPAIGN.1 (SEP07-DEC31 1986)"
		And I should see "PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN."
		
	# Scenario: start campaign.1
	# 	Given I have setup a new game
	# 	When I start the game
	# 	Then I should see "LOADING SHIPDATA"
	# 	And I should see "ONE MOMENT PLEASE"
	# 	And I should see "07 SEP 86		AM"
	# 	And I should see "SCORE:"
	# 	And I should see "NATO		0"
	# 	And I should see "SOVIET	0"
	# 	And I should see "PRESS < C > TO CONTINUE"