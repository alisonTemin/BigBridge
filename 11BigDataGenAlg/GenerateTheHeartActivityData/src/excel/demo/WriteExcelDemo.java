package excel.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import services.RandomHeartGenerator;
import services.RandomPersonsGenerator;

//import statements
public class WriteExcelDemo

{
	public static String excelFilePath = "E:/UNICE/TPT_BIGDATASANTE/random/highRiskPersons.xlsx";
	public static String excelFilePath1 = "E:/UNICE/TPT_BIGDATASANTE/random/heartActivityForHighRisk.xlsx";

	public static RandomHeartGenerator generator;

	public static void main(String[] args) throws FileNotFoundException, IOException {
		List<String> listItems = new ArrayList<String>();
		FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
		Workbook workbook = new XSSFWorkbook(inputStream);
		Sheet firstSheet = workbook.getSheetAt(0);
		Iterator<Row> iterator = firstSheet.iterator();
		generator = new RandomHeartGenerator();
		while (iterator.hasNext()) {

			Row nextRow = iterator.next();
			// System.out.println(nextRow.getRowNum());
			Iterator<Cell> cellIterator = nextRow.cellIterator();
			String item = "";
			if (nextRow.getRowNum() > 0) {
				while (cellIterator.hasNext()) {
					/*
					 * if (nextRow.getRowNum() == 0) { Cell nextCell =
					 * cellIterator.next(); }
					 */
					Cell nextCell = cellIterator.next();
					int columnIndex = nextCell.getColumnIndex();

					switch (columnIndex) {
					case 0:
						item = ((String) getCellValue(nextCell)).trim();
						break;
					}
				}

				listItems.add(item);
			}
		}
		inputStream.close();
		System.out.println(listItems.size());

		try {
			List<HeartActivity> list = generator.generateList(listItems);
			System.out.println(list.size());

			workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet();
			CellStyle cellStyle = workbook.createCellStyle();
			CreationHelper createHelper = workbook.getCreationHelper();
			cellStyle.setDataFormat(createHelper.createDataFormat().getFormat("YYYY-MM-DD"));
			int rowCount = -1;

			for (HeartActivity ha : list) {
				Row row = sheet.createRow(++rowCount);
				Cell cell = row.createCell(0);
				cell.setCellValue(ha.getUserID());
				cell = row.createCell(1);
				cell.setCellStyle(cellStyle);
				cell.setCellValue(ha.getDateTime());
				cell = row.createCell(2);
				cell.setCellValue(ha.getCaloriesOutOfRange());
				cell = row.createCell(3);
				cell.setCellValue(ha.getMaxOutOfRange());
				cell = row.createCell(4);
				cell.setCellValue(ha.getMinOutOfRange());
				cell = row.createCell(5);
				cell.setCellValue(ha.getMinutesOutOfRange());
				
				cell = row.createCell(6);
				cell.setCellValue(ha.getCaloriesFat());
				cell = row.createCell(7);
				cell.setCellValue(ha.getMaxFat());
				cell = row.createCell(8);
				cell.setCellValue(ha.getMinFat());
				cell = row.createCell(9);
				cell.setCellValue(ha.getMinutesFat());
				
				cell = row.createCell(10);
				cell.setCellValue(ha.getCaloriesCardio());
				cell = row.createCell(11);
				cell.setCellValue(ha.getMaxCardio());
				cell = row.createCell(12);
				cell.setCellValue(ha.getMinCardio());
				cell = row.createCell(13);
				cell.setCellValue(ha.getMinutesCardio());
				
				cell = row.createCell(14);
				cell.setCellValue(ha.getCaloriesPeak());
				cell = row.createCell(15);
				cell.setCellValue(ha.getMaxPeak());
				cell = row.createCell(16);
				cell.setCellValue(ha.getMinPeak());
				cell = row.createCell(17);
				cell.setCellValue(ha.getMinutesPeak());
		
				
			}

			try (FileOutputStream outputStream = new FileOutputStream(excelFilePath1)) {
				workbook.write(outputStream);
				System.out.println("done");
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

	}

	private static Object getCellValue(Cell cell) {
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			return cell.getStringCellValue();

		case Cell.CELL_TYPE_NUMERIC:

			return cell.getNumericCellValue();
		}
		return null;
	}

}
