package services;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Random;

public class RandomDateOfBirth {
	
	public RandomDateOfBirth(){
		
	}

    public Date generate() throws ParseException {
    	
    	Random rnd = new Random();

    	// Get an Epoch value roughly between 1940 and 2010
    	// -946771200000L = January 1, 1940
    	// Add up to 70 years to it (using modulus on the next long)
    	long ms = -946771200000L + (Math.abs(rnd.nextLong()) % (70L * 365 * 24 * 60 * 60 * 1000));

    	// Construct a date
    	Date dt = new Date(ms);
    	
        return dt;

    }
    
    public static int calculateAge(LocalDate birthDate, LocalDate currentDate) {
        if ((birthDate != null) && (currentDate != null)) {
            return Period.between(birthDate, currentDate).getYears();
        } else {
            return 0;
        }
    }
    public static int randBetween(int start, int end) {
        return start + (int)Math.round(Math.random() * (end - start));
    }
}
