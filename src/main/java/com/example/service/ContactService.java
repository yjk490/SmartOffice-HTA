package com.example.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContextException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dto.contact.ContactListDto;
import com.example.mapper.AddressbookMapper;
import com.example.mapper.ContactMapper;
import com.example.utils.Pagination;
import com.example.vo.contact.Addressbook;
import com.example.vo.contact.Contact;
import com.example.vo.contact.ContactTag;
import com.example.vo.contact.ContactTel;
import com.example.web.request.AddressbookModifyForm;
import com.example.web.request.ContactRegisterForm;
import com.example.web.request.ContactSearchOption;

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
	
	// 초성값이 들어오면 초성번호 ~ 초성번호+1 사이를 검색하는 SQL문을 작성한다
	// initial값에 따라 변화하는 SQL문을 작성했다. 이걸 어떻게 Mapper에 넣을 수 있을까?
	public String getinitial(String initial) {
		Map<Integer, String> index_map = new HashMap<>();

		index_map.put(0, "가");  index_map.put(1, "나");  index_map.put(2, "다");  
		index_map.put(3, "라");  index_map.put(4, "마");  index_map.put(5, "바");
		index_map.put(6, "사");  index_map.put(7, "아");  index_map.put(8, "자");  
		index_map.put(9, "차");  index_map.put(10, "카");  index_map.put(11, "타");
		index_map.put(12, "파");  index_map.put(13, "하"); index_map.put(14, "힣");
		index_map.put(15, "A"); index_map.put(16, "Z"); index_map.put(17, "0");
		index_map.put(18, "01099999999");
		
		String index = initial;
		int num = 0;
		String whereSQL = "";

		for( int i = 0; i < index_map.size(); i++ ) {
		    if( index.equals(index_map.get(i)) ) {
		        num = i;
		        break;
		    }
		}

		whereSQL = "contact_name between'" + index_map.get(num) + "' and '" + index_map.get(num+1) + "' ";
		return whereSQL;
	}

	// 검색 결과를 적용한 연락처 목록 조회
	public Map<String, Object> getContacts(int page, ContactSearchOption opt) {
		
		if(opt.getType() == "public") {
			int rows = contactMapper.getPublicRows(opt.getKeyword(), opt.getInitial(), opt.getTag());
			Pagination pagination = new Pagination(page, rows);
					
			Map<String, Object> Param = new HashMap<String, Object>();
			Param.put("begin", pagination.getBegin());
			Param.put("end", pagination.getEnd());
			
			List<ContactListDto> contacts = contactMapper.getContacts(pagination.getBegin(), pagination.getEnd(), opt.getSort(), opt.getType(), opt.getKeyword());
			
			Map<String, Object> result = new HashMap<>();
			result.put("Contacts", contacts);
			result.put("Pagination", pagination);
			
			return result;
		} else {
			int rows = contactMapper.getPrivateRows(opt.getKeyword(), opt.getInitial(), opt.getTag());
			Pagination pagination = new Pagination(page, rows);
			
			Map<String, Object> Param = new HashMap<String, Object>();
			Param.put("begin", pagination.getBegin());
			Param.put("end", pagination.getEnd());
			
			List<ContactListDto> contacts = contactMapper.getContacts(pagination.getBegin(), pagination.getEnd(), opt.getSort(), opt.getType(), opt.getKeyword());
			
			Map<String, Object> result = new HashMap<>();
			result.put("Contacts", contacts);
			result.put("Pagination", pagination);
			
			return result;
		}
	}

}
