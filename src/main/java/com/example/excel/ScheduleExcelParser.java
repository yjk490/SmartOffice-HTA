package com.example.excel;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;

/**
 * 엑셀문서를 읽어서 {@code List<Map<String, Object>>} 객체로 반환한다.
 * 
 * getExcelData(byte[] bytes)는 업로드된 엑셀파일의 바이너리 데이터를 전달받아서 분석하고 List<Map<String, Object>>객체로 반환한다.
 * <pre>
 * 	[
		{할인가격=2250.0, 상품이름=공책, 제조회사=모나미, 가격=2500.0, 입고수량=100.0},
		{할인가격=750.0, 상품이름=지우개, 제조회사=모나미, 가격=750.0, 입고수량=50.0}, 
		{할인가격=750.0, 상품이름=연필, 제조회사=알앤비, 가격=750.0, 입고수량=100.0}, 
		{할인가격=1150.0, 상품이름=샤프심, 제조회사=핑크풋, 가격=1250.0, 입고수량=100.0}, 
		{할인가격=6300.0, 상품이름=샤프, 제조회사=금홍팬시, 가격=6500.0, 입고수량=50.0}, 
		{할인가격=5200.0, 상품이름=3색볼펜, 제조회사=매직하우스, 가격=5500.0, 입고수량=50.0}
	]
 * </pre>
 */
@Component
public class ScheduleExcelParser {

	public List<Map<String, Object>> getExcelData(byte[] bytes) throws IOException {
		// 엑셀문서의 데이터를 분석해서 List<Map<String, Object>> 객체에 저장시킨다.
		// Map<String, Object>는 엑셀문서의 한 행 정보를 저장한다.
		// Map<String, Object>는 {name:value, name:value, name:value, ...}
		List<Map<String, Object>> dataList = new ArrayList<>();
		
		// Workbook은 엑셀문서를 표현하는 객체다.
		// new XSSFWorkbook(new ByteArrayInputStream(bytes))는 전달받은 bytes데이터를 읽어오는 스트림을 이용해서 엑셀문서객체를 생성한다.
		Workbook workbook = new XSSFWorkbook(new ByteArrayInputStream(bytes));
		// 엑셀문서의 첫번째 시트를 조회한다.
		Sheet sheet = workbook.getSheetAt(0);
		
		// 엑셀문서의 컬럼명을 저장하는 List<String>객체를 생성한다.
		List<String> headerNames = new ArrayList<>();
		// 시트의 첫번째 행을 조회한다.
		Row headerRow = sheet.getRow(0);
		// 첫번째 행의 0번째 셀부터 마지막셀까지 값을 조회해서 List<String>객체에 저장한다.
		for (int cellIndex = 0; cellIndex < headerRow.getLastCellNum(); cellIndex++) {
			headerNames.add(headerRow.getCell(cellIndex).getStringCellValue());
		}		
		
		// 엑셀문서의 데이터부분의 조회한다.
		for (int rowIndex = 1; rowIndex < sheet.getLastRowNum(); rowIndex++) {
			// 엑셀문서의 시트에서 데이터가 저장된 행을 조회한다.
			Row row = sheet.getRow(rowIndex);
			
			// 데이터를 저장하는 Map<String, Object> 객체를 생성한다.
			Map<String, Object> data = new HashMap<>();
			
			// 50번째 라인에서 조회된 행의 0번째 셀부터 마지막번째 셀까지 값을 조회해서 Map<String, Object>객체에 저장한다.
			for (int cellIndex = 0; cellIndex < row.getLastCellNum(); cellIndex++) {
				// 셀을 조회한다. 
				Cell cell = row.getCell(cellIndex);
				// 셀에 저장된 데이터타입을 조회한다.
				CellType cellType = cell.getCellType();
				
				if (cellType == CellType.STRING) {
					data.put(headerNames.get(cellIndex), cell.getStringCellValue());
				} else if (cellType == CellType.NUMERIC) {
					if (DateUtil.isCellDateFormatted(cell)) {
						data.put(headerNames.get(cellIndex), cell.getDateCellValue());
					} else {
						data.put(headerNames.get(cellIndex), cell.getNumericCellValue());
					}
				} else if (cellType == CellType.BOOLEAN) {
					data.put(headerNames.get(cellIndex), cell.getBooleanCellValue());
				} else if (cellType == CellType.BLANK) {
					data.put(headerNames.get(cellIndex), null);
				}
			}
			
			dataList.add(data);
		}	
		workbook.close();
		return dataList;
	}
}
