package com.example.web.response;

import java.util.List;

import com.example.dto.contact.ContactListDto;
import com.example.utils.Pagination;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ContactListResult {
	
	private Pagination pagination;
	private List<ContactListDto> contacts;

}
