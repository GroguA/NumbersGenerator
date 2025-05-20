# Numbers Generator App

A simple SwiftUI application that displays a list of numbers based on the selected type: **prime numbers** or **Fibonacci numbers**. The app features infinite scrolling for prime numbers and automatically preloads more numbers as the user reaches the bottom of the list.

## Features

- Two number types: Prime and Fibonacci
- Infinite scrolling with automatic preloading
- Switch between number types with UI reset
- Full support for **Light** and **Dark** mode
- Lazy grid layout using `LazyVGrid`
- Performance-optimized loading using background threads

## Architecture

- **MVVM** pattern
- **SwiftUI** + `@StateObject` / `@Published` for reactive UI
- Background number generation via `DispatchQueue`
- Each number is wrapped in a `NumberModel` with associated metadata
