# On This Day - Smartphone App

## Description

**On This Day** is a cross-platform smartphone application built with **Flutter**, fetching facts from the [NumbersAPI](http://numbersapi.com/).  There are three ways to fetch facts, by date (MM/YY format), by day of the year (1-366) and randomly.  

## Demo

<p align="center">
  <img src="https://user-images.githubusercontent.com/72634901/172941119-302356e1-5648-457b-83df-c309fbe3fb57.gif" width="25%" height="25%"/>
</p>

## Getting Started as New Flutter Developer

[Install Flutter on OS](https://docs.flutter.dev/get-started/install)
The latest version of Xcode is recommended, note this is 10+ GB application and is a lengthly install. 

```
$ flutter doctor
```
If issues with `commandline` install: 
```
Android Studio > Preferences > Android SDK > SDK Tools > click on `Android SDK Command-line Tools(latest)` box.  
```
If issues with `cocoapods`, try: 
```
$ sudo gem install cocoapods
```

### Installing Dependencies

```
$ flutter pub get
```
```
$ flutter pub add http
```

### Running the Simulator/Emulator

IOS
```
Android Studio - Open IOS emulator 

OR

$ open -a Simulator
```
Android
```
Android Studio - Open Android emulator
```

## Future
1. Testing
2. Utilize NumbersAPI v2 when launched.
3. Add a calendar widget option to date search bar.
4. Add a multiple-choice quiz feature: 

>Q: What is the day that President of Pakistan Pervez Musharaf resigns due to the threat of impeachment?

>A: 12/02 B: 01/31 C: 02/24

