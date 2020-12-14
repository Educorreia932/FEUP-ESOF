# openCX-'Ask Away' Development Report

Welcome to the documentation pages of the *your (sub)product name* of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

- Davide Castro
- Diogo Rosário
- Eduardo Correia
- Gustavo Sena
- Henrique Ribeiro

---

## Product Vision
Help attendees get the most out of conferences they attend by answering the best questions they have.

## Elevator Pitch

For speakers who want to improve the speaker-participant interaction, Ask a Way is an app that guarentees that the questions asked are the ones that the atendees want to hear the most, by using a voting and moderating system that rewards the best questions. Behind every great answer is a great question.

---
## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram 

![Use Cases](Use%20Cases.png)

Create a use-case diagram in UML with all high-level use cases possibly addressed by your module.

Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun. 

Briefly describe each use case mentioning the following:

**Ask questions**

* **Actor**. Attendee. 
* **Description**. Give the attendees the possibility to ask the questions they have in their mind to be cleared. 
* **Preconditions**. User must be logged in to the app and on the correct talk page. 
* **Postconditions**. Question is deleavered to a moderator to filter the useful questions.

* **Normal Flow**. 
  1. Attendee enters the correct talk page.
  2. Click on the bar at the bottom of the screen.
  3. A keyboard will pop up.
  4. The user types the question they want to ask.
  5. The user precess the submit button.
  6. The qestion is fast-fowarded to a moderator to apreve of the question.
* **Alternative Flows and Exceptions**. 
  1. The user is not logged in.
  2. The question wont be posted.

**Vote questions**

* **Actor**. Attendee. 
* **Description**. Gives the attendees power to choose and vote on the questions they want to ear. 
* **Preconditions**. User must be logged in to the app and on the correct talk page. 
* **Postconditions**. A counter is incremented/decreased which represents the like to dislike ratio a question has.

* **Normal Flow**. 
  1. Attendee enters the correct talk page.
  2. Search for the question they want to vote.
  3. Press the upvote or downvote button.
  4. The question like to dislike ratio is altered.
  5. After refreshing the page the questions are sorted by decreasing like to dislike ratio.

* **Alternative Flows and Exceptions**. 
  1. Question already liked.
  2. Attendee presses the upvote button again.
  3. The user's like is removed from the question at hand.
  4. The question like to dislike ratio is altered.
  5. After refreshing the page the questions are sorted by decreasing like to dislike ratio.   
  **OR**
  1. Question already liked.
  2. Attendee presses the downvote button.
  3. The user's like is removed from the question at hand and a dislike is introduced.
  4. The question like to dislike ratio is altered.
  5. After refreshing the page the questions are sorted by decreasing like to dislike ratio. 

**Moderate questions**

* **Actor**. Moderator. 
* **Description**. The moderators filter the questions they think are irrelevant or disruptive for the conference, which will not be displayed for the attendees. 
* **Preconditions**. User must be logged in to the app and on the correct talk page and must be selected as a moderator for said talk. After that the user can see what questions the attendees are asking and vote on them. 
* **Postconditions**. The question will be displayed publicly for the attendees if accepted or deleted if rejected.

* **Normal Flow**. 
  1. Moderators enter the talk they moderate.
  2. They click a special button that is only available to them.
  3. A list of question that are not yet displayed appears.
  4. The moderators click a question.
  5. A drop down appears.
  6. The moderators accepts or refuses the question.

* **Alternative Flows and Exceptions**. 
  1. The moderator clicks a question.
  2. The question has already been judged by another moderator.
  3. The question disappears and nothing changes. 
  
 **Answer questions**

* **Actor**. Speaker. 
* **Description**. The speaker can select questions from the app and aswer them. 
* **Preconditions**. Speaker must enter the talk they are presenting. 
* **Postconditions**. The user selects a question and answers it.

* **Normal Flow**. 
  1. Speaker enters the talk.
  2. Speaker selects the top rated question.
  3. The quesiton is answered.
  4. The question is sent to the end of the list so it is not answered again.
  
   
### User stories
- As an atendee I want to have my questions answered however i do without breaking the flow of the lecture so that all atendees can focus and not lose their line of thought.
```gherkin
Feature: Submit a Question
    Scenario: Users can submit questions to be answered later
        Given I am logged in
        When I fill "questionField" with "MyQuestion"
        Then I tap the "submitQuestionButton" button
        Then I expect "MyQuestion" is present
```
- As a participant I want to be able to up/downvote other atendees' questions so the best questions are answered first. 
```gherkin
Feature: Vote a question
    Scenario: Users can vote questions to prioritise to be answered
        Given I am logged in
        When I tap the "upvoteQuestionButton" button
        Then Question will have one more vote

        Given I am logged in and already voted
        When I tap the "upvoteQuestionButton" button
        Then Question will have one less vote
```
**Question Screen Mock Up**  
<img src="mockups/Talk%20Questions.png" alt="Question Screen" width="200"/>

- As a moderator i want to be able to filter questions that the atendees have so that the speakers have time to answer the questions most people have.  
- As a speaker I would like to be able to have an admin filtering unwanted questions for me.  
```gherkin
Feature: Filter a question
    Scenario: Moderators can filter question users have
        Given I am logged in on a Moderator account
        When I tap the "acceptQuestionButton" button
        Then Question will be accepted and shown to everyone

        Given I am logged in on a Moderator account
        When I tap the "rejectQuestionButton" button
        Then Question will be deleted
```
- As a speaker I want to easily schedule a talk allowing people to book attendance early.  
```gherkin
Feature: Schedule a talk
    Scenario: Speakers can create new talks early
        Given I am logged in
        When I tap the "createTalkButton" button
        Then I fill "talkTitleField" with "test" and "talkDescriptionField" with "test" and "talkLocationField" with "test" and "starDateField" and "endDateField"
        And I tap "submitTalkButton"
        And I expect "talkScreen" to be present
```
<img src="mockups/Talk%20Create.png" alt="Talk Create Screen" width="200"/> <br/>


- As a user I want to know a talk's occupation so I can know if I can still attend it.  
```gherkin
Feature: Check occupation
    Scenario: Users can check talk occupation
        Given I am logged in
        When "talkScreen" is present
        Then I expect "talkAttendance" to be present
```
**Talk Screen Mock Up**  
<img src="mockups/Talks%20Screen.png" alt="Talks Screen" width="200"/>


### Other Mock Ups
**Login Screen Mock Up**  
<img src="mockups/Login%20Screen.png" alt="Login Screen" width="200"/>  
<br/>
**Register Screen Mock Up**  
<img src="mockups/Register%20Screen.png" alt="Register Screen" width="200"/>  
<br/>
**Main Screen Mock Up**  
<img src="mockups/Main%20Screen.png" alt="Main Screen" width="200"/>  
<br/>
**Splash Screen Mock Up**  
<img src="mockups/Splash%20Screen.png" alt="Splash Screen" width="200"/>  
<br/>
**User Profile Mock Up**  
<img src="mockups/User%20Profile.png" alt="User Profile" width="200"/>  
<br/>
### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

---

## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
Regular product increments are a good practice of product management. 

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.
 
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.


---

## Evolution - contributions to open-cx

Describe your contribution to open-cx (iteration 5), linking to the appropriate pull requests, issues, documentation.
