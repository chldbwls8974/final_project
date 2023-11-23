package kr.kh.final_project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.kh.final_project.dao.BusinessDAO;
import kr.kh.final_project.dao.FacilityDAO;
import kr.kh.final_project.dao.OperatingDAO;
import kr.kh.final_project.dao.PreferredRegionDAO;
import kr.kh.final_project.dao.RegionDAO;
import kr.kh.final_project.dao.StadiumDAO;
import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.util.UploadFileUtils;
import kr.kh.final_project.vo.AvailabilityVO;
import kr.kh.final_project.vo.BusinessmanVO;
import kr.kh.final_project.vo.FacilityPictureVO;
import kr.kh.final_project.vo.FacilityVO;
import kr.kh.final_project.vo.MemberVO;
import kr.kh.final_project.vo.OperatingVO;
import kr.kh.final_project.vo.RegionVO;
import kr.kh.final_project.vo.StadiumVO;

@Service
public class BusinessmanServiceImp implements BusinessmanService{
	
	@Autowired
	BusinessDAO businessDao;
	
	@Autowired
	RegionDAO regionDao;

	@Autowired
	PreferredRegionDAO prRegionDao;
	
	@Autowired
	StadiumDAO stadiumDao;
	
	@Autowired
	OperatingDAO operatingDao;

	@Autowired
	FacilityDAO facilityDao;
	
	String uploadPicturePath = "D:\\uploadfacility";

