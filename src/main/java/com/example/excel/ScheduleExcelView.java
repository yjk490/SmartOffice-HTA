package com.example.excel;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

/**
 * 데이터, 값의 키, 엑셀문서 헤더의 컬럼명, 컬럼 길이, 파일명이 포함된 {@code Map<String, Object>} 객체를 전달받아서 엑셀문서로 변환해서 응답으로 제공한다.
 *
 */
@Component("excelView")
public class ScheduleExcelView extends AbstractXlsxView {

	@Override
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<Map<String, Object>> items = (List<Map<String,Object>>) model.get("items");
		List<String> keys = (List<String>) model.get("keys");
		List<String> headers = (List<String>) model.get("headers");
		List<Integer> widths = (List<Integer>) model.get("widths");
		String filename = (String) model.get("filename");
		
		response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename, "utf-8"));

		Sheet sheet = workbook.createSheet("시트1");
		CellStyle headerCellStyle = getHeaderCellStyle(workbook);
		CellStyle bodyCellStyle = getBodyCellStyle(workbook);
		
		int columnIndex = 0;
		for (int width : widths) {
			sheet.setColumnWidth(columnIndex++, width*256);
		}
		
		int rowIndex = 0;
		int cellSize = headers.size();
		
		Row headerRow = sheet.createRow(rowIndex++);
		for (int cellIndex = 0; cellIndex < cellSize; cellIndex++) {
			Cell cell= headerRow.createCell(cellIndex);
			cell.setCellStyle(headerCellStyle);
			cell.setCellValue(headers.get(cellIndex));
		}
		
		for (Map<String, Object> item : items) {
			Row dataRow = sheet.createRow(rowIndex);
			for (int cellIndex = 0; cellIndex < cellSize; cellIndex++){
				Cell dataCell = dataRow.createCell(cellIndex);
				dataCell.setCellStyle(bodyCellStyle);
				
				Object value = item.get(keys.get(cellIndex));
				if (value == null) {
					dataCell.setCellValue("");
					continue;
				}
				if (value instanceof String) {
					dataCell.setCellValue((String) value);
				} else if (value instanceof Date) {
					dataCell.setCellValue((Date) value);
				} else if (value instanceof Integer) {
					dataCell.setCellValue((Integer) value);
				} else if (value instanceof Long) {
					dataCell.setCellValue((Long) value);
				} else if (value instanceof Double) {
					dataCell.setCellValue((Double) value);
				} else {
					dataCell.setCellValue(value.toString());
				}
			}
			rowIndex++;
		}
	}
	
	private CellStyle getHeaderCellStyle(Workbook workbook) {
		CellStyle headerCellStyle = workbook.createCellStyle();
		headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
		headerCellStyle.setBorderTop(BorderStyle.THIN);
		headerCellStyle.setBorderBottom(BorderStyle.THIN);
		headerCellStyle.setBorderLeft(BorderStyle.THIN);
		headerCellStyle.setBorderRight(BorderStyle.THIN);
		headerCellStyle.setWrapText(true);
		
		return headerCellStyle;
	}
	
	private CellStyle getBodyCellStyle(Workbook workbook) {
		CellStyle bodyCellStyle = workbook.createCellStyle();
		bodyCellStyle.setBorderTop(BorderStyle.THIN);
		bodyCellStyle.setBorderBottom(BorderStyle.THIN);
		bodyCellStyle.setBorderLeft(BorderStyle.THIN);
		bodyCellStyle.setBorderRight(BorderStyle.THIN);
		bodyCellStyle.setWrapText(true);
		
		return bodyCellStyle;
	}
	
}
