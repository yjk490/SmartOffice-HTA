package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContextException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.mapper.AddressbookMapper;
import com.example.mapper.ContactMapper;
import com.example.vo.contact.Addressbook;
import com.example.vo.contact.Contact;
import com.example.vo.contact.ContactTag;
import com.example.vo.contact.ContactTel;
import com.example.web.request.ContactRegisterForm;

@Service
@Transactional
public class ContactService {
	
	@Autowired
	private AddressbookMapper addressbookMapper;
	@Autowired
	private ContactMapper contactMapper;
	
	// 주소록(태그) 등록
	public void insertAddressbook(String type, String addressbookName ) {
		Addressbook addbook = addressbookMapper.getAddressbookByName(addressbookName);
		if(addbook != null) {
			throw new ApplicationContextException("동일한 이름의 태그가 존재합니다.");
		}
		
		Addressbook newBook = new Addressbook();
		newBook.setType(type);
		newBook.setAddressbookName(addressbookName);
		addressbookMapper.insertAddressbook(newBook);
	}
	
	// 연락처 등록
	public void insertContact(ContactRegisterForm form) {
		// Contacts 테이블에 연락처 저장
		Contact contact = new Contact();
		BeanUtils.copyProperties(form, contact);
		contactMapper.insertContact(contact);
		
		// Contact_Tels 테이블에 전화번호 목록 저장
		if(form.getContactTels() != null) {
			List<String> tels = form.getContactTels();
			for(String telcon : tels) {
				ContactTel tel = new ContactTel(contact.getContactNo(), telcon);
				contactMapper.insertContactTel(tel);
			}
		}
		
		// Contact_Tags 테이블에 태그 저장 (주소록 태그와의 연결)
		List<Integer> tags = form.getAddressbookNos();
		for(int tagcon : tags) {
			ContactTag tag = new ContactTag(tagcon, contact.getContactNo());
			contactMapper.insertContactTag(tag);
		}
	}
	
	// 공유주소록 목록, 총 개체수 조회
	public Map<String, Object> getPublicAddressbooks() {
		int totalRows = contactMapper.getPublicRows();
		
		List<Addressbook> publicAddressbooks = addressbookMapper.getAddressbooks("public");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("publicAddressbooks", publicAddressbooks);
		result.put("publicTotalRows", totalRows);
		
		return result;
	}
	
	// 개인주소록 목록, 총 개체수 조회
		public Map<String, Object> getPrivateAddressbooks() {
			int totalRows = contactMapper.getPrivateRows();
			
			List<Addressbook> privateAddressbooks = addressbookMapper.getAddressbooks("private");
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("privateAddressbooks", privateAddressbooks);
			result.put("privateTotalRows", totalRows);
			
			return result;
		}

}