	//시설 리스트 가져오기
	@Override
	public List<FacilityVO> getFacilityList(MemberVO member, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		//다오에게 시설 리스트를 가져오라고 시키고
		List<FacilityVO> list = facilityDao.selectFacilityList(member, cri);
		//가져오면 반환
		return list;
	}
	//현재 페이지 정보에 맞는 전체 시설 수 가져오는 메서드
	@Override
	public int getTotalCount(Criteria cri, MemberVO member) {
		if(cri == null) {
			cri = new Criteria();
		}
		return facilityDao.selectCountFacilityList(cri, member);
	}
	//회원번호로 사업자정보 가져오기
	@Override
	public BusinessmanVO getBusinessmanByMeNum(Integer me_num) {
		return facilityDao.selectBusinessmanByMeNum(me_num);
	}	
	//시설 등록
	@Override
	public boolean insertFacility(MemberVO user, FacilityVO facility,  MultipartFile[] file) {
		//예외처리
		if(user == null
			|| facility == null
			|| facility.getFa_name() == null 
			|| facility.getFa_add() == null
			|| facility.getFa_add_detail() == null
			|| facility.getFa_phone() == null) {
			return false;
		}
		boolean res = facilityDao.insertFacility(facility, user.getMe_num());
		for(MultipartFile i : file) {
			if(i == null || i.getOriginalFilename().length() == 0) {
				continue;
			}
			try {
				String fp_ori_name = i.getOriginalFilename();
				String fp_name = UploadFileUtils.uploadFile(uploadPicturePath, fp_ori_name, i.getBytes());
				FacilityPictureVO fileVo = new FacilityPictureVO(facility.getFa_num(), fp_name, fp_ori_name);
				//업로드한 경로를 이용하여 다오에게 첨부파일 정보를 주면서 DB에 추가하라고 요청
				facilityDao.insertPicture(fileVo);
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
		return res;
	}
	//Main 지역리스트
	@Override
	public List<RegionVO> getMainRegion() {
		return regionDao.selectMainRegion();
	}
	//Region 리스트
	@Override
	public List<RegionVO> getSubRegionByMainRegion(String rg_main) {
		return regionDao.selectSubRegion(rg_main);
	}
	//시설 정보 수정
	@Override
	public boolean updateFacility(FacilityVO facility, BusinessmanVO business) {
		if(business == null || business.getBu_me_num() == 0) {
			return false;
		}
		if(facility == null || facility.getFa_bu_num() == null) {
			return false;
		}
		//시설 번호를 이용하여 시설 정보를 가져옴
		FacilityVO dbFacility = facilityDao.selectFacility(facility.getFa_num());
		//사업자번호가 같은지 확인 
		if(dbFacility == null || !dbFacility.getFa_bu_num().equals(business.getBu_num())) { 
			return false;
		}
		boolean res = facilityDao.updateFacility(facility);
		return res;
	}
	//시설번호로 시설 정보 가져오기
	@Override
	public FacilityVO getFacility(Integer fa_num) {
		if(fa_num == null) {
			return null;
		}
		return facilityDao.selectFacility(fa_num);
	}
	//시설 삭제
	@Override
	public boolean facilityDelete(Integer fa_num, MemberVO user, BusinessmanVO business) {
		if (fa_num == null) {
	        return false;
	    }
	    // 시설을 삭제한 것처럼 표시 (DB에는 실제로 삭제하지 않음)
	    int fa_deleted = facilityDao.facilityDelete(fa_num);
	    
	    if (fa_deleted == 1) {
	        //경기장 상태 '2:삭제'로 업데이트
	        stadiumDao.updateStadiumAvailability(fa_num);
	        //운영시간 삭제
	        operatingDao.deleteOperating(fa_num);
	        return true;
	    }
	    return false;
	}
	
	
	//운영시간
	@Override
	public List<OperatingVO> getOperatingListByFaNum(Integer fa_num) {
		if(fa_num == 0) {
			return null;			
		}
		List<OperatingVO> operatingList = operatingDao.selectOperatingListByFaNum(fa_num);
		return operatingList;
	}
	//운영시간 등록
	@Override
	public boolean insertOperating(List<OperatingVO> operatingList, int fa_num) {
		if(operatingList == null ){
				return false;
			}
		for(OperatingVO tmp : operatingList) {
			tmp.setOp_fa_num(fa_num);
			operatingDao.insertOperating(tmp);
		}
			return true;
	}
	//운영시간 수정
	@Override
	public boolean updateOperatingList(List<OperatingVO> operatingList, int fa_num) {
		if(operatingList == null) {
			return false;
		}
		//Dao를 통해 해당 시설번호(fa_num)의 운영시간 목록을 가져와서 dbOperating에 저장
		List<OperatingVO> dbOperating= operatingDao.selectOperatingListByFaNum(fa_num);
		if(dbOperating == null) { 
			return false;
		}
		// 변경된 운영 시간만 업데이트
	    for (OperatingVO newTmp : operatingList) {
	    	newTmp.setOp_fa_num(fa_num);
	        for (OperatingVO dbTmp : dbOperating) {
	            if (newTmp.getOp_day().equals(dbTmp.getOp_day())) {
	                operatingDao.updateOperatingList(newTmp, fa_num);
	            }
	        }
	    }
	    return true;
	}
	
	
	//시설번호로 경기장 리스트 가져오기
	@Override
	public List<StadiumVO> getStadiumList(Integer fa_num, Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		List<StadiumVO> stadiumList = stadiumDao.selectStadiumList(fa_num, cri);
		//가져오면 반환
		return stadiumList;
	}
	//현재 페이지 정보(검색어, 타입)에 맞는 전체 경기장 수를 가져옴
	@Override
	public int getTotalStadiumCount(Criteria cri, Integer fa_num) {
		if(cri == null) {
			cri = new Criteria();
		}
		return stadiumDao.selectCountStadiumList(cri, fa_num);
	}
	//경기장 등록
	@Override
	public boolean insertStadium(StadiumVO stadium, AvailabilityVO availability) {
		if(stadium== null 
			|| stadium.getSt_name() == null 
			|| stadium.getSt_locate() == null
			|| stadium.getSt_width() == 0 
			|| stadium.getSt_height() == 0
			|| stadium.getSt_max() == 0		
			|| stadium.getSt_fa_num() == 0) {
			return false;
		}
		boolean insertStadiumInfo = stadiumDao.insertStadium(stadium);
		availability.setAv_st_num(stadium.getSt_num());
		boolean insertAvailabilityInfo = stadiumDao.insertAvailability(availability);
		return insertStadiumInfo;
	}
	//경기장번호로 경기장 정보가져오기
	@Override
	public StadiumVO getStadium(Integer st_num) {
	    if (st_num == null) {
	        return null;
	    }
	    StadiumVO stadium = stadiumDao.selectStadium(st_num);
	    if (stadium != null) {
	        AvailabilityVO availability = stadiumDao.selectAvailability(st_num);
	        stadium.setAvailability(availability);
	    }
	    return stadium;
	}
	//경기장 정보 수정
	public boolean updateStadium(StadiumVO stadium, AvailabilityVO availability) {
		if(stadium == null || stadium.getSt_num() == null) {
			return false;
		}
		//경기장 번호를 이용하여 경기장 정보를 가져옴
		StadiumVO dbStadium = stadiumDao.selectStadium(stadium.getSt_num());
		//경기장 정보에서 경기장의 시설 번호와 시설 번호가 같은지 확인 
		if(dbStadium == null) { 
			return false;
		}
		if(stadium.getSt_available() == 0 || stadium.getSt_available() == 2) {
	        boolean deleteAvailabilityInfo = stadiumDao.deleteAvailability(stadium.getSt_num());
		}
		boolean res = stadiumDao.updateStadium(stadium);
		
		availability.setAv_st_num(stadium.getSt_num());
		boolean updateAvailabilityInfo = stadiumDao.updateAvailability(availability);
		return res;
	}
	
	@Override
	public List<FacilityPictureVO> getFacilityPictureList(Integer fa_num) {
		return facilityDao.selectFacilityPictureList(fa_num);
	}
	@Override
	public List<StadiumVO> selectAllStadium() {
		return stadiumDao.selectAllStadiumList();
	}
	@Override
	public AvailabilityVO getAvailability(Integer st_num) {
		return stadiumDao.selectAvailability(st_num);
	}
	
	
	@Override
	public void updateFacilityPicture(FacilityVO facility,MultipartFile[] file, int[] delNums) {
		deletePicture(facility.getFa_num(),delNums);
		updatePicture(facility.getFa_num(),file);
	}
	
	
	private void updatePicture(Integer fa_num, MultipartFile[] file) {
		if (file == null || file.length == 0) {
			return;
		}

		for (MultipartFile i : file) {
			if (i == null || i.getOriginalFilename().length() == 0) {
				continue;
			}
			try {
				String fp_ori_name = i.getOriginalFilename();
				String fp_name = UploadFileUtils.uploadFile(uploadPicturePath, fp_ori_name, i.getBytes());
				FacilityPictureVO fileVo = new FacilityPictureVO(fa_num, fp_name, fp_ori_name);
				// 업로드한 경로를 이용하여 다오에게 첨부파일 정보를 주면서 DB에 추가하라고 요청
				facilityDao.insertPicture(fileVo);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
	
	private void deletePicture(Integer fa_num, int[] delNums) {
		if (delNums == null || delNums.length == 0) {
			return;
		}
		for (int j : delNums) {
			facilityDao.deletePicture(j);
		}
	}
	@Override
	public BusinessmanVO getBusinessmanByBuNum(Integer fa_bu_num) {
	if(fa_bu_num ==0) {
		return null;
	}
		return businessDao.selectBusinessManByFaBuNum(fa_bu_num);
	}
	@Override
	public FacilityVO selectFacilityByMeNum(Integer me_num, Integer fa_num) {
		if(me_num == null || fa_num == 0 || fa_num == null) {
			return null;
		}
		return facilityDao.selectFacilityByMeNum(me_num, fa_num);
	}
	@Override
	public StadiumVO selectStadiumByMeNum(Integer me_num, Integer st_num) {
		if(me_num == null || st_num == 0 || st_num == null) {
			return null;
		}
		return stadiumDao.selectStadiumByMeNum(me_num, st_num);
	}


}
