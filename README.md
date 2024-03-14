# **UniWell**
Insert image of app

# Motivation
In the demanding environment of college life, students often face the challenge of maintaining essential well-being practices, such as adequate sleep, hydration, and incorporating time to exercise in their day. The rigorous demands of extended class hours, intensive study sessions, and the delicate balance between work and social commitments contribute to the trend of neglecting fundamental health needs. Recognizing that sufficient sleep, hydration, and exercise set the foundation for optimal performance, growth, and effective learning, this project aims to address these issues, in the convenient place of one mobile application. Inadequate attention to these fundamental needs can result in challenges, including persistent fatigue, heightened stress levels, and susceptibility to conditions like depression and burnout.
# Solution
Current wellness applications such as Apple Health and Google Fit serve to track activity progress such as sleep and working out. Similarly, devices like the Apple Watch and Fitbit monitor heart rate and steps. However, users would still have to refer to other apps for recommendations that are personalized to them. College students specifically have a difficult time organizing their schedules to balance classes, work, and extracurricular activities. Typically, students would need to download multiple apps to track multiple habits, which can be overwhelming and unproductive. 
# Project Approach
We built an iOS system using SwiftUI that offers an all-in-one solution where students can track hydration, sleep, and fitness levels. It recommends water levels that are required based on the user's weight and activity level. Additionally, it will present the user locations of water refill stations on campus, using MapKit, so that they can rehydrate as soon as possible. Similar to the app functionality of the Zotfinder, we will implement a section that will open up a map-like interface in which we will guide the students to the nearest water station. To track sleep, we utilized Apple's HealthKit to gather the user's sleep data and present their sleep information and sleep score, which is how much sleep they got compared to their desired amount of sleep. Lastly, students can get personalized workout recommendations based on their preference of exercise type, target area, and difficulty. 

Our system gathers data based on how much water they have drank or how much sleep they have gotten the night before, to recommend an appropriate amount of water to drink or what time they should go to bed. 

When the user creates an account, their information will be stored in Firebase Realtime Database.

Personal Model Data Sources:

Context Data Sources:



