package services;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelReader {

	public ExcelReader(){
		
	}
	
	public List<String> readListFromExcel (String excelFilePath) throws IOException{
		List <String> listItems = new ArrayList <String> ();
		FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
		Workbook workbook = new XSSFWorkbook(inputStream);
		Sheet firstSheet = workbook.getSheetAt(0);
		Iterator<Row> iterator = firstSheet.iterator();

		while (iterator.hasNext()) {

			Row nextRow = iterator.next();
			// System.out.println(nextRow.getRowNum());
			Iterator<Cell> cellIterator = nextRow.cellIterator();
			String item="";
			if (nextRow.getRowNum() > 0) {
				while (cellIterator.hasNext()) {
					/*if (nextRow.getRowNum() == 0) {
						Cell nextCell = cellIterator.next();
					}*/
					Cell nextCell = cellIterator.next();
					int columnIndex = nextCell.getColumnIndex();

					switch (columnIndex) {
					case 0:
						item = ((String) getCellValue(nextCell)).trim();
						break;
					}				}
				
				listItems.add(item);
			}
		}
		inputStream.close();

		return listItems;
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

