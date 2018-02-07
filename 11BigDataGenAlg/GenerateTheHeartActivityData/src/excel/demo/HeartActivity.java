package excel.demo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class HeartActivity {

	private String userID;
	private Date dateTime;
	private int minOutOfRange;
	private int maxOutOfRange;

	private double caloriesOutOfRange; // 30-98
	private int minutesOutOfRange;

	private int minFat;
	private int maxFat;

	private double caloriesFat; // 98-137
	private int minutesFat;

	private int minCardio;
	private int maxCardio;

	private double caloriesCardio; // 137-167
	private int minutesCardio;

	private int minPeak;
	private int maxPeak;

	private double caloriesPeak; // 167-220
	private int minutesPeak;

	public HeartActivity() {
		this.minOutOfRange = 30;
		this.maxOutOfRange = 98;
		this.minFat = 98;
		this.maxFat = 137;
		this.minCardio = 137;
		this.maxCardio = 167;
		this.minPeak = 167;
		this.maxPeak = 220;
	
		try {
			this.dateTime = new SimpleDateFormat( "yyyy-MM-dd" ).parse( "2017-08-11" );
		} catch (ParseException e) {
			e.printStackTrace();
		} 		
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public double getCaloriesOutOfRange() {
		return caloriesOutOfRange;
	}

	public void setCaloriesOutOfRange(double caloriesOutOfRange) {
		this.caloriesOutOfRange = caloriesOutOfRange;
	}

	public int getMinutesOutOfRange() {
		return minutesOutOfRange;
	}

	public void setMinutesOutOfRange(int minutesOutOfRange) {
		this.minutesOutOfRange = minutesOutOfRange;
	}

	public double getCaloriesFat() {
		return caloriesFat;
	}

	public void setCaloriesFat(double caloriesFat) {
		this.caloriesFat = caloriesFat;
	}

	public int getMinutesFat() {
		return minutesFat;
	}

	public void setMinutesFat(int minutesFat) {
		this.minutesFat = minutesFat;
	}

	public double getCaloriesCardio() {
		return caloriesCardio;
	}

	public void setCaloriesCardio(double caloriesCardio) {
		this.caloriesCardio = caloriesCardio;
	}

	public int getMinutesCardio() {
		return minutesCardio;
	}

	public void setMinutesCardio(int minutesCardio) {
		this.minutesCardio = minutesCardio;
	}

	public double getCaloriesPeak() {
		return caloriesPeak;
	}

	public void setCaloriesPeak(double caloriesPeak) {
		this.caloriesPeak = caloriesPeak;
	}

	public int getMinutesPeak() {
		return minutesPeak;
	}

	public void setMinutesPeak(int minutesPeak) {
		this.minutesPeak = minutesPeak;
	}

	public Date getDateTime() {
		return dateTime;
	}

	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}

	public int getMinOutOfRange() {
		return minOutOfRange;
	}

	public void setMinOutOfRange(int minOutOfRange) {
		this.minOutOfRange = minOutOfRange;
	}

	public int getMaxOutOfRange() {
		return maxOutOfRange;
	}

	public void setMaxOutOfRange(int maxOutOfRange) {
		this.maxOutOfRange = maxOutOfRange;
	}

	public int getMinFat() {
		return minFat;
	}

	public void setMinFat(int minFat) {
		this.minFat = minFat;
	}

	public int getMaxFat() {
		return maxFat;
	}

	public void setMaxFat(int maxFat) {
		this.maxFat = maxFat;
	}

	public int getMinCardio() {
		return minCardio;
	}

	public void setMinCardio(int minCardio) {
		this.minCardio = minCardio;
	}

	public int getMaxCardio() {
		return maxCardio;
	}

	public void setMaxCardio(int maxCardio) {
		this.maxCardio = maxCardio;
	}

	public int getMinPeak() {
		return minPeak;
	}

	public void setMinPeak(int minPeak) {
		this.minPeak = minPeak;
	}

	public int getMaxPeak() {
		return maxPeak;
	}

	public void setMaxPeak(int maxPeak) {
		this.maxPeak = maxPeak;
	}

}
