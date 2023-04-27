# liftpad
Workout app used to track weight lifted, uses Core Data to store old and new weights. 

README


USER EXPERIENCE

Liftpad is an app that allows user to organize and track their weightlifting exercises. The main screen is a list of workouts, if no workouts exist then users can easily add one by pressing the plus icon on the top right.

Once a workout is selected users are brought to the Workout view with all the associated exercises listed. If there are no exercises users can add them by pressing the plus icon in the top right. There is also a motivational quote of the day the users will see at the bottom of their list.

While working out users input the weight they did for a given exercise and upon tapping the checkmark the weight is added to the exercise data.

If a user taps on the name of the exercise they are brought to the exercise data view where they can see a chart displaying their top weight over time and track progress for each given exercise.

Workouts and exercises can be deleted by dragging from right to left.


APPLICATION NOTES

Data Models

1) the Application Data Model has all the methods used throughout the app to add/update workouts and exercises

2) the Quote manager Data Model has all the methods and properties used to call the API to generate the inspirational quote of the day

3) the CoreData Data Models are used as the blueprint for each workout and exercise. Each workout can be associated with Many exercises( one to many) and each exercise can only be associated with one workout( one to one). There is a constraint making it so no exercises can have the same name and no workouts can have the same name. All Persistent data is managed through CoreData.

Views
1) Main views, these are the large full screen views that make up the main navigation path WorkoutListView to WorkoutView to ExerciseDataView

2) Sheets, these are the views used to add new workouts and exercises without taking the user off the main navigation path

3) Components, there views are smaller views the larger views use to make up the user interface. The ExerciseListBlock is what is displayed in a list view on the WorkoutView.


TESTING

When launching the app for the first time there will be no workouts or exercises but there will be a button labeled “populate data for testing” which will auto populate 4 workouts with various exercises so users can experiement with the user interface without having to create their own workouts.

