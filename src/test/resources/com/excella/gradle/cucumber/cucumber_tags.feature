Feature: The "cucumber" task should choose scenarios based on tags

  Background:
    Given I have a new Gradle project (wrapper v1.7) using Cucumber v1.1.6 for compile

  @current
  Scenario: Filter scenarios with tag
    Given I write "src/cucumber/resources/com/company/my.feature" as follows
    """
      Feature: Feature Name

        Scenario: Scenario 1
          Given precondition A
          Then assertion B

        @important
        Scenario: Scenario 2
          Given precondition A
          Then assertion C
    """
    And I write "src/cucumber/java/com/company/MyStepDefinitions.java" as follows
    """
      package com.company;
      import cucumber.api.java.en.*;

      public class MyStepDefinitions {
        @Given("^precondition A$")
        public void precondition_A() throws Throwable {
        }

        @Then("^assertion B$")
        public void assertion_B() throws Throwable {
        }

        @Then("^assertion C$")
        public void assertion_C() throws Throwable {
        }
      }
      """
    And I add the following task
    """
      cucumber {
          formats = ['pretty']
          glueDirs = ['classpath:com.company']
          featureDirs = ['src/test/resources/features']
          tags = ['@important']
          monochrome = false
          strict = false
          dryRun = false
      }
      """
    When I successfully run Gradle with "cucumber"
    Then I should see a "1 Scenarios \(1 passed\)" line
    And I should see a "2 Steps \(2 passed\)" line
