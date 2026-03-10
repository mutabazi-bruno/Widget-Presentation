

# FilterChip Widget Demo

A Flutter app demonstrating the use of the FilterChip widget to filter meals by dietary tags.

## How to Run

1. Clone the repository:
	```
	git clone https://github.com/mutabazi-bruno/Widget-Presentation.git
	```
2. Navigate to the project directory:
	```
	cd Widget-Presentation/chip
	```
3. Install dependencies:
	```
	flutter pub get
	```
4. Start the app:
	```
	flutter run
	```

## Widget Description

This demo shows how FilterChip widgets can be used to filter a meal list by diet type.


## Three Key Attributes

- **label**: Sets the text displayed on each chip (e.g., "Vegetarian", "Vegan").
- **selected**: Indicates whether the chip is active; selected chips filter the meal list.
- **onSelected**: Callback triggered when a chip is tapped, updating the filter state.

## Screenshots

![Main UI](screenshot1.png)
![Filter Chips Vegan](screenshot2.png)
![Filter Chips Vegan and Gluten-free](screenshot3.png)
![Filter Chips that Doesn't meet any food available](screenshot4.png)

