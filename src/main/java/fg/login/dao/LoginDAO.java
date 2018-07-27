package fg.login.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import fg.common.dao.AbstractDAO;
import fg.vo.UserVO;

@Repository("loginDAO")
public class LoginDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public String getUserKey(Map<String, Object> info) {
		// TODO Auto-generated method stub
		return (String)selectOne("login.getUserKey", info);
	}
	
	public void makePlayer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("login.makePlayer", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getMakePercent(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("login.getMakePercent", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPlayerList(String key) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("login.getPlayerList", key);
	}

	public void removePlayerList(String key) {
		// TODO Auto-generated method stub
		delete("login.removePlayerList", key);
	}

	public String makeTeam(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("login.makeTeam", map);
		return (String)map.get("team_key");
	}

	public String getTeamKey(String team_name) {
		// TODO Auto-generated method stub
		return (String)selectOne("login.getTeamKey", team_name);
	}

	public void updatePlayers(Map<String, Object> param) {
		// TODO Auto-generated method stub
		update("login.updatePlayers", param);
	}

	public void updateUserInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		update("login.updateUserInfo", param);
	}

	public void editPlayerName(Map<String, Object> param) {
		// TODO Auto-generated method stub
		update("login.editPlayerName", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Integer> getPlayerTendency(String position) {
		// TODO Auto-generated method stub
		return (Map<String, Integer>)selectOne("login.getPlayerTendency", position);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Integer> getPlayerOverall(String position, String key) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("position", position);
		param.put("key", key);
		return (Map<String, Integer>)selectOne("login.getPlayerOverall", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> findUserInfo(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("login.findUserInfo", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> checkId(String id) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("login.checkId", id);
	}

	public void signupAction(Map<String, Object> param) {
		// TODO Auto-generated method stub
		insert("login.signupAction", param);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> checkName(String name) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("login.checkName", name);
	}

	public UserVO getUserInfo(Map<String, Object> info) {
		// TODO Auto-generated method stub
		return (UserVO) selectOne("login.getUserInfo", info);
	}
}