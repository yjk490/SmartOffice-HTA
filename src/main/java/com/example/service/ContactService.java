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
import com.example.web.request.AddressbookModifyForm;
import com.example.web.request.ContactRegisterForm;

@Service
@Transactional
public class ContactService {
	
	@Autowired
	private AddressbookMapper addressbookMapper;
	@Autowired
	private ContactMapper contactMapper;
	
	// 주소록(태그) 등록
	public void insertAddressbook(String type, String addressbookName) {
		Addressbook addbook = addressbookMapper.getAddressbookByName(type, addressbookName);
		if(addbook != null) {
			throw new ApplicationContextException("동일한 이름의 태그가 존재합니다.");
		}
		
		Addressbook newBook = new Addressbook();
		newBook.setType(type);
		newBook.setAddressbookName(addressbookName);
		addressbookMapper.insertAddressbook(newBook);
	}
	
	// 주소록(태그) 조회
	public Addressbook getAddressbookByNo(int addressbookNo) {
		Addressbook adrbook = addressbookMapper.getAddressbookByNo(addressbookNo);
		
		return adrbook;
	}
	
	// 주소록(태그) 수정
	public void modifyAddressbook(AddressbookModifyForm addressbookModifyForm) {
		Addressbook adrbook = addressbookMapper.getAddressbookByNo(addressbookModifyForm.getAddressbookNo());
		BeanUtils.copyProperties(addressbookModifyForm, adrbook);
		
		addressbookMapper.updateAddressbook(adrbook);
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
			for(String telcontent : tels) {
				ContactTel tel = new ContactTel();
				tel.setContactNo(contact.getContactNo());
				tel.setContactTel(telcontent);
				contactMapper.insertContactTel(tel);
				}
			}
		
		// Contact_Tags 테이블에 태그 저장 (주소록 태그와의 연결)
		
		List<String> tags = form.getContactTags();
			for(String tagContent : tags) {
				Addressbook addressbook = addressbookMapper.getAddressbookByName2(tagContent);
				if(addressbook != null) {
					ContactTag tag = new ContactTag();
					tag.setAddressbookNo(addressbook.getAddressbookNo());
					tag.setContactNo(contact.getContactNo());
					contactMapper.insertContactTag(tag);
				}
			}
	}
	
	// 공유주소록 목록 조회
	public List<Addressbook> getPublicAddressbooks() {
		return addressbookMapper.getAddressbooks("public");
	}
	
	// 개인주소록 목록 조회
	public List<Addressbook> getPrivateAddressbooks() {	
		return addressbookMapper.getAddressbooks("private");
	}

	// 주소록 태그 삭제
	public void deleteAddressbook(int addressbookNo) {
		Addressbook adrbook = addressbookMapper.getAddressbookByNo(addressbookNo);
		
		adrbook.setDeleted("Y");
		addressbookMapper.updateAddressbook(adrbook);
		
	}

	



}
