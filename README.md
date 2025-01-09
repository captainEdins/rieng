# 🔖RIENG

### Njeve, meaning "cold" in Kenyan slang, is your go-to app for staying informed about the weather.

This app provides real-time weather updates, keeping you prepared for whatever
Mother Nature throws your way. Plus, Njeve's handy offline features ensure you have access
to the latest forecast, even without an internet connection.

## Project Screenshots

**Here's a glimpse of what this project offers:**

| Splash Screen                                 | Landing Page                                  | Landing Page                                  | Landing Page                                  | Login Page                                    |
|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| ![Screenshot 1](images/screenshot/page-1.jpg) | ![Screenshot 2](images/screenshot/page-2.jpg) | ![Screenshot 3](images/screenshot/page-3.jpg) | ![Screenshot 4](images/screenshot/page-4.jpg) | ![Screenshot 5](images/screenshot/page-5.jpg) |

| Sign Up Page                                  | Sign Up Notification                          | Sign Up Loading                               | Sign Up Successful                            | Rest Password                                   |
|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|-------------------------------------------------|
| ![Screenshot 6](images/screenshot/page-6.jpg) | ![Screenshot 7](images/screenshot/page-7.jpg) | ![Screenshot 8](images/screenshot/page-8.jpg) | ![Screenshot 9](images/screenshot/page-9.jpg) | ![Screenshot 10](images/screenshot/page-10.jpg) |

| Reset Password Successful                      | Login Page Successful                          | Home Page Light Mode                           | Home Page Light Mode                           | Home Page Dark Mode                             |
|------------------------------------------------|------------------------------------------------|------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| ![Screenshot 6](images/screenshot/page-11.jpg) | ![Screenshot 7](images/screenshot/page-12.jpg) | ![Screenshot 8](images/screenshot/page-13.jpg) | ![Screenshot 9](images/screenshot/page-14.jpg) | ![Screenshot 10](images/screenshot/page-15.jpg) |

| Create Habit Light Mode                        | Create Habit Dark Mode                         | Bottom Action Light Mode                       | Bottom Action Dark Mode                        | Bottom Action Light Mode                        |
|------------------------------------------------|------------------------------------------------|------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| ![Screenshot 6](images/screenshot/page-16.jpg) | ![Screenshot 7](images/screenshot/page-17.jpg) | ![Screenshot 8](images/screenshot/page-18.jpg) | ![Screenshot 9](images/screenshot/page-19.jpg) | ![Screenshot 10](images/screenshot/page-20.jpg) |


| Bottom Action Dark Mode                        | Notification Light Mode                        | Notification Dark Mode                         | Statistics Light Mode                          | Statistics Dark Mode                            |
|------------------------------------------------|------------------------------------------------|------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| ![Screenshot 6](images/screenshot/page-21.jpg) | ![Screenshot 7](images/screenshot/page-22.jpg) | ![Screenshot 8](images/screenshot/page-23.jpg) | ![Screenshot 9](images/screenshot/page-24.jpg) | ![Screenshot 10](images/screenshot/page-25.jpg) |

| Profile Page Light Mode                        | Profile Page Dark Mode                         | Edit Profile                                   | Edit Profile                                   | Local Notification                              |
|------------------------------------------------|------------------------------------------------|------------------------------------------------|------------------------------------------------|-------------------------------------------------|
| ![Screenshot 6](images/screenshot/page-26.jpg) | ![Screenshot 7](images/screenshot/page-27.jpg) | ![Screenshot 8](images/screenshot/page-28.jpg) | ![Screenshot 9](images/screenshot/page-29.jpg) | ![Screenshot 10](images/screenshot/page-30.jpg) |

## Key Features

To improve the user experience and reduce data usage, the app implements the following features:

- **Offline data caching:** Weather data is cached for 5 hours after it's retrieved,
  allowing users to interact with the app even without an internet connection.
  This saves users data by displaying the most recent data available.
- **Refresh option:** Users can manually refresh the data by clicking the arrow next
  to their address, ensuring they have the latest information whenever they need it.
- **Limited Hourly Forecast:** Only displays upcoming hours for the weather forecast.

### Benefits:

- **Reduced data consumption:** By caching data, users can avoid unnecessary data downloads,
  especially beneficial for those with limited data plans.
- **Improved user experience:** Offline data access allows users to view weather information
  even when offline.
- **Cost savings:** Reduced API calls lead to lower subscription costs for the app.
- **Reduced Scrolling:** Saves users time by focusing on relevant weather information for the coming hours.

## Download Njeve
- [Download From Google Drive](https://drive.google.com/file/d/1v7HPINARBm1BpcrURCD9UdW9H6RvFtwe/view?usp=sharing)
- [Download From Diawi](https://i.diawi.com/vqGzg3)

## Weather Api
Weather data is retrieved from the **Visual Crossing Weather API**.
- [Tap To View Nyeri Weather Forecast](https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/nyeri%2CK?unitGroup=us&key=TURRDRRQ9UP5GZZ79YTSG8PMF)

## Dependencies
This app utilizes the following external libraries to provide various functionalities:

- **shared_preferences:** Enables storing and retrieving persistent data on the device.
- **smooth_page_indicator:** Provides a visual indicator for navigating through pages or items. (Version: ^1.0.0+2)
- **permission_handler:** Manages runtime permissions required by the app on Android devices. (Version: ^8.3.0)
- **geolocator:** Facilitates accessing the device's location information. (Version: ^8.0.1)
- **intl:** Offers internationalization and localization support for handling different languages and formats. (Version: ^0.17.0)
- **lottie:** Enables displaying animated Lottie animations within the app. (Version: ^1.2.1)
- **geocoding:** Assists with converting addresses or locations into geographical coordinates. (Version: ^3.0.0)
- **http:** Provides a client for making HTTP requests to web servers. (Version: ^0.13.5)
- **loading_animation_widget:** (Optional) Likely a custom package for handling loading animations within the app. (Version: ^1.2.0+2)
# rieng

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
