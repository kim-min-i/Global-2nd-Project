package pet.model.service;

import java.util.List;

import pet.model.dto.DocInfoDTO;
import pet.model.dto.DocMyHospitalDTO;
import pet.model.dto.DocPictureDTO;
import pet.model.dto.HospitalDTO;

public interface HospitalDAOService {
	
	// ���� ���� ����.
	public int getPictureCount() throws Exception;
	
	//doc_picture ���� ���� �� ������ ���� ������
	public List getDoc_picture(DocPictureDTO docPictureDto) throws Exception;

	// doc_info���� �ǻ縮��Ʈ ����.
	public List selectAll() throws Exception;
	
	// hospital DB����  �ߺ��̸� ��������
	public int getNameCount() throws Exception;
	
	// hospital DB����  �̸��� �ִ��� �˻�.
	public List nameList(HospitalDTO hospitalDto) throws Exception;

	// Myhospital�� ���Ͽ� �´� ���� ��ȣ ����.
	public void updateHospital(DocMyHospitalDTO docMyHospitalDto)  throws Exception;
	
	// doc_info�� ���� ��ȣ ����.
	public void updateDoc_info(DocInfoDTO docInfoDto) throws Exception;

	
	
}
