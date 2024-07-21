# News App

Flutter app to search for tv shows available from tv maze api

<img width="160" alt="image" src="https://github.com/user-attachments/assets/26948cd6-7ecb-43c4-ae16-f972959b8719">
<img width="160" alt="image" src="https://github.com/user-attachments/assets/3c31aa37-2575-4c8d-ad5a-282853ba745a">
<img width="160" alt="image" src="https://github.com/user-attachments/assets/378b3e53-c84b-4749-94b5-02d177d27b3b">

***

And let's understand how this project was implemented below.

## Dependency Injection and Router

The first item valid to be mentioned for the project involves the whole structure which it is based. We are basically working with two different structures:

 1. **Dependency Injection**: We use Get It as a Service Locator as our dependency injection (DI) system that helps managing dependencies in a clean and maintainable way. Dependency injection in Flutter applications helps decouple object creation from the business logic, promoting better testability and reusability.

 2. **Route Management**: Our structure allows each feature to manage its own routes. This keeps route definitions clean and concise, making the app's navigation structure more intuitive and easier to manage.

The application starts in `lib/base_app` folder, where we can find the `main.dart`, `bootstrap.dart` to load injections, and injection and router structures. 

Then, we move to `lib/features`, finding the features implemented as modules, and also using `Clean Architecture` to separate the different layers and responsibilities. 

## Clean Architecture

To enhance the maintainability and scalability of the application, I adopted the `Clean Architecture` pattern for the features. This architectural approach ensures a clear separation of concerns and adheres to SOLID principles, which are crucial for building robust and testable software.

~~~
feature/
├── presentation/
├── domain/
└── data/
~~~

The project is divided into several layers, each with a specific role:

* **Presentation Layer**: Contains the UI components and handles user interactions.
* **Domain Layer**: Encapsulates the business logic and use cases.
* **Data Layer**: Manages data sources, repositories, and data models.

In our features, we can see additional layers, such as `di (dependency injection)`, which creates creates all the connectios between the interfaces and implementations; and `routes`, to organize better the definition for each route within the feature.

As we are doing the best usage of `SOLID` principles, we have one which is a special case: `Dependency Inversion`. This principle helps us to avoid classes depending directly from the implementation, but depending from contracts (interfaces or abstract classes). It allows us to receive dependencies in our classes' constructor, and mock their behavior to write **tests**.

## Before running the app

To run the app properly, you have to edit in Run/Debug configurations the Dart entrypoint, in such a way that you can point the execution to `lib/base_app/main.dart`.

![image](https://github.com/user-attachments/assets/65d23f53-ed64-48b4-babd-f3fb483d2dda)

Below we can see the Flutter and Dart version when the app was implemented. 

![image](https://github.com/user-attachments/assets/32fd46c0-020a-4fd3-8c6f-21ac125c32b3)
