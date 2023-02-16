package com.example.web.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddressbookModifyForm {
	
	private int addressbookNo;
	private String type;
	private String addressbookName;
	private String deleted;

}
