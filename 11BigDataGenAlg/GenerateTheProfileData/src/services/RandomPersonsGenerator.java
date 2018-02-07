package services;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import excel.demo.Person;

public class RandomPersonsGenerator {

	private Random randomGenerator;
	final String alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	int N = 0;

	public RandomPersonsGenerator() {
		randomGenerator = new Random();
	}

	public List<Person> generateList(int numberOfPersons, List<String> fn, List<String> mn, List<String> ln)
			throws ParseException {
		List<Person> persons = new ArrayList<Person>();

		N = alphabet.length();

		for (int i = 0; i < numberOfPersons; i++) {
			String gender = "";
			String name = "";
			String surname = "";
			String userID = "";
			String smoking="";
			String drinking="";
			int maxHeight = 200;
			int minHeight = 160;
			int index = 0;
			// generate a gender
			int x = (Math.random() < 0.5) ? 0 : 1;
			// generate the info about bad habits
			int y = (Math.random() < 0.5) ? 0 : 1;
			int z = (Math.random() < 0.5) ? 0 : 1;
			switch (y){
			case 0: smoking = "No"; break;
			case 1: smoking = "Yes"; break;
			}
			switch (z){
			case 0: drinking = "No"; break;
			case 1: drinking = "Yes"; break;
			}
			// generating an unique user id
			for (int j = 0; j < 8; j++) {
				userID += alphabet.charAt(randomGenerator.nextInt(N));
			}
			// generating a date of birth
			RandomDateOfBirth dateGenerator = new RandomDateOfBirth();
			Date dateOfBirth = dateGenerator.generate();
			LocalDate ld = new java.sql.Date(dateOfBirth.getTime()).toLocalDate();
			LocalDate currentDate = LocalDate.now();
			// calculating the age
			int age = dateGenerator.calculateAge(ld, currentDate);
			// random the height
			int height = randomGenerator.nextInt((maxHeight - minHeight) + 1) + minHeight;
			int normalWeight = 0;

			// generating a full name
			switch (x) {
			case 0:
				gender = "FEMALE";
				index = randomGenerator.nextInt(fn.size());
				name = fn.get(index);
				normalWeight = height - 110;
				break;
			case 1:
				gender = "MALE";
				index = randomGenerator.nextInt(mn.size());
				name = mn.get(index);
				normalWeight = height - 100;
				break;

			}
			// random the weight

			int weight = randomGenerator.nextInt(((normalWeight+30) - (normalWeight-20)) + 1) + (normalWeight-20);
			index = randomGenerator.nextInt(ln.size());
			surname = ln.get(index);

			Person p = new Person();
			p.setGender(gender);
			p.setFullName(name.trim() + " " + surname.trim());
			p.setUserID(userID);
			p.setDateOfBirth(dateOfBirth);
			p.setAge(age);
			p.setHeight(height);
			p.setWeight(weight);
			p.setSmoking(smoking);
			p.setDrinking(drinking);
			persons.add(p);
		}

		return persons;
	}

}
