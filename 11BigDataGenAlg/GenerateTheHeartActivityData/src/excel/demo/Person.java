package excel.demo;

import java.util.Date;

public class Person {

	private String userID;
	private int weight;
	private int height;
	private int age;
	private Date dateOfBirth;
	private String fullName;
	private String gender;
	private String smoking;
	private String drinking;

	public Person() {

	}

	public Person(String userID, int weight, int height, int age, Date dateOfBirth, String fullName, String gender,
			String smoking, String drinking) {
		super();
		this.userID = userID;
		this.weight = weight;
		this.height = height;
		this.age = age;
		this.dateOfBirth = dateOfBirth;
		this.fullName = fullName;
		this.gender = gender;
		this.smoking = smoking;
		this.drinking = drinking;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getSmoking() {
		return smoking;
	}

	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}

	public String getDrinking() {
		return drinking;
	}

	public void setDrinking(String drinking) {
		this.drinking = drinking;
	}

}
