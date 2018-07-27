package fg.manage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import fg.login.dao.LoginDAO;
import fg.manage.dao.ManageDAO;

@Service("manageService")
public class ManageServiceImpl implements ManageService{
	@Resource(name="manageDAO")
    private ManageDAO manageDAO;

	@Resource(name="loginDAO")
    private LoginDAO loginDAO;
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public List<Map<String, Object>> getPlayerList(String key) throws Exception {
		// TODO Auto-generated method stub
		return manageDAO.getPlayerList(key);
	}

	@Override
	public List<Map<String, Object>> getPlayerOverall(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		String key = "";
		String position = "";
		Object overall = 0;
		for(int i = 0;i < list.size();i++) {
			key = (String) list.get(i).get("player_key");
			position = (String) list.get(i).get("position_detail");
			overall = (Object) loginDAO.getPlayerOverall(position, key).get("average");
			
			list.get(i).put("overall", overall);
		}
		return list;
	}

	@Override
	public Map<String, Object> getPlayerInfoDetail(String key) throws Exception {
		// TODO Auto-generated method stub
		return manageDAO.getPlayerInfoDetail(key);
	}

	@Override
	public void saveSelectPosition(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		manageDAO.saveSelectPosition(list);
	}

	@Override
	public void resetSelectPosition() throws Exception {
		// TODO Auto-generated method stub
		manageDAO.resetSelectPosition();
	}
}