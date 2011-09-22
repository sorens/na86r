Feature: naval-game runs

  Scenario: run default game
    Given I setup a default game
    And I run game
    Then I should see "7 SEP 86  AM"
    And I should see "SCORE:"
    And I should see "NATO		0"
    And I should see "SOVIET	0"
    And I should see "CLEAR"
    And I should see "PRESS <C> TO CONTINUE"
