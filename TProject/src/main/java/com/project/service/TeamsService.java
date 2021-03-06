package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.vo.ApplicationsVO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

public interface TeamsService {

	List<TeamsVO> selectList(Map<String, Object> searchMap);
	List<PartsVO> selectParts(int teamIdx);
	int register(TeamsVO vo, List<PartsVO> partsVOlist);
	TeamsVO details(int teamIdx);
	List<PartsVO> appNum(int teamIdx);
	int apply(ApplicationsVO vo);
	int delete(int teamIdx);
	int update(TeamsVO vo);
	List<TeamsVO> reglist(Map<String, Integer> endMap);
	int reglistCount(Map<String, Integer> endMap);
	List<ApplicationsVO> applist(Map<String, Integer> appMap);
	int applistCount(int mIdx);
	int finish(int teamIdx);
	List<ApplicationsVO> myapp(Map<String, Object> applistMap);
	int myappCount(int teamIdx);
	void updateStatus();
	int updateApp(ApplicationsVO vo);
	int deleteApp(int appIdx);
	int appCheck(ApplicationsVO vo);
}
