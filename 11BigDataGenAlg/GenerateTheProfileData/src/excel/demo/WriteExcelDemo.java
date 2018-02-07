package excel.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TreeMap;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.util.SystemOutLogger;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import services.ExcelReader;
import services.RandomPersonsGenerator;

//import statements
public class WriteExcelDemo

{
	static List<Person> persons;
	static List<String> femaleNames;
	static List<String> maleNames;
	static List<String> lastNames;
	static int numberOfPersons =10000;

	static int sizeRow;
	static int sizeCol;

	public static void main(String[] args) throws FileNotFoundException, IOException {
		String excelFilePath1 = "E:/UNICE/TPT_BIGDATASANTE/random/persons.xlsx";
		String fPath = "E:/UNICE/TPT_BIGDATASANTE/random/femaleNames.xlsx";
		String mPath = "E:/UNICE/TPT_BIGDATASANTE/random/maleNames.xlsx";
		String lPath = "E:/UNICE/TPT_BIGDATASANTE/random/lastNames.xlsx";

		String excelFilePath2 = "F:/randomData/persons.xlsx";
		ExcelReader reader = new ExcelReader();
		RandomPersonsGenerator namesGenerator= new RandomPersonsGenerator();
		persons = new ArrayList<Person>();
		femaleNames = new ArrayList<String>();
		maleNames = new ArrayList<String>();
		lastNames = new ArrayList<String>();

		try {
		//	persons = readNamesFromExcelFile(excelFilePath);
			femaleNames = reader.readListFromExcel(fPath);
			maleNames = reader.readListFromExcel(mPath);
			lastNames = reader.readListFromExcel(lPath);


		} catch (IOException e) {

			e.printStackTrace();
		}
		
		try {
			persons = namesGenerator.generateList(numberOfPersons, femaleNames, maleNames, lastNames);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		System.out.println(persons.size());
		
		  Workbook workbook = new XSSFWorkbook();
		    Sheet sheet = workbook.createSheet();
		    CellStyle cellStyle = workbook.createCellStyle();
		    CreationHelper createHelper = workbook.getCreationHelper();
		    cellStyle.setDataFormat(
		        createHelper.createDataFormat().getFormat("YYYY-MM-DD"));
		    int rowCount = -1;

		    
	        	for (Person person: persons){
	        Row row = sheet.createRow(++rowCount);
	        Cell cell = row.createCell(0);
	        cell.setCellValue(person.getUserID());
	        cell = row.createCell(1);
	        cell.setCellValue(String.valueOf(person.getWeight()));
	        cell = row.createCell(2);
	        cell.setCellValue(String.valueOf(person.getHeight()));
	        cell = row.createCell(3);
	        cell.setCellValue(person.getAge());
	        cell = row.createCell(4);
	       cell.setCellStyle(cellStyle);
	        cell.setCellValue(person.getDateOfBirth());
	        cell = row.createCell(5);
	        cell.setCellValue(person.getFullName());
	        cell = row.createCell(6);
	        cell.setCellValue(person.getGender());
	        cell = row.createCell(7);
	        cell.setCellValue(person.getSmoking());
	        cell = row.createCell(8);
	        cell.setCellValue(person.getDrinking());     
		    
	        	}

		    try (FileOutputStream outputStream = new FileOutputStream(excelFilePath1)) {
		       workbook.write(outputStream);
		       System.out.println("done");
		    }
		    
		   

		//System.out.println(persons.size());

	}

	/*
	 * private static void writeItem(Item aItem, Date date, Row row, CellStyle
	 * cellStyle) { Cell cell = row.createCell(0);
	 * cell.setCellValue(aItem.getStation());
	 * 
	 * cell = row.createCell(1); cell.setCellValue(aItem.getPolluant());
	 * 
	 * cell = row.createCell(2); cell.setCellValue(aItem.getMesure());
	 * 
	 * cell = row.createCell(3); cell.setCellValue(aItem.getUnite());
	 * 
	 * cell = row.createCell(4);
	 * 
	 * cell.setCellValue(date); // cell.setCellStyle(cellStyle);; }
	 */

	
}
