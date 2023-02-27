package com.example.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm");	//hh는 12시간 kk는 24시간
	private static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	
	public static Date textToDate(String date) {
		return textToDate(date, "00:00");
	}

	public static Date dateToDate(Date date) {
		return dateToDate(date, "00:00");
	}
	
	public static Date dateToDate(Date date, String time) {
		try {
			if(time== null) {
				return date;
			}
			String strDate = sdf2.format(date);
			return sdf.parse(strDate + " " + time);
			
		} catch (ParseException ex) {
			throw new RuntimeException(ex);
		}
		
		 
	}
	
	public static Date textToDate(String date, String time) {
		try {
			if (time == null) {
				return sdf.parse(date + " 00:00");
			}
			return sdf.parse(date + " " + time);
		} catch (ParseException ex) {
			throw new RuntimeException(ex);
		}
	}
}