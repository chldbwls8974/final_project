package kr.kh.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kh.final_project.pagination.Criteria;
import kr.kh.final_project.vo.ReportVO;

public interface ReportDAO {

	List<ReportVO> selectReportListBySearch(@Param("cri")Criteria cri, 
			@Param("reportType")String reportType, 
			@Param("searchType1")String searchType1, 
			@Param("searchType2")String searchType2);

	int selectReportListCountBySearch(@Param("cri")Criteria cri, 
			@Param("reportType")String reportType, 
			@Param("searchType1")String searchType1, 
			@Param("searchType2")String searchType2);

	boolean updateReportState(@Param("report")ReportVO report);


}
