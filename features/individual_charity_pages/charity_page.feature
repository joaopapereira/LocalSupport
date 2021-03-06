Feature: Web page owned by each charity
  As a charity worker
  So that I can increase my charity's visibility
  I want to have a web presence
  Tracker story ID: https://www.pivotaltracker.com/story/show/45405153

  Background: organisations have been added to database
    Given the following organisations exist:
      | name       | description             | address        | postcode | telephone | website             | email             |
      | Friendly   | Bereavement Counselling | 34 pinner road | HA1 4HZ  | 020800000 | http://friendly.org | superadmin@friendly.xx |
      | Unfriendly | Bunch of jerks          | 30 pinner road |          | 020800010 |                     |                   |
    Given the following users are registered:
      | email                         | password | organisation | confirmed_at         |
      | registered_user-1@example.com | pppppppp | Friendly     | 2007-01-01  10:00:00 |
      | registered_user-2@example.com | pppppppp |              | 2007-01-01  10:00:00 |

    And I visit the show page for the organisation named "Friendly"

    Given the following categories exist:
      | name              | charity_commission_id |
      | Animal Welfare    | 101                   |
      | Health            | 102                   |
      | Education         | 103                   |
      | Voluntary         | 201                   |
      | Finance           | 301                   |
     Given the following categories_organisations exist:
      | category  | organisation |
      | Health    | Friendly |
      | Education | Friendly |
      | Voluntary | Friendly  |
      | Finance   | Friendly  |
    And I visit the show page for the organisation named "Friendly"


  Scenario: be able to view link to charity site on individual charity page
    Then I should see the external website link for "Friendly" charity

  Scenario: display charity title in a visible way
    Then I should see "Friendly" < tagged > with "h3"

  Scenario: show organisation e-mail as link
    Then I should see a mail-link to "superadmin@friendly.xx"

  Scenario: show categories of charity by type
    Then I should see "Health" within "What they do"
    And I should see "Education" within "What they do"
    And I should see "Voluntary" within "Who they help"
    And I should see "Finance" within "How they help"
    And I should not see "Animal Welfare"
    And I visit the show page for the organisation named "Unfriendly"
    Then I should not see "Health"
    And I should not see "Education"
    And I should not see "Animal Welfare"

  Scenario Outline: show labels if field is present
    Then I should see "<label>"
  Examples:
    | label    |
    | Postcode |
    | Email    |
    | Website  |

  Scenario Outline: hide labels if field is empty
    Given I visit the show page for the organisation named "Unfriendly"
    Then I should not see "<label>"
  Examples:
    | label    |
    | Postcode |
    | Email    |
    | Website  |
