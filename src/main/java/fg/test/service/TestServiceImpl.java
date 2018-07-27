package fg.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import fg.login.dao.LoginDAO;
import fg.test.dao.TestDAO;

@Service("testService")
public class TestServiceImpl implements TestService{
	@Resource(name="testDAO")
    private TestDAO testDAO;

	@Resource(name="loginDAO")
    private LoginDAO loginDAO;
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public List<Map<String, Object>> getPlayerList(String key) throws Exception {
		// TODO Auto-generated method stub
		return testDAO.getPlayerList(key);
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
		return testDAO.getPlayerInfoDetail(key);
	}
}