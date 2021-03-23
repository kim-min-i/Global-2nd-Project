package pet.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pet.model.dto.DocInfoDTO;
import pet.model.dto.DocMyHospitalDTO;
import pet.model.dto.DocPictureDTO;
import pet.model.dto.HospitalDTO;

@Service("hospitalDao")
public class HospitalDAOServiceImpl implements HospitalDAOService {

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Override	// ���� ����
	public int getPictureCount() throws Exception {
		return dao.selectOne("admin.getPictureCount");
	}
	
	@Override	// license, registration ������ ���� ���� ������
	public List getDoc_picture(DocPictureDTO docPictureDto) throws Exception {
		System.out.println("impl���� �Գ�?-> @Authwired�� ���� �������ֱ�.");
		return dao.selectList("admin.getDoc_picture", docPictureDto);
	}


	@Override
	public List selectAll() throws Exception {
		return dao.selectList("admin.selectAll");
	}

	@Override	// hospital DB �����̸� ��������
	public int getNameCount() throws Exception {
		return dao.selectOne("admin.getNameCount");
	}
	
	@Override	// ���� �̸� ��� ������.
	public List nameList(HospitalDTO hospitalDto) throws Exception {
		return dao.selectList("admin.nameList", hospitalDto);
	}

	@Override 	// Myhospital�� ���Ͽ� �´� ���� ��ȣ ����.
	public void updateHospital(DocMyHospitalDTO docMyHospitalDto) throws Exception {
		dao.update("admin.updateHospital", docMyHospitalDto );
	}

	@Override
	public void updateDoc_info(DocInfoDTO docInfoDto) throws Exception {
		dao.update("admin.updateDoc_info", docInfoDto);
	}



	

	
	
}
