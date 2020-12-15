# openCX-'Ask Away' Development Report

Welcome to the documentation pages of the **Ask Away** product of **openCX**!

You can find here detailed about the Ask Away application, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

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

Help attendees get the most out of conferences they attend by submitting the questions they have on our platform to be answered by the speakers that are giving the lecture.

## Elevator Pitch

> Behind every great answer is a great question.

For speakers who want to improve the speaker-participant interaction, **Ask Away** is an app that guarentees that the questions asked are the ones that the atendees want to hear the most, by using a voting and moderating system that rewards the best questions.  
Atendees can submit new questions during a talk in our app, to be answered by the speaker without disrupting the talk. 

---
## Requirements

### Use Case diagram 

![Use Cases](diagrams/Use%20Cases.png)

Briefly description of each use case of the product.

**Ask questions**

* **Actor:** Attendee. 
* **Description:** Give the attendees the possibility to ask the questions they have in their mind to be clarified. 
* **Preconditions:** User must be logged in to the app and on the correct talk page. 
* **Postconditions:** Question is deleavered to a moderator to filter the useful questions.

* **Normal Flow:**
  1. Attendee enters the correct talk page.
  2. Click on the bar at the bottom of the screen.
  3. A keyboard will pop up.
  4. The user types the question they want to ask.
  5. The user precess the submit button.
  6. The qestion is fast-fowarded to a moderator to apreve of the question.

* **Alternative Flows and Exceptions:** 
  1. The user is not logged in.
  2. The question wont be posted.

**Vote questions**

* **Actor:** Attendee. 
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
  3. The question is answered.
  4. The question is sent to the end of the list so it is not answered again.
  
   
### User stories
- As an atendee I want to have my questions answered. However, I want it without breaking the flow of the lecture, so that all atendees can focus and not lose their line of thought.
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


- As a speaker, I want to assign roles to the users attending the talk I'll be presenting (such as attendee, moderator or other speakers).  


```gherkin
Feature: Assign roles to talks
    Scenario: Speaker can choose people that will attend the talk to also moderate it.
        Given I am logged in as the talk speaker
        When I tap the "addRole" button
        Then I expect "addRoleScreen" to be present
```

**Role Assignment Screen Mock Up**  

<img src="mockups/Role%20Screen.png" alt="Role Assignment Screen" width="200"/>

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

In this project, our group decided to mainly use to architectural patters:
* Client-server pattern
* MVC (Model, view, controller)

The first architectural patterns is easily spotted, because every action we take and data we see or input is most likely stored in our database.
The second one is obtanded thanks to the separation between the modules screens, models and components.
The screens module is responsible to display to the user all the information needed using the data stored in the module models. This second module is responsible of storing the data and creating the widgets to give so the screen module can display the data. Every widget has a diferent class from eachother which contains functions needed to parse data and create data. 
Thanks to this separation, the screen module works with any amount of data (question, talks, etc.) which lead to a smoother expantion of functionalities and better performance.


### Physical architecture
The physical architecture of our project relies on two separate blocks that communicate with each other via HTTPS requests.

* The Client Side that represents the Ask Away App, installed on the user's smartphone created using flutter.

* The Server Side, where all important data is stored. This data is stored in a FireBase data base and is updated while the user is using the app in order to keep all information up to date.

The connection between the Firebase and the user's app is done only when needed in order to reduce the time wasted in HTTP requests, making the app run faster and smoother. <br/> When entering a new screen all data that's needed to build the interface is loaded and in case any of update to such data, another request is sent to the Firebase server, also updating the information present there.

![Physical Architecure Diagram](diagrams/Physical%20Architecture.png)

### Prototype

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

For the following user stories:
* As an atendee I want to have my questions answered however i do without breaking the flow of the lecture so that all atendees can focus and not lose their line of thought.
* As a participant I want to be able to up/downvote other atendees' questions so the best questions are answered first.

Since they are fairly similar we implemented both of them at the same time. The app provides a questioning screen for each talk where users can ask their question and have them voted by other in order to determine which are the most important questions the speaker should be answering.

For the following user stories:
* As a moderator i want to be able to filter questions that the atendees have so that the speakers have time to answer the questions most people have.
* As a speaker I would like to be able to have an admin filtering unwanted questions for me.

Our group implemented a way that before any question is presented to our users the talk's moderators have a chance to filter them, by accepting or refusing. This way, unwanted questions are not presented to the atendees in order to not disrupt the flow.

For the following user story:
* As a speaker I want to easily schedule a talk allowing people to book attendance early.

A way to create a talk at any time was implemented on the talks screen. With this functionality a user can create a talk and set at what date and time they will host the talk. It's also possible to create a description and title in this functionality. Since the talks can be scheduled early, other users can save it, booking a place for them.

For the following user story:
* As a user I want to know a talk's occupation so I can know if I can still attend it.

In order to let the atendees know how many people will attend the talk, when they are on the talk screen an indication about how many people bookmarked that talk will appear.

---

## Implementation
Throughout the project development, we have worked by implementing multiple iterations:

#### Iteration 1
As we started working on the app, we focused our first iteration on learning the basics of the flutter engine, implementing the first pages and starting with the question rate system.

#### Iteration 2
In this iteration we dedicated time into continuing and improving on the work made in the first iteration, working on the app's menus, how to update pages and list data.

#### Iteration 3
The main focus in the third iteration was to get a database up and running to store all of the data. We decided to use a Firebase database and started changing the app's code to accomodate its use, storing and reading the data when needed, including user authentication. We also redesigned the app's appearance and made the ground work for the talks.

#### Iteration 4
With this last iteration our focus turned mostly to the details in the talks, as the different roles a user can have, talk occupation and the talk moderators funcionalities. We also spent time fixing some of the previously implemented funcionalities and developing acceptance tests.

---
## Test

We have tested the following feature:
* Getting to the login screen from the home screen.
* Login with a custom account.

Although we only have these features tested, we created templates for acceptance tests for varius features which can be found in the user stories section.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

For the project management we used [Github Projects](https://github.com/features/project-management/com), as it is a good yet simple tool to keep track of the project status, including user stories, notes and issues.  
It also is incorporated into the Github repository, which makes the development easier as there is no need for other tools. 
