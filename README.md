# **UniWell: Wellness Habit-Tracking App for University Students**
![LoginScreen](https://github.com/Terry816/cs125-group42/assets/97275921/4f276813-e95d-45bb-a9eb-5d399073a6d8)
# Video Presentation
[Link to Presentation](https://youtu.be/YKs7MGxjY0c)
# Video Demo
https://drive.google.com/file/d/1wS4rfQmN6nAMOzs0V34kHK0QkAH0_NqW/view?usp=sharing
# Motivation
In the demanding environment of college life, students often face the challenge of maintaining essential well-being practices, such as adequate sleep, hydration, and incorporating time to exercise in their day. The rigorous demands of extended class hours, intensive study sessions, and the delicate balance between work and social commitments contribute to the trend of neglecting fundamental health needs. Recognizing that sufficient sleep, hydration, and exercise set the foundation for optimal performance, growth, and effective learning, this project aims to address these issues, in the convenient place of one mobile application. Inadequate attention to these fundamental needs can result in challenges, including persistent fatigue, heightened stress levels, and susceptibility to conditions like depression and burnout.
# Solution
While existing wellness applications such as Apple Health and Google Fit track activity progress like sleep and workouts, they often lack personalized recommendations. Devices like the Apple Watch and Fitbit monitor heart rate and steps but do not integrate these data points into holistic recommendations. UniWell provides an all-in-one solution tailored to college students' needs, offering personalized recommendations and tracking for hydration, sleep, and fitness levels. This eliminates the need to use multiple apps, streamlining wellness management for students.
# Key Features
* Hydration Tracking: UniWell recommends water intake based on the user's weight and activity level. It also provides locations of water refill stations on campus using MapKit.
* Sleep Monitoring: Utilizing Apple's HealthKit, UniWell tracks sleep data and presents users with their sleep information and sleep score, comparing actual sleep to desired sleep amounts.
* Personalized Workout Recommendations: Users receive personalized workout recommendations based on exercise type, target area, and difficulty preferences.
# Project Approach
We have built a system using SwiftUI that provides personalized recommendations for three key areas of wellness: hydration, sleep, and physical activity. The app provides tailored suggestions based on individual user data and preferences. We used 5 data sources to build a personal model and 4 for the contextual information as follows:

Personal Model Data Sources:
* Initial User registration via the mobile app
* Sleep activity tracked through smartwatches and Apple Health
* Desired wake up time logged via the mobile app
* User-inputted hydration levels via the mobile app
* Steps that the user takes tracked through smartwatches and Apple Health

Context Data Sources:
* Location from smartphone GPS
* Types of exercises from ExerciseAPI
* iOS HealthKit
* iOS MapKit



