package com.example.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class DateTimeToString {

	public static String LocalDateTimeToString(LocalDateTime createdDateTime) {
		LocalDateTime now = LocalDateTime.now();
		String createdDateTimeToString = "";
		
		long diffHours = ChronoUnit.HOURS.between(createdDateTime, now);
		long diffMinutes = ChronoUnit.MINUTES.between(createdDateTime, now);
		if (diffMinutes == 0) {
			createdDateTimeToString = "방금 전";
		} else if (diffMinutes < 60)	{
			createdDateTimeToString = diffMinutes + "분 전";
		} else if (diffHours < 12) {
			createdDateTimeToString = "약 " + diffHours + "시간 전";
		} else {
			String date = createdDateTime.format(DateTimeFormatter.ofPattern("yyyy. MM. dd."));
			createdDateTimeToString = date;
		}
		
		return createdDateTimeToString;
	}
}
