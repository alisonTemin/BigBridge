package services;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import excel.demo.HeartActivity;
import excel.demo.Person;

public class RandomHeartGenerator {

	private Random randomGenerator;
	int N = 0;

	public RandomHeartGenerator() {
		randomGenerator = new Random();
	}

	public List<HeartActivity> generateList(List<String> ids)
			throws ParseException {
		List<HeartActivity> items = new ArrayList<HeartActivity>();
		int percent = randomGenerator.nextInt((ids.size()/2)+1);

		for (int i = 0; i < percent; i++) {
			double caloriesOutOfRange = 0.0; // 30-98 
			int minutesOutOfRange = 0;
			
			double caloriesFat = 0.0; // 98-137
			int minutesFat = 0;
			
			double caloriesCardio = 0.0; // 137-167
			int minutesCardio = 0;
			
			double caloriesPeak = 0.0; //167-220
			int minutesPeak = 0;
			
			caloriesOutOfRange = randomGenerator.nextInt(200-(50+1)+50)*0.99;
			minutesOutOfRange = randomGenerator.nextInt(1000-(20+1)+20);
			caloriesFat = randomGenerator.nextInt(200-(50+1)+50)*0.99;
			minutesFat = randomGenerator.nextInt(300-(40+1)+40);
			
			HeartActivity ha = new HeartActivity();
			ha.setUserID(ids.get(i));
			ha.setCaloriesOutOfRange(caloriesOutOfRange);
			ha.setMinutesOutOfRange(minutesOutOfRange);
			ha.setCaloriesFat(caloriesFat);
			ha.setMinutesFat(minutesFat);
			ha.setMinutesPeak(minutesPeak);
			ha.setCaloriesPeak(caloriesPeak);
			ha.setMinutesCardio(minutesCardio);
			ha.setCaloriesCardio(caloriesCardio);
			
			items.add(ha);

		}

		for (int i = percent; i < ids.size(); i++) {
			double caloriesOutOfRange = 0.0; // 30-98 
			int minutesOutOfRange = 0;
			
			double caloriesFat = 0.0; // 98-137
			int minutesFat = 0;
			
			double caloriesCardio = 0.0; // 137-167
			int minutesCardio = 0;
			
			double caloriesPeak = 0.0; //167-220
			int minutesPeak = 0;
			
			caloriesOutOfRange = randomGenerator.nextInt(200-(50+1)+50)*0.99;
			minutesOutOfRange = randomGenerator.nextInt(1000-(20+1)+20);
			HeartActivity ha = new HeartActivity();
			ha.setUserID(ids.get(i));
			ha.setCaloriesOutOfRange(caloriesOutOfRange);
			ha.setMinutesOutOfRange(minutesOutOfRange);
			ha.setCaloriesFat(caloriesFat);
			ha.setMinutesFat(minutesFat);
			ha.setMinutesPeak(minutesPeak);
			ha.setCaloriesPeak(caloriesPeak);
			ha.setMinutesCardio(minutesCardio);
			ha.setCaloriesCardio(caloriesCardio);
			
			items.add(ha);
		}
		return items;
	}

}
