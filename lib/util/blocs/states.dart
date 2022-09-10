abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetCurrentWeatherLoading extends AppStates {}

class GetCurrentWeatherSuccess extends AppStates {}

class DatabaseInitialized extends AppStates {}

class DatabaseOpened extends AppStates {}

class DatabaseWeather extends AppStates {}

class DatabaseInserted extends AppStates {}

class UpdateCityName extends AppStates {}

// class GetCurrentWeather0Success extends AppStates {}