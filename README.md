# **UniWell: Wellness Habit-Tracking App for University Students**
![LoginScreen](https://github.com/Terry816/cs125-group42/assets/97275921/4f276813-e95d-45bb-a9eb-5d399073a6d8)
# Video Presentation
Link to Presentation
# Video Demo
Link to Demo
# Motivation
In the demanding environment of college life, students often face the challenge of maintaining essential well-being practices, such as adequate sleep, hydration, and incorporating time to exercise in their day. The rigorous demands of extended class hours, intensive study sessions, and the delicate balance between work and social commitments contribute to the trend of neglecting fundamental health needs. Recognizing that sufficient sleep, hydration, and exercise set the foundation for optimal performance, growth, and effective learning, this project aims to address these issues, in the convenient place of one mobile application. Inadequate attention to these fundamental needs can result in challenges, including persistent fatigue, heightened stress levels, and susceptibility to conditions like depression and burnout.
# Solution
While existing wellness applications such as Apple Health and Google Fit track activity progress like sleep and workouts, they often lack personalized recommendations. Devices like the Apple Watch and Fitbit monitor heart rate and steps but do not integrate these data points into holistic recommendations. UniWell provides an all-in-one solution tailored to college students' needs, offering personalized recommendations and tracking for hydration, sleep, and fitness levels. This eliminates the need to use multiple apps, streamlining wellness management for students.
# Key Features
* Hydration Tracking: UniWell recommends water intake based on the user's weight and activity level. It also provides locations of water refill stations on campus using MapKit.
* Sleep Monitoring: Utilizing Apple's HealthKit, UniWell tracks sleep data and presents users with their sleep information and sleep score, comparing actual sleep to desired sleep amounts.
* Personalized Workout Recommendations: Users receive personalized workout recommendations based on exercise type, target area, and difficulty preferences.
# Project Approach
UniWell is built for iOS using SwiftUI, providing an intuitive and user-friendly interface. It generates recommendations for hydration, sleep, and fitness habits based on user information stored in Firebase Realtime Database. and utilizes MapKit for locating water refill stations on campus. The app's recommendation system is based on user data, adjusting water intake and sleep recommendations based on daily habits.

From the user's Apple Watch or iPhone, we gathered the user's sleep data from their Health app using HealthKit. 

We built an iOS system using SwiftUI that offers an all-in-one solution where students can track hydration, sleep, and fitness levels. It recommends water levels that are required based on the user's weight and activity level. Additionally, it will present the user locations of water refill stations on campus, using MapKit, so that they can rehydrate as soon as possible. Similar to the app functionality of the Zotfinder, we will implement a section that will open up a map-like interface in which we will guide the students to the nearest water station. To track sleep, we utilized Apple's HealthKit to gather the user's sleep data and present their sleep information and sleep score, which is how much sleep they got compared to their desired amount of sleep. Lastly, students can get personalized workout recommendations based on their preference of exercise type, target area, and difficulty. 

Our system gathers data based on how much water they have drank or how much sleep they have gotten the night before, to recommend an appropriate amount of water to drink or what time they should go to bed. 

Personal Model Data Sources:
* Initial user registration (Age, Height, Weight, Gender, Activity Level)
* Sleep Time based on iOS Health
* Path to the nearest water fountain based on user location
Context Data Sources:
* Location from smartphone GPS
* 


