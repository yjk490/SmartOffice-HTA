package com.example.web.view;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class FileDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		File file = (File) model.get("file");
		
		// application/octet-stream : 일반적인 바이너리 데이터에 대한 컨텐츠 타입이다.
		setContentType("application/octet-stream");
		// 서버에 저장된 파일이름에서 앞의 36자리(uuid)를 제거한 후, 응답메세지의 헤더부에 다운로드되는 첨부파일의 이름으로 설정한다.
		String savedFilename = file.getName();
		String originalFilename = savedFilename.substring(36);			
		response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(originalFilename, "utf-8"));
		
		FileCopyUtils.copy(new FileInputStream(file), response.getOutputStream());		
	}
}
